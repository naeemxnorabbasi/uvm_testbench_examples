
//////////////////////////////////////////////////////////////////////////
class mon extends uvm_monitor;
`uvm_component_utils(mon)
 
uvm_analysis_port#(transaction) send;
transaction tr;
virtual dff_if dif;
 
   function new(input string inst = "mon", uvm_component parent = null);
   super.new(inst,parent);
   endfunction
  
   virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   tr = transaction::type_id::create("tr");
   send = new("send", this);
     if(!uvm_config_db#(virtual dff_if)::get(this,"","dif",dif))//uvm_test_top.env.agent.drv.aif
     `uvm_error("drv","Unable to access Interface");
   endfunction
  
  
   virtual task run_phase(uvm_phase phase);
   forever begin
     repeat(2) @(posedge dif.clk);
   tr.rst  = dif.rst;
   tr.din  = dif.din;
   tr.dout = dif.dout;
     `uvm_info("MON", $sformatf("rst : %0b  din : %0b  dout : %0b", tr.rst, tr.din, tr.dout), UVM_NONE);
       send.write(tr);
   end
  endtask
 
endclass
 
