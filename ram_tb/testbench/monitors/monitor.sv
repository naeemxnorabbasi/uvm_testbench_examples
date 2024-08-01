 
class monitor extends uvm_monitor;
`uvm_component_utils(monitor)
 
uvm_analysis_port #(transaction) send;
virtual ram_if rif;
transaction t;
 
function new(input string inst = "MON", uvm_component c);
super.new(inst,c);
send = new("WRITE",this);
endfunction
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
t = transaction::type_id::create("TRANS");
if(!uvm_config_db#(virtual ram_if)::get(this,"","rif",rif))
`uvm_info("MON", "Unable to access Interface", UVM_NONE);
endfunction
 
virtual task run_phase(uvm_phase phase);
forever begin
@(posedge rif.clk);
t.wr = rif.wr;
t.din = rif.din;
t.addr = rif.addr;
 
if(rif.wr == 1'b0) begin
@(posedge rif.clk);
t.dout = rif.dout;
end
 
`uvm_info("MON","Send data to Scoreboard", UVM_NONE);
t.print(uvm_default_line_printer);
send.write(t);
end
endtask
 
endclass
