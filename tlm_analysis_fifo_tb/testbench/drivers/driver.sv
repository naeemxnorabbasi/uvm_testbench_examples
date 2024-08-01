//////////////////////////////////////////////////////////////////////////////
class drv extends uvm_driver#(transaction);
 `uvm_component_utils(drv)
 
 transaction tr;
 virtual mux_if mif;
 
 function new(input string path = "drv", uvm_component parent = null);
   super.new(path,parent);
 endfunction
 
 virtual function void build_phase(uvm_phase phase);
 super.build_phase(phase);
   if(!uvm_config_db#(virtual mux_if)::get(this,"","mif",mif))//uvm_test_top.env.agent.drv.aif
     `uvm_error("drv","Unable to access Interface");
 endfunction


  virtual task run_phase(uvm_phase phase);
     tr = transaction::type_id::create("tr");
    forever begin
       seq_item_port.get_next_item(tr);
       mif.a   <= tr.a;
       mif.b   <= tr.b;
       mif.c   <= tr.c;
       mif.d   <= tr.d;
       mif.sel <= tr.sel;
     `uvm_info("DRV", $sformatf("a:%0d  b:%0d c:%0d d:%0d sel:%0d y:%0d", tr.a, tr.b,tr.c,tr.d,tr.sel,tr.y), UVM_NONE);
      seq_item_port.item_done();
       #20;  
     end
  endtask
 
endclass
 
