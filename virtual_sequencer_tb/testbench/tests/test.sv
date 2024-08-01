/////////////////////////////////////////////////////               
               
class test extends uvm_test;
`uvm_component_utils(test)
 
function new(input string inst = "test", uvm_component c);
super.new(inst,c);
endfunction


env e;
add_gen agen;
mul_gen mgen;


 virtual function void build_phase(uvm_phase phase);
  super.build_phase(phase);
   e       = env::type_id::create("env",this);
   agen     = add_gen::type_id::create("agen");
   mgen     = mul_gen::type_id::create("mgen");
  endfunction


               
virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);
//agen.start(e.vseqr);
//#20;
mgen.start(e.vseqr);
#20; 
phase.drop_objection(this);
endtask


endclass          
