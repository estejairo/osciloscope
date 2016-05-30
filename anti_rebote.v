`timescale 1ns / 1ps

module anti_rebote(clk,reset,entrada_sincronica,salida_desrebotada);

	input clk,reset,entrada_sincronica;
	output reg salida_desrebotada;

	reg salida_desrebotada_s;
	reg [22:0] contador = 23'd0;
	reg [22:0] contador_s;
	
	//Control del contador
	always@(*)
			if (entrada_sincronica)
				if (contador == 23'd5000000)
					contador_s = contador;
				else
					contador_s = contador + 23'd1;
			else
				contador_s = 23'd0;

		
	always@(posedge clk or posedge reset)
		if (reset) 
			contador <= 23'd0;
		else
			contador <= contador_s;
	
	
	//Control de la salida
	always @(*)
		if (contador == 23'd5000000)
			salida_desrebotada_s = 1'b1;
		else
			salida_desrebotada_s = 1'b0;
			
	always @(posedge clk or posedge reset)
		if (reset)
			salida_desrebotada <= 1'b0;
		else
			salida_desrebotada <= salida_desrebotada_s;
	
	
endmodule