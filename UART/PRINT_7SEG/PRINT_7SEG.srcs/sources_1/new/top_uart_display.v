`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/31 21:08:50
// Design Name: 
// Module Name: top_uart_display
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module top_uart_display(
    input clk,
    input rst,
    input rx,
    output reg [7:0] seg,
    output reg [7:0] digit
);

    wire [7:0] rx_data;
    wire rx_valid;

    reg [3:0] display_buf[7:0];  // 화면에 출력할 8자리 숫자 저장용
    reg [2:0] scan_idx = 0;      // 0~7까지 순환하며 digit 선택
    reg [15:0] refresh_cnt = 0;  // 디스플레이 refresh 타이머

    // UART 수신
    uart_rx uart_inst (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .data_out(rx_data),
        .data_valid(rx_valid)
    );

    // 문자 수신 시 숫자일 경우 시프트하여 저장
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            display_buf[0] <= 0; display_buf[1] <= 0;
            display_buf[2] <= 0; display_buf[3] <= 0;
            display_buf[4] <= 0; display_buf[5] <= 0;
            display_buf[6] <= 0; display_buf[7] <= 0;
        end else if (rx_valid) begin
            if (rx_data >= "0" && rx_data <= "9") begin
                // 시프트
                display_buf[7] <= display_buf[6];
                display_buf[6] <= display_buf[5];
                display_buf[5] <= display_buf[4];
                display_buf[4] <= display_buf[3];
                display_buf[3] <= display_buf[2];
                display_buf[2] <= display_buf[1];
                display_buf[1] <= display_buf[0];
                display_buf[0] <= rx_data - "0";
            end
        end
    end

    // 간단한 디코더
    function [7:0] seg_decode;
        input [3:0] val;
        case (val)
            4'd0: seg_decode = 8'b11000000;
            4'd1: seg_decode = 8'b11111001;
            4'd2: seg_decode = 8'b10100100;
            4'd3: seg_decode = 8'b10110000;
            4'd4: seg_decode = 8'b10011001;
            4'd5: seg_decode = 8'b10010010;
            4'd6: seg_decode = 8'b10000010;
            4'd7: seg_decode = 8'b11111000;
            4'd8: seg_decode = 8'b10000000;
            4'd9: seg_decode = 8'b10010000;
            default: seg_decode = 8'b11111111;
        endcase
    endfunction

    // 다이나믹 디스플레이 scan
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            refresh_cnt <= 0;
            scan_idx <= 0;
        end else begin
            refresh_cnt <= refresh_cnt + 1;
            if (refresh_cnt == 0) begin
                scan_idx <= scan_idx + 1;
            end
        end
    end

    always @(*) begin
        seg = seg_decode(display_buf[scan_idx]);
        digit = ~(8'b00000001 << scan_idx);  // Active High → Digit 선택
    end
endmodule

