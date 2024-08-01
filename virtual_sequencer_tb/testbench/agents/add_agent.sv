///////////////////////////////////////////////////////////////////////////////
class add_agent extends uvm_agent;
`uvm_component_utils(add_agent)


 
 
function new(input string inst = "add_agent", uvm_component parent = null);
super.new(inst,parent);
endfunction
 
  add_driver d;
  uvm_sequencer #(add_transaction) a_seqr;
  add_mon m;
 
 
virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
  m = add_mon::type_id::create("m",this);
  d = add_driver::type_id::create("d",this);
  a_seqr = uvm_sequencer #(add_transaction)::type_id::create("a_seqr", this);
 
endfunction
 
virtual function void connect_phase(uvm_phase phase);
 super.connect_phase(phase);
 d.seq_item_port.connect(a_seqr.seq_item_export);
endfunction
 
endclass
