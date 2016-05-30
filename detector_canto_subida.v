`timescale 1ns / 1ps

module detector_canto_subida(clk,reset,entrada_sincronica_desrebotada,deteccion_canto);

	input clk, reset, entrada_sincronica_desrebotada;
	output deteccion_canto;
	
	reg [1:0] flip_flops = 2'd0;
	
	always@(posedge clk or posedge reset)
	begin
	
		if(reset)
			flip_flops <= 2'd0;
		else 	
			flip_flops <= {flip_flops[0],entrada_sincronica_desrebotada};
	end
	
	assign deteccion_canto = (flip_flops[0]&&(~flip_flops[1]));


endmodule
