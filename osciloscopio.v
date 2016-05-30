`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:       Mauricio Solis
// 
// Create Date:    23:41:02 05/27/2016 
// Design Name: 
// Module Name:    osciloscopio 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module osciloscopio(clk_fpga, rst, btns, kd, kc, hs, vs, RGB_O, GREEN_O, BLUE_O);

	input clk_fpga,rst;
	input [3:0] btns;
	output reg [3:0] RGB_O, GREEN_O, BLUE_O;
	wire ev_up_pe, ev_down_pe, ev_ok_pe; //eventos (por botones o teclado) con deteccin de canto
	wire ev_left_pe, ev_right_pe;
	/**
	* Recuerde hacer la instancia del DCM
	*/
	menu_osciloscopio_state m_menu_state(clk, rst, ev_up_pe, ev_down_pe, ev_ok_pe, osc_menu_state);

endmodule

/**
* Estos son los estados por lo que pasa el menu
*/
`define OSC_MENU_ANCHO_SIN_OPCIONES		4'b0001
`define OSC_MENU_ANCHO_CON_OPCIONES		4'b0010
`define OSC_MENU_COLOR_SIN_OPCIONES		4'b0011
`define OSC_MENU_COLOR_CON_OPCIONES		4'b0100
`define OSC_MENU_COLOR_FONDO				4'b0101
`define OSC_MENU_COLOR_SENAL				4'b0110
`define OSC_MENU_XN_SIN_OPCIONES			4'b0111
`define OSC_MENU_XN_CON_OPCIONES			4'b1000
`define OSC_MENU_YN_SIN_OPCIONES			4'b1001
`define OSC_MENU_YN_CON_OPCIONES			4'b1010

/*
Estos son los valores de las variables asociadas a cada set de 
opciones dentro de cada menu desplegado
*/

`define OPCION_ANCHO_1					3'b001
`define OPCION_ANCHO_2					3'b010
`define OPCION_ANCHO_3					3'b011
`define OPCION_ANCHO_VOLVER			3'b100

`define OPCION_COLOR_FONDO				2'b01
`define OPCION_COLOR_SENAL				2'b10
`define OPCION_COLOR_VOLVER			2'b11

`define OPCION_COLOR_FONDO_1			3'b001
`define OPCION_COLOR_FONDO_2			3'b010
`define OPCION_COLOR_FONDO_3			3'b011
`define OPCION_COLOR_FONDO_4			3'b100
`define OPCION_COLOR_FONDO_VOLVER	3'b101

`define OPCION_COLOR_SENAL_1			3'b001
`define OPCION_COLOR_SENAL_2			3'b010
`define OPCION_COLOR_SENAL_3			3'b011
`define OPCION_COLOR_SENAL_4			3'b100
`define OPCION_COLOR_SENAL_VOLVER	3'b101

`define OPCION_XN_CURSOR_1				2'b01
`define OPCION_XN_CURSOR_2				2'b10
`define OPCION_XN_VOLVER				2'b11

`define OPCION_YN_CURSOR_1				2'b01
`define OPCION_YN_CURSOR_2				2'b10
`define OPCION_YN_VOLVER				2'b11		

module menu_osciloscopio_state(clk, rst, ev_up_pe, ev_down_pe, ev_ok_pe, osc_menu_state);
	input clk, rst;
	input ev_up_pe, ev_down_pe, ev_ok_pe;
	output [3:0]osc_menu_state;

	reg [3:0] osc_menu_state, osc_menu_state_sig;
	reg [2:0] var_op_ancho, var_op_ancho_sig;
	reg [1:0] var_op_color, var_op_color_sig;
	reg [2:0] var_op_color_fondo, var_op_color_fondo_sig;
	reg [2:0] var_op_color_senal, var_op_color_senal_sig;
	reg [1:0] var_op_xn, var_op_xn_sig;
	reg [1:0] var_op_yn, var_op_yn_sig;
	
/*************** Cambios de estado para el men principal***************/
	always@(*)
		case(osc_menu_state)
			`OSC_MENU_ANCHO_SIN_OPCIONES: osc_menu_state_sig = (ev_ok_pe)?`OSC_MENU_ANCHO_CON_OPCIONES:osc_menu_state;
			`OSC_MENU_ANCHO_CON_OPCIONES: osc_menu_state_sig = ....
			`OSC_MENU_COLOR_SIN_OPCIONES: osc_menu_state_sig = ....
			`OSC_MENU_COLOR_CON_OPCIONES: osc_menu_state_sig = ....
			`OSC_MENU_COLOR_FONDO: osc_menu_state_sig = ....
			`OSC_MENU_COLOR_SENAL: osc_menu_state_sig = ....	
			`OSC_MENU_XN_SIN_OPCIONES: osc_menu_state_sig = ....
			`OSC_MENU_XN_CON_OPCIONES: osc_menu_state_sig = ....
			`OSC_MENU_YN_SIN_OPCIONES: osc_menu_state_sig = ....
			`OSC_MENU_YN_CON_OPCIONES: osc_menu_state_sig = ....
			default: ....
		endcase
/***********************************************************************/

/*******Cambios de estado para la variable encargada del ancho *********/	
	always@(*)
		if(osc_menu_state == `OSC_MENU_ANCHO_CON_OPCIONES)
			case(var_op_ancho)
				OPCION_ANCHO_1:var_op_ancho_sig = ....
				OPCION_ANCHO_2:var_op_ancho_sig = ....
				OPCION_ANCHO_3:var_op_ancho_sig = ....
				OPCION_ANCHO_VOLVER: var_op_ancho_sig = ....
				default var_op_ancho_sig = ...
			endcase
		else
			var_op_ancho_sig = `OPCION_ANCHO_1;
/***********************************************************************/
	
	always@(posedge clk or posedge rst)
		if(rst)
			...
		else
		begin
			osc_menu_state <= osc_menu_state_sig;
			var_op_ancho <= var_op_ancho_sig;
			.....
		end		
endmodule
