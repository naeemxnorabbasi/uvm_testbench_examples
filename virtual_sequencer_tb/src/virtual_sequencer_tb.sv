//////////////////////////////////////////////
   
module virtual_sequencer_tb;


  add_if aif();
  mul_if mif();
 


  top dut (aif.add_in1, aif.add_in2,mif.mul_in1, mif.mul_in2, aif.clk, aif.rst, aif.add_out, mif.mul_out);




 initial begin
   aif.clk <= 0;
 end
 
 always #10 aif.clk <= ~aif.clk;
 assign mif.clk = aif.clk;
 




 initial begin
   uvm_config_db#(virtual add_if)::set(null, "*", "aif", aif);
   uvm_config_db#(virtual mul_if)::set(null, "*", "mif", mif);
   run_test("test");
  end




 initial begin
   $dumpfile("dump.vcd");
   $dumpvars;
 end
 


endmodule   
   

