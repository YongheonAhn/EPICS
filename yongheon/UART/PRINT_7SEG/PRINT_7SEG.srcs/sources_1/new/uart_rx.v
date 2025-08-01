`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/31 21:07:38
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
module uart_rx(
    input clk,
    input rst,
    input rx,
    output reg [7:0] data_out,
    output reg data_valid
);
    parameter CLK_FREQ = 50000000;
    parameter BAUD_RATE = 115200;
    localparam CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;

    reg [15:0] clk_cnt = 0;
    reg [3:0] bit_index = 0;
    reg [9:0] rx_shift = 0;
    reg rx_busy = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_cnt <= 0;
            bit_index <= 0;
            data_out <= 0;
            data_valid <= 0;
            rx_busy <= 0;
        end else begin
            data_valid <= 0;
            if (!rx_busy && !rx) begin
                rx_busy <= 1;
                clk_cnt <= CLKS_PER_BIT / 2;
                bit_index <= 0;
            end else if (rx_busy) begin
                if (clk_cnt == CLKS_PER_BIT - 1) begin
                    clk_cnt <= 0;
                    rx_shift[bit_index] <= rx;
                    if (bit_index == 9) begin
                        rx_busy <= 0;
                        data_out <= rx_shift[8:1];
                        data_valid <= 1;
                    end else begin
                        bit_index <= bit_index + 1;
                    end
                end else begin
                    clk_cnt <= clk_cnt + 1;
                end
            end
        end
    end
endmodule
