module pipe (clk, 
	     rst_n, 
	     i_cf, 
	     i_en, 
	     i_data0, 
	     i_data1, 
	     o_data0, 
	     o_data1
	     );

   input  clk;
   input  rst_n;
   input  [1:0] i_cf;
   input  i_en;
   input  [15:0] i_data0;
   input  [15:0] i_data1;

   output  [15:0] o_data0;
   output  [15:0] o_data1;

   wire  clk;
   wire  rst_n;
   wire  [1:0] i_cf;
   wire  i_en;
   wire  [15:0] i_data0;
   wire  [15:0] i_data1;

   reg  [15:0] o_data0;
   reg  [15:0] o_data1;

   reg [15:0]	       data_0;
   reg [15:0]	       data_1;
   
   
   // input data and check to see if it is
   // 16'h0000 or 16'hFFFF
   // if not, multiply by correction factor

   always @(posedge clk) begin
      if(rst_n) begin
	 data_0 <= 16'h0000;
	 data_1 <= 16'h000;
      end else begin
	 if( (i_data0 == 16'h0000) ||(i_data0 == 16'hFFFF) ) begin
	    data_0 <= i_data0;
	 end else begin
	    data_0 <= i_data0 * i_cf;
	 end
	 if( (i_data1 == 16'h0000) ||(i_data1 == 16'hFFFF) ) begin
	    data_1 <= i_data1;
	 end else begin
	    data_1 <= i_data1 * i_cf;
	 end	 
      end
   end // always @ (posedge clk)

   always @(posedge clk) begin
      o_data0 <= data_0;
      o_data1 <= data_1;
   end
 
endmodule // pipe


