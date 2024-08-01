
class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)
 
uvm_analysis_imp #(transaction,scoreboard) recv;
//transaction data;
 
reg [7:0] tarr[20] = '{default:0};
 
function new(input string inst = "SCO", uvm_component c);
super.new(inst,c);
recv = new("READ",this);
endfunction
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
////data = transaction::type_id::create("TRANS");
//endfunction
 
virtual function void write(transaction data);
 
`uvm_info("SCO","Data rcvd from Monitor", UVM_NONE);
data.print(uvm_default_line_printer);
 
if(data.wr == 1'b1)
begin
tarr[data.addr] = data.din;
`uvm_info("SCO", $sformatf("Data Write Oper din :%0h and tarr[data.addr] : %0h ", data.din, tarr[data.addr]), UVM_NONE);
end
 
if(data.wr == 1'b0)
begin
if(data.dout == tarr[data.addr])
`uvm_info("SCO", "Test Passed ", UVM_NONE)
else
`uvm_error("SCO", "Test Failed");
 
`uvm_info("SCO", $sformatf("Data Read Oper dout :%0h and tarr[data.addr] : %0h ", data.dout, tarr[data.addr]), UVM_NONE);
 
end                                                                         
                                                                                
endfunction
 
endclass
 
