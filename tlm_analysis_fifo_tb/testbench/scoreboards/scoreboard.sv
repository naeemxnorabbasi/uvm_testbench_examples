/////////////////////////////////////////////////////////////////////////
//////////////////////reference model
 
class ref_model extends uvm_monitor;
`uvm_component_utils(ref_model)
 
uvm_analysis_port#(transaction) send_ref;
transaction tr;
virtual mux_if mif;
 
   function new(input string inst = "ref_model", uvm_component parent = null);
   super.new(inst,parent);
   endfunction
  
   virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   tr = transaction::type_id::create("tr");
   send_ref = new("send_ref", this);
   if(!uvm_config_db#(virtual mux_if)::get(this,"","mif",mif))//uvm_test_top.env.agent.drv.aif
     `uvm_error("ref_model","Unable to access Interface");
   endfunction
  
   function void predict();
     case(tr.sel)
      2'b00 : tr.y = tr.a;
      2'b01 : tr.y = tr.b;
      2'b10 : tr.y = tr.c;
      2'b11 : tr.y = tr.d;     
     endcase
   endfunction
  
   virtual task run_phase(uvm_phase phase);
   forever begin
   #20;
   tr.a   = mif.a;
   tr.b   = mif.b;
   tr.c   = mif.c;
   tr.d   = mif.d;
   tr.sel = mif.sel;
   predict();
     `uvm_info("MON_REF", $sformatf("a:%0d  b:%0d c:%0d d:%0d sel:%0d y:%0d", tr.a, tr.b,tr.c,tr.d,tr.sel,tr.y), UVM_NONE); 
   send_ref.write(tr);
   end
  endtask
 
endclass
 
////////////////////////////////////////////////////////////////////////////
class sco extends uvm_scoreboard;
`uvm_component_utils(sco)
 
 
 
 transaction tr, trref;
 


 uvm_tlm_analysis_fifo#(transaction) sco_data;
 uvm_tlm_analysis_fifo#(transaction) sco_data_ref;




 
 
   function new(input string inst = "sco", uvm_component parent = null);
   super.new(inst,parent);
   endfunction
  
   virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   tr    = transaction::type_id::create("tr");
   trref = transaction::type_id::create("tr_ref");
   sco_data = new("sco_data", this);
   sco_data_ref = new("sco_data_ref", this); 
    
   endfunction
  
 




    virtual task run_phase(uvm_phase phase);
      forever begin
        sco_data.get(tr);
        sco_data_ref.get(trref);


       
        if(tr.compare(trref))
        `uvm_info("SCO", "Test Passed", UVM_NONE)
        else
        `uvm_info("SCO", "Test Failed", UVM_NONE)
   
     end
    endtask
   
 
endclass
