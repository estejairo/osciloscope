`timescale 1ns / 1ps

`define POSICION_DEFAULT 11'd384	//posicion inicial, por defecto
`define SPACE 11'd12				//cuantos pixeles avanza la linea
`define END_TOP 11'd12				//limite superior
`define END_BOT 11'd756				//limite inferior

module barra_movil_horizontal(clk_fpga, rst, btn_up, btn_down, vc_visible, in_horizontal_line);

	input clk_fpga, rst, btn_up, btn_down;
	input [10:0] vc_visible;
	output in_horizontal_line;

	//Tratar las seales de entrada
	//btn_left
 	sincronizador boton_up_sincronico(clk_fpga,rst,btn_up,btn_up_sincronico);
 	anti_rebote boton_up_debounced(clk_fpga,rst,btn_up_sincronico,btn_up_debounced);
 	//btn_right
	sincronizador boton_down_sincronico(clk_fpga,rst,btn_down,btn_down_sincronico);
 	anti_rebote boton_down_debounced(clk_fpga,rst,btn_down_sincronico,btn_down_debounced);

 	//Calcular la posicion siguiente
	reg [10:0] posicion_vertical_next;
	reg [10:0] posicion_vertical = `POSICION_DEFAULT;
 	always @(*) 
 		case({btn_up_debounced,btn_down_debounced})
 			2'b01: posicion_vertical_next = (posicion_vertical==`END_BOT)?posicion_vertical:posicion_vertical + `SPACE;
 			2'b10: posicion_vertical_next = (posicion_vertical==`END_TOP)?posicion_vertical:posicion_vertical - `SPACE;
 			default: posicion_vertical_next = posicion_vertical;
 		endcase

 	//Asignar la posicion siguiente
 	always @(posedge clk_fpga or posedge rst)
 		if (rst)
 			posicion_vertical <= `POSICION_DEFAULT;
 		else
 			posicion_vertical <= posicion_vertical_next;
 	
 	//Indicar si se est en la linea
	assign in_horizontal_line=(vc_visible==posicion_vertical);

endmodule 


