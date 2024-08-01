///////////////////////////////////////////////////////////////////////
 
class env extends uvm_env;
`uvm_component_utils(env)
 
function new(input string inst = "env", uvm_component c);
super.new(inst,c);
endfunction
 
agent a;
sco s;
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
 a = agent::type_id::create("agent",this);
 s = sco::type_id::create("sco", this);
endfunction
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
 a.m.send.connect(s.sco_data.analysis_export);
 a.mref.send_ref.connect(s.sco_data_ref.analysis_export);
endfunction
 
endclass
 
