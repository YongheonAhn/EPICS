`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/07/31 18:14:25
// Design Name: 
// Module Name: top_uart_lcd
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
module top_uart_lcd (
    input clk,
    input rst,
    input rx,
    output lcd_en,
    output lcd_rs,
    output lcd_rw,
    output [7:0] lcd_data
);
    // UART
    wire [7:0] rx_data;
    wire rx_valid;
    wire rst = 1'b0;

    wire [7:0] lcd_data_init, lcd_data_write;
    wire lcd_en_init, lcd_rs_init, lcd_rw_init;
    wire lcd_en_write, lcd_rs_write, lcd_rw_write;
    wire lcd_ready;  // from lcd_init_controller

    // Ï∂úÎ†• ?Ñ†?Éù (readyÍ∞? 0?ù¥Î©? Ï¥àÍ∏∞?ôîÍ∞? LCDÎ•? ?†ú?ñ¥)
    assign lcd_en  = lcd_ready ? lcd_en_write  : lcd_en_init;
    assign lcd_rs  = lcd_ready ? lcd_rs_write  : lcd_rs_init;
    assign lcd_rw  = lcd_ready ? lcd_rw_write  : lcd_rw_init;
    assign lcd_data = lcd_ready ? lcd_data_write : lcd_data_init;

    // LCD Î≤ÑÌçº
    wire [5:0] addr;
    wire [7:0] char_out;
    wire [5:0] size;

    // ?îîÎ≤ÑÍπÖ?ö© ILA ?îÑÎ°úÎ∏å
    wire [7:0] debug_lcd_data = lcd_data_init;
    wire debug_lcd_en = lcd_en_init;
    wire debug_lcd_rs = lcd_rs_init;

    uart_rx uart (.clk(clk), .rst(rst), .rx(rx), .data(rx_data), .valid(rx_valid));

    char_buffer buffer (
        .clk(clk), .rst(rst),
        .in_data(rx_data), .in_valid(rx_valid),
        .out_data(char_out),
        .out_addr(addr),     
        .size(size)
    );


    lcd_init_controller lcd_init (
        .clk(clk), .rst(rst),
        .lcd_en(lcd_en_init),
        .lcd_rs(lcd_rs_init),
        .lcd_rw(lcd_rw_init),
        .lcd_data(lcd_data_init),
        .ready(lcd_ready)
    );

    lcd_writer writer (
        .clk(clk), .rst(rst),
        .ready(lcd_ready),
        .data_in(char_out),
        .addr_out(addr),
        .size(size),
        .lcd_en(lcd_en_write),
        .lcd_rs(lcd_rs_write),
        .lcd_rw(lcd_rw_write),
        .lcd_data(lcd_data_write)
    );

    ila_0 ila_inst (
        .clk(clk),
        .probe0(debug_lcd_data),
        .probe1(debug_lcd_en),
        .probe2(debug_lcd_rs)
    );
    
endmodule
