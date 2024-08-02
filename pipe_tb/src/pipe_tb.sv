/////////////////////////////////////////////////////////////////////
 
module pipe_tb;

   import uvm_pkg::*;
//   import pipe_pkg::*;

   logic clk;
   logic rst_n;
   
   pipe_if ivif(.clk(clk), .rst_n(rst_n));
   pipe_if ovif(.clk(clk), .rst_n(rst_n));

   pipe pipe_top(.clk(clk), 
		 .rst_n(rst_n), 
		 .i_cf(ivif.cf), 
		 .i_en(ivif.enable), 
		 .i_data0(ivif.data_in0), 
		 .i_data1(ivif.data_in1), 
		 .o_data0(ovif.data_out0), 
		 .o_data1(ovif.data_out1)
		 );

   always #5 clk = ~clk;
   
   initial begin
      clk = 0;
      rst_n = 1'b0;
      #1 rst_n = 1'b1;
   end
   
   assign ovif.enable = ivif.enable;


   initial begin
      uvm_config_db#(virtual pipe_if)::set(uvm_root::get(), "*.agent.driver", "vif", ivif);
      uvm_config_db#(virtual pipe_if)::set(uvm_root::get(), "*.agent.monitor", "vif", ovif);
      uvm_config_db#(string)::set(uvm_root::get(), "*.agent.monitor", "monitor_intf", "vif");

      run_test();
   end


/*   
   initial begin
      uvm_config_db#(virtual pipe_if)::set(uvm_root::get(), "*.agent.*", "in_intf", ivif);
      uvm_config_db#(virtual pipe_if)::set(uvm_root::get(), "*.monitor", "out_intf", ovif);      

      run_test();
      
   end
*/
   


   
   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;  
   end


endmodule
 
