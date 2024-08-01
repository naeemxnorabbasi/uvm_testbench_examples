module dff(
input clk,
input rst,
input din, 
output reg dout 
);


 always@(posedge clk)
   begin
     if(rst)
        dout <= 1'b0;
     else
        dout <= din;
   end


endmodule
