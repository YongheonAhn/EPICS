`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/31 18:37:07
// Design Name: 
// Module Name: lcd_init_controller
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

module lcd_init_controller (
    input clk,
    input rst,
    output reg lcd_en,
    output reg lcd_rs,
    output reg lcd_rw,
    output reg [7:0] lcd_data,
    output reg ready  // 초기화 완료 플래그
);
    reg [2:0] state = 0;
    reg [31:0] cnt = 0;
    localparam DELAY = 500000;  // 약 10ms @ 50MHz

    always @(posedge clk) begin
        if (rst) begin
            state <= 0;
            cnt <= 0;
            lcd_en <= 0;
            lcd_rs <= 0;
            lcd_rw <= 0;
            lcd_data <= 8'h00;
            ready <= 0;
        end else begin
            cnt <= cnt + 1;
            case (state)
                0: begin // Function Set (0x38)
                    if (cnt == DELAY) begin
                        lcd_data <= 8'h38; lcd_en <= 1;
                    end else if (cnt == DELAY + 10) begin
                        lcd_en <= 0; state <= 1; cnt <= 0;
                    end
                end
                1: begin // Display ON (0x0C)
                    if (cnt == DELAY) begin
                        lcd_data <= 8'h0C; lcd_en <= 1;
                    end else if (cnt == DELAY + 10) begin
                        lcd_en <= 0; state <= 2; cnt <= 0;
                    end
                end
                2: begin // Clear Display (0x01)
                    if (cnt == DELAY) begin
                        lcd_data <= 8'h01; lcd_en <= 1;
                    end else if (cnt == DELAY + 10) begin
                        lcd_en <= 0; state <= 3; cnt <= 0;
                    end
                end
                3: begin // Entry Mode (0x06)
                    if (cnt == DELAY) begin
                        lcd_data <= 8'h06; lcd_en <= 1;
                    end else if (cnt == DELAY + 10) begin
                        lcd_en <= 0; state <= 4; cnt <= 0;
                    end
                end
                4: begin
                    ready <= 1;  // 초기화 완료
                end
            endcase
        end
    end
endmodule

