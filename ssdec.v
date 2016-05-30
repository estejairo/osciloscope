////////////////////////////////////////////////////////////////////////////////
// ssdec.v -- seven segment decoder
//
// Author:  W. Freund, UTFSM, Valparaiso, Chile
//          03/16/06
////////////////////////////////////////////////////////////////////////////////
module ssdec(val, pt, type, ssg); 
	input [3:0] val; 			// binary value
	input pt, type; 			// point, display type (0: anode, 1: cathode)
	output [7:0] ssg;			// segments

	assign ssg = ((type == 1) ? 8'h0 : 8'hff) ^ (
			(val == 0) ? {pt, 7'b0111111} :
			(val == 1) ? {pt, 7'b0000110} :
			(val == 2) ? {pt, 7'b1011011} :
			(val == 3) ? {pt, 7'b1001111} :
			(val == 4) ? {pt, 7'b1100110} :
			(val == 5) ? {pt, 7'b1101101} :
			(val == 6) ? {pt, 7'b1111101} :
			(val == 7) ? {pt, 7'b0000111} :
			(val == 8) ? {pt, 7'b1111111} : 
			(val == 9) ? {pt, 7'b1101111} :
			(val == 10) ? {pt, 7'b1110111} :
			(val == 11) ? {pt, 7'b1111100} :
			(val == 12) ? {pt, 7'b1011000} :
			(val == 13) ? {pt, 7'b1011110} :
			(val == 14) ? {pt, 7'b1111001} : 
			{pt, 7'b1110001});

endmodule
