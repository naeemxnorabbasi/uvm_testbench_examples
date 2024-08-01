////////////////////////////////////////////////////////////////////
module dff_tb;
 
 dff_if dif();


 dff dut (.clk(dif.clk), .rst(dif.rst), .din(dif.din), .dout(dif.dout));
 
 initial
 begin
   uvm_config_db #(virtual dff_if)::set(null, "*", "dif", dif);
   run_test("test");
 end


 initial begin
   dif.clk = 0;
 end


 always #10 dif.clk = ~dif.clk;


 initial begin
   $dumpfile("dump.vcd");
   $dumpvars;
 end
endmodule
 

