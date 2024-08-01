 

 
class mul_agent extends uvm_agent;
`uvm_component_utils(mul_agent)


 
 
function new(input string inst = "mul_agent", uvm_component parent = null);
super.new(inst,parent);
endfunction
 
  mul_driver d;
  uvm_sequencer #(mul_transaction) m_seqr;
  mul_mon m;
 
 
 
virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  m = mul_mon::type_id::create("m",this);
  d = mul_driver::type_id::create("d",this);
  m_seqr =  uvm_sequencer #(mul_transaction)::type_id::create("m_seqr", this);
 
endfunction
 
virtual function void connect_phase(uvm_phase phase);
 super.connect_phase(phase);
 d.seq_item_port.connect(m_seqr.seq_item_export);
endfunction
 
endclass


///////////////////////////////////////////////////////////////////////////////////////////
  
   `uvm_analysis_imp_decl(_add)
   `uvm_analysis_imp_decl(_mul)    
  
  
