///////////////////////////////////////////////////////////////////////
class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)
 
uvm_analysis_imp #(transaction,scoreboard) recv;
 
transaction data;
 
function new(input string inst = "SCO", uvm_component c);
super.new(inst, c);
recv = new("Read", this);
endfunction
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
data = transaction::type_id::create("TRANS");
endfunction
 
virtual function void write(input transaction t);
data = t;
 `uvm_info("SCO",$sformatf("Data rcvd from Monitor a: %0d , b : %0d and y : %0d",t.a,t.b,t.y), UVM_NONE);
data.print(uvm_default_line_printer);
if(data.y == data.a + data.b)
`uvm_info("SCO","Test Passed", UVM_NONE)
else
`uvm_info("SCO","Test Failed", UVM_NONE);
endfunction
endclass
