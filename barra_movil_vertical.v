`timescale 1ns / 1ps

`define POSICION_DEFAULT 11'd512	//posicion inicial, por defecto
`define SPACE 11'd16				//cuantos pixeles avanza la linea
`define END_RIGHT 11'd1008			//limite derecho
`define END_LEFT 11'd16				//limite izquierdo

module barra_movil_vertical(clk_fpga, rst, btn_left, btn_right, hc_visible, in_vertical_line);

	input clk_fpga, rst, btn_right, btn_left;
	input [10:0] hc_visible;
	output in_vertical_line;

	//Tratar las seales de entrada
	//btn_left
 	sincronizador boton_left_sincronico(clk_fpga,rst,btn_left,btn_left_sincronico);
 	anti_rebote boton_left_debounced(clk_fpga,rst,btn_left_sincronico,btn_left_debounced);
 	//btn_right
	sincronizador boton_right_sincronico(clk_fpga,rst,btn_right,btn_right_sincronico);
 	anti_rebote boton_right_debounced(clk_fpga,rst,btn_right_sincronico,btn_right_debounced);

 	//Calcular la posicion siguiente
	reg [10:0] posicion_horizontal_next;
	reg [10:0] posicion_horizontal;
 	always @(*) 
 		case({btn_left_debounced,btn_right_debounced})
 			2'b01: posicion_horizontal_next = (posicion_horizontal==`END_RIGHT)?posicion_horizontal + `SPACE:posicion_horizontal;
 			2'b10: posicion_horizontal_next = (posicion_horizontal==`END_LEFT)?posicion_horizontal - `SPACE:posicion_horizontal;
 			default: posicion_horizontal_next = posicion_horizontal;
 		endcase

 	//Asignar la posicion siguiente
 	always @(posedge clk_fpga or posedge rst)
 		if (rst)
 			posicion_horizontal <= `POSICION_DEFAULT;
 		else
 			posicion_horizontal <= posicion_horizontal_next;
 	
 	//Indicar si se est en la linea
	assign in_vertical_line=(hc_visible==posicion_horizontal);


endmodule