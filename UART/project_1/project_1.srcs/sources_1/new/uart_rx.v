`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/31 18:13:10
// Design Name: 
// Module Name: uart_rx
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
// uart_rx.v
module uart_rx #(
    parameter CLK_FREQ = 50000000,  // 보드 클럭 (예: 50MHz)
    parameter BAUD_RATE = 115200
)(
    input clk,
    input rst,
    input rx,              // UART RX 입력
    output reg [7:0] data, // 수신한 바이트
    output reg valid       // 수신 완료 플래그
);
    localparam CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;

    reg [15:0] clk_cnt = 0;
    reg [3:0] bit_idx = 0;
    reg [7:0] rx_shift = 0;
    reg rx_d1, rx_d2;
    reg busy = 0;

    always @(posedge clk) begin
        rx_d1 <= rx;
        rx_d2 <= rx_d1;
    end

    reg [1:0] state = 0;
    localparam IDLE=0, START=1, DATA=2, STOP=3;

    always @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
            valid <= 0;
            busy <= 0;
        end else begin
            case (state)
                IDLE: begin
                    valid <= 0;
                    if (rx_d2 == 0) begin  // start bit 감지
                        clk_cnt <= 0;
                        bit_idx <= 0;
                        state <= START;
                    end
                end
                START: begin
                    if (clk_cnt == (CLKS_PER_BIT/2)) begin
                        clk_cnt <= 0;
                        state <= DATA;
                    end else
                        clk_cnt <= clk_cnt + 1;
                end
                DATA: begin
                    if (clk_cnt == CLKS_PER_BIT-1) begin
                        clk_cnt <= 0;
                        rx_shift[bit_idx] <= rx_d2;
                        bit_idx <= bit_idx + 1;
                        if (bit_idx == 7)
                            state <= STOP;
                    end else
                        clk_cnt <= clk_cnt + 1;
                end
                STOP: begin
                    if (clk_cnt == CLKS_PER_BIT-1) begin
                        clk_cnt <= 0;
                        data <= rx_shift;
                        valid <= 1;
                        state <= IDLE;
                    end else
                        clk_cnt <= clk_cnt + 1;
                end
            endcase
        end
    end
endmodule

