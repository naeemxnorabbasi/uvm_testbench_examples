/////////////////////////////////////////////////////////////////////
 
module axi_ram_tb;
 
axi_if vif();
axi_slave dut (vif.clk, vif.resetn, vif.awvalid, vif.awready,  vif.awid, vif.awlen, vif.awsize, vif.awaddr,  vif.awburst, vif.wvalid, vif.wready, vif.wid, vif.wdata, vif.wstrb, vif.wlast, vif.bready, vif.bvalid, vif.bid, vif.bresp , vif.arready, vif.arid, vif.araddr, vif.arlen, vif.arsize, vif.arburst, vif.arvalid, vif.rid, vif.rdata, vif.rresp,vif.rlast,  vif.rvalid, vif.rready);


 initial begin
   vif.clk <= 0;
 end


 always #5 vif.clk <= ~vif.clk;


   initial begin
   uvm_config_db#(virtual axi_if)::set(null, "*", "vif", vif);
   run_test("test");
  end








   initial begin
   $dumpfile("dump.vcd");
   $dumpvars;  
 end


 assign vif.next_addrwr = dut.nextaddr;
 assign vif.next_addrrd = dut.rdnextaddr;


endmodule
 

