////////////////////////////////////////////////////////////////////
module tlm_analysis_fifo_tb;
 
 mux_if mif();


 mux dut (.a(mif.a), .b(mif.b), .c(mif.c), .d(mif.d), .sel(mif.sel), .y(mif.y));
 
initial
 begin
 uvm_config_db #(virtual mux_if)::set(null, "*", "mif", mif);
 run_test("test");
 end
 
 initial begin
   $dumpfile("dump.vcd");
   $dumpvars;
 end
endmodule
 
 
 

