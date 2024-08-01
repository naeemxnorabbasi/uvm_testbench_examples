//////////////////////////////////////////////////////////////////////////
 
class test extends uvm_test;
`uvm_component_utils(test)
 
function new(input string inst = "test", uvm_component c);
super.new(inst,c);
endfunction
 
env e;
write_data wdata;
read_data rdata;
reset_dut rstdut; 
 


virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  e      = env::type_id::create("env",this);
  wdata  = write_data::type_id::create("wdata");
  rdata  = read_data::type_id::create("rdata");
  rstdut = reset_dut::type_id::create("rstdut");
endfunction
 
virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);
rstdut.start(e.a.seqr);
 
wdata.start(e.a.seqr);
 
rdata.start(e.a.seqr);
 
phase.drop_objection(this);
endtask
endclass
 
