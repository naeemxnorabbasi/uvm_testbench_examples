//////////////////////////////////////////////////////////////////////////
class mon extends uvm_monitor;
`uvm_component_utils(mon)
 
uvm_analysis_port#(transaction) send;
transaction tr;
virtual mux_if mif;
 
   function new(input string inst = "mon", uvm_component parent = null);
   super.new(inst,parent);
   endfunction
  
   virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   tr = transaction::type_id::create("tr");
   send = new("send", this);
   if(!uvm_config_db#(virtual mux_if)::get(this,"","mif",mif))//uvm_test_top.env.agent.drv.aif
     `uvm_error("drv","Unable to access Interface");
   endfunction
  
  
   virtual task run_phase(uvm_phase phase);
   forever begin
   #20;
   tr.a   = mif.a;
   tr.b   = mif.b;
   tr.c   = mif.c;
   tr.d   = mif.d;
   tr.sel = mif.sel;
   tr.y   = mif.y;
     `uvm_info("MON_DUT", $sformatf("a:%0d  b:%0d c:%0d d:%0d sel:%0d y:%0d", tr.a, tr.b,tr.c,tr.d,tr.sel,tr.y), UVM_NONE);
    send.write(tr);
   end
  endtask
 
endclass
