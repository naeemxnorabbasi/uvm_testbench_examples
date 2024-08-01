
//////////////////////////////////////////////////////////////////
class test extends uvm_test;
`uvm_component_utils(test)
 
function new(input string inst = "test", uvm_component c);
super.new(inst,c);
endfunction
 
env e;
valid_din    vdin;
rst_dff      rff;
rand_din_rst rdin;
 
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
 e    = env::type_id::create("env",this);
 vdin = valid_din::type_id::create("vdin");
 rff  = rst_dff::type_id::create("rff");
 rdin = rand_din_rst::type_id::create("rdin");
endfunction
 
virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);
 rff.start(e.a.seqr);
 #40;
 vdin.start(e.a.seqr);
 #40;
 rdin.start(e.a.seqr);
 #40;
phase.drop_objection(this);
endtask
endclass
 
