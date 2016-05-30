`timescale 1ns / 1ps

module sincronizador(clk,reset,entrada_asincronica,salida_sincronica);

	input clk,reset,entrada_asincronica;
	output salida_sincronica;
	
	reg[2:0] flip_flops = 3'd0;
	
	
	always@ (posedge clk or posedge reset)
	begin
	
		if (reset) 
			flip_flops <= 3'd0;
			
		else flip_flops <= {flip_flops[1],flip_flops[0],entrada_asincronica};

	end
	
	assign salida_sincronica = flip_flops[2];
endmodule

