///////////////////////////////////////////////////////////////////////
 
class env extends uvm_env;
`uvm_component_utils(env)
 
function new(input string inst = "env", uvm_component c);
super.new(inst,c);
endfunction
 
agent a;
sco s;
config_dff cfg;
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
 a = agent::type_id::create("a",this);
 s = sco::type_id::create("s", this);
 cfg = config_dff::type_id::create("cfg");
 //////////////////////////////////////////
 uvm_config_db#(config_dff)::set(this, "a", "cfg", cfg);
endfunction
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
a.m.send.connect(s.recv);
endfunction
 
endclass
 
