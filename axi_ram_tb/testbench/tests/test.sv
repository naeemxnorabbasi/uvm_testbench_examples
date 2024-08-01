 
//////////////////////////////////////////////////
class test extends uvm_test;
`uvm_component_utils(test)
 
function new(input string inst = "test", uvm_component c);
super.new(inst,c);
endfunction
 
 
env e;
valid_wrrd_fixed vwrrdfx;
valid_wrrd_incr  vwrrdincr;
valid_wrrd_wrap  vwrrdwrap;
err_wrrd_fix     errwrrdfix;
rst_dut rdut;


virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  e       = env::type_id::create("env",this);
 vwrrdfx = valid_wrrd_fixed::type_id::create("vwrrdfx");
 vwrrdincr = valid_wrrd_incr::type_id::create("vwrrdincr");
 vwrrdwrap = valid_wrrd_wrap::type_id::create("vwrrdwrap");
 errwrrdfix = err_wrrd_fix::type_id::create("errwrrdfix");
 rdut       = rst_dut::type_id::create("rdut");
endfunction
 
virtual task run_phase(uvm_phase phase);
phase.raise_objection(this);
//rdut.start(e.a.seqr);
//#20;
//vwrrdfx.start(e.a.seqr);
//#20;
//vwrrdincr.start(e.a.seqr);
//#20;
//vwrrdwrap.start(e.a.seqr);
//#20;
//1
rdut.start(e.a.seqr);
#20;
errwrrdfix.start(e.a.seqr);
#20;
//2
rdut.start(e.a.seqr);
#20;
vwrrdfx.start(e.a.seqr);
#20;
//3
rdut.start(e.a.seqr);
#20;   
vwrrdincr.start(e.a.seqr);
#20;
//4
rdut.start(e.a.seqr);
#20; 
vwrrdwrap.start(e.a.seqr);
#20;
   
    
phase.drop_objection(this);
endtask
endclass
 
