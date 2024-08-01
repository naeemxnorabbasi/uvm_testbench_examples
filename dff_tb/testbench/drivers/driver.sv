
//////////////////////////////////////////////////////////////////////////////
class drv extends uvm_driver#(transaction);
 `uvm_component_utils(drv)
 
 transaction tr;
 virtual dff_if dif;
 
 function new(input string path = "drv", uvm_component parent = null);
   super.new(path,parent);
 endfunction
 
 virtual function void build_phase(uvm_phase phase);
 super.build_phase(phase);
   if(!uvm_config_db#(virtual dff_if)::get(this,"","dif",dif))//uvm_test_top.env.agent.drv.aif
     `uvm_error("drv","Unable to access Interface");
 endfunction


  virtual task run_phase(uvm_phase phase);
     tr = transaction::type_id::create("tr");
    forever begin
       seq_item_port.get_next_item(tr);
       dif.rst <= tr.rst;
       dif.din <= tr.din;
      `uvm_info("DRV", $sformatf("rst : %0b  din : %0b  dout : %0b", tr.rst, tr.din, tr.dout), UVM_NONE);
       seq_item_port.item_done();
      repeat(2) @(posedge dif.clk);
     end
  endtask
 
endclass
 
