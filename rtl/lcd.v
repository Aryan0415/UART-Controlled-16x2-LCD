module LCD(input clk,input clr,input rx,output reg [7:0]data,output reg rs,output reg rw,output reg e ,output reg [5:0]chr_count
    );reg[2:0] state;
    reg[20:0] count;
    wire rx_done;
    wire [7:0] data_in;
    reg [7:0]data_store;
    reg delay;
    parameter power=3'd1,set_funct=3'd2,disp_set=3'd3,disp_clr=3'd4,return=3'd5,disp_data=3'd6,second_line=3'd7;
    uart_receiver n1(clk,clr,rx,data_in,rx_done);
    always@(negedge clk,negedge clr)
    begin
    if(!clr)
    begin state<=power;
    chr_count<=0;
    e<=0;
    delay<=0;
    rs<=0;
    rw<=0;
    count<=0;
    data_store<=0;
    data<=0;end
    else begin
    count<=count+1;
    case(state)
    power:begin  rw<=0; rs<=0; data<=8'b0;if(count==21'd2000000)begin e<=0;state<=set_funct;count<=0;end end
    set_funct:begin e<=1;rw<=0; rs<=0;data<=8'b00111000;if(count==21'd3700)begin e<=0; count<=0;state<=disp_set;end end
    disp_set:begin e<=1;rw<=0; rs<=0;data<=8'b00001100;if(count==21'd3700)begin e<=0;count<=0;state<=disp_clr; end end
    disp_clr:begin e<=1;rw<=0; rs<=0;data<=8'b00000001;if(count==21'd152000)begin e<=0; count<=0;state<=return;end end
    return:begin e<=1;rw<=0; rs<=0;data<=8'b00000010;if(count==21'd152000)begin e<=0; count<=0;state<=disp_data;chr_count<=0;end end
    disp_data:begin if((rx_done)&&(!delay))begin data_store<=data_in;count<=0;delay<=1;end
                    if(delay)begin data<=data_store;rw<=0; rs<=1; e<=1;
                    if(count==21'd152000)begin e<=0; count<=0; chr_count<=chr_count+1;delay<=0;
                        if(chr_count==6'd15)begin state<=second_line;end  else if(chr_count==6'd32)begin state<=return;end end end end
    second_line:begin e<=1;rw<=0; rs<=0;data<=8'b11000000;if(count==21'd152000)begin chr_count<=chr_count+1;e<=0; count<=0;state<=disp_data;end end
    endcase
    end
        end
endmodule
