//////////////////////////////////////////////
// interface to the TB
  
interface pipe_if(input logic clk, rst_n);

   logic [1:0] cf;
   logic [15:0]    data_in0;
   logic [15:0]    data_in1;
   logic [15:0]    data_out0;
   logic [15:0]    data_out1;
   logic	   enable;


/*   
   bit [1:0] cf;
   bit [15:0]    data_in0;
   bit [15:0]    data_in1;
   bit [15:0]    data_out0;
   bit [15:0]    data_out1;
   bit	   enable;
  */ 
endinterface: pipe_if

