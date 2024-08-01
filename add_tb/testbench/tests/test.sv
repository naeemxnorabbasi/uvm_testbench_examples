////////////////////////////////////////////
 
class test extends uvm_test;
`uvm_component_utils(test)
 
 
function new(input string inst = "TEST", uvm_component c);
super.new(inst, c);
endfunction
 
generator gen;
env e;
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
gen = generator::type_id::create("GEN",this);
e = env::type_id::create("ENV",this);
endfunction
 
virtual task run_phase(uvm_phase phase);
phase.raise_objection(phase);
gen.start(e.a.seq);
#10;
phase.drop_objection(phase);
endtask
endclass
