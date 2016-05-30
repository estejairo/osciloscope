/*
* clk:		display cathodes select.
* num:		num to show in display
* type:		Cathode or Anode
* pts:		The displays points led
* ssg:		The segment to turn_on/off, in actual 7segment selected by dctl
* dctl:		Display control or cathodes/anodes select.
*/

`define COMMON_ANODE		0
`define COMMON_CATHODE		1


module display(clk,num,type,pts,ssg,dctl);
    input clk;
    input [23:0] num;
    input type;
    input [5:0]pts;
    output [7:0]ssg;
    output [5:0]dctl;

    reg [5:0]dctl_sig;
    reg [5:0]dctl_tmp; //<---atento aqui, estaba seteado en cero, se quito el seteo
    wire [3:0]val;
    wire pt;

    always@(*)
        case (dctl_tmp)// common_cathode
            6'b111110:dctl_sig=6'b111101;
            6'b111101:dctl_sig=6'b111011;
            6'b111011:dctl_sig=6'b110111;
				6'b110111:dctl_sig=6'b101111;
				6'b101111:dctl_sig=6'b011111;
            default:dctl_sig=6'b111110;
        endcase

    always@(posedge clk)
        dctl_tmp<=dctl_sig;

    assign dctl=(type==`COMMON_CATHODE)?{~dctl_tmp}:dctl_tmp;//Por alguna extraa razn parece ser que los ctodos estn negados.

    assign {val,pt}=(dctl_tmp==6'b111110)?{num[3:0],pts[0]}:
                    (dctl_tmp==6'b111101)?{num[7:4],pts[1]}:
                    (dctl_tmp==6'b111011)?{num[11:8],pts[2]}:
						  (dctl_tmp==6'b110111)?{num[15:12],pts[3]}:
						  (dctl_tmp==6'b101111)?{num[19:16],pts[4]}:{num[23:20],pts[5]};

    ssdec m_ssdec(val, pt, type, ssg);

endmodule
