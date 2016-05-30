`timescale 1ns / 1ps

`define CONT	2'b00
`define DISP	2'b01
`define BLINK	2'b10

module frecuencia(modo,clk_in,clk_out);

	input clk_in;
	input [1:0] modo;
	output reg clk_out;

	reg clk_out_s;
	reg [23:0] contador = 24'd0;
	reg [23:0] contador_s = 24'd0;
	
	always @(*)
		case (modo)
			`CONT: contador_s = (contador == 24'd1000000)?(24'd0):(contador+24'd1);
			`DISP: contador_s = (contador == 24'd100000)?(24'd0):(contador+24'd1);
			`BLINK: contador_s = (contador == 24'd5000000)?(24'd0):(contador+24'd1);
			default: contador_s = (contador == 24'd1000000)?(24'd0):(contador+24'd1);
		endcase
	
	always @(posedge clk_in)
		contador <= contador_s;
		
			
	always @(*)
		if ((24'd0 <= contador)&&(contador <= 24'd2))
			clk_out_s = 1'b1;
		else
			clk_out_s = 1'b0;

	always @(posedge clk_in)
		clk_out <= clk_out_s;

endmodule
