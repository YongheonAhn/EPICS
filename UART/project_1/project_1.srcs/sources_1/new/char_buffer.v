`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/31 18:40:07
// Design Name: 
// Module Name: char_buffer
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

module char_buffer (
    input clk,
    input rst,
    input [7:0] in_data,
    input in_valid,
    output reg [7:0] out_data,
    output reg [5:0] out_addr,  // 0~31
    output reg [5:0] size,      // current size
    output reg full
);
    reg [7:0] buffer [0:31];
    reg [5:0] wr_ptr = 0;

    always @(posedge clk) begin
        if (rst) begin
            wr_ptr <= 0;
            size <= 0;
            full <= 0;
        end else if (in_valid && !full) begin
            buffer[wr_ptr] <= in_data;
            wr_ptr <= wr_ptr + 1;
            size <= size + 1;
            if (wr_ptr == 31) full <= 1;
        end
    end

    always @(*) begin
        out_data = buffer[out_addr];
    end
endmodule

