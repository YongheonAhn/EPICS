module lcd_writer (
    input clk,
    input rst,
    input ready,  // from lcd_init
    input [7:0] data_in,
    input [5:0] size,
    output reg [5:0] addr_out,
    output reg lcd_en,
    output reg lcd_rs,
    output reg lcd_rw,
    output reg [7:0] lcd_data
);
    reg [31:0] cnt = 0;
    localparam DELAY = 50000;
    reg [5:0] index = 0;
    reg [2:0] state = 0;

    always @(posedge clk) begin
        if (rst) begin
            index <= 0;
            cnt <= 0;
            state <= 0;
            lcd_en <= 0;
            lcd_rw <= 0;
            lcd_rs <= 1;
            addr_out <= 0;
        end else if (ready) begin
            cnt <= cnt + 1;
            case (state)
                0: begin  // set cursor
                    lcd_rs <= 0;
                    lcd_rw <= 0;
                    if (index == 0)
                        lcd_data <= 8'h80; // line 1 start
                    else if (index == 16)
                        lcd_data <= 8'hC0; // line 2 start
                    lcd_en <= 1;
                    if (cnt > DELAY) state <= 1;
                end
                1: begin
                    lcd_en <= 0;
                    cnt <= 0;
                    state <= 2;
                end
                2: begin  // write data
                    if (index < size) begin
                        lcd_rs <= 1;
                        lcd_data <= data_in;
                        lcd_en <= 1;
                        state <= 3;
                    end
                end
                3: begin
                    if (cnt > DELAY) begin
                        lcd_en <= 0;
                        index <= index + 1;
                        addr_out <= index + 1;
                        state <= 0;
                        cnt <= 0;
                    end
                end
            endcase
        end
    end
endmodule
