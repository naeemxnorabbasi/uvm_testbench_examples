class driver extends uvm_driver#(transaction);
`uvm_component_utils(driver)
 
transaction t;
virtual ram_if rif;
 
function new(input string inst = "DRV", uvm_component c);
super.new(inst,c);
endfunction
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
t = transaction::type_id::create("TRANS");
if(!uvm_config_db#(virtual ram_if)::get(this,"","rif",rif))
`uvm_info("DRV", "Unable to access Interface", UVM_NONE);
endfunction
 
virtual task run_phase(uvm_phase phase);
forever begin
seq_item_port.get_next_item(t);
rif.wr = t.wr;
rif.din = t.din;
rif.addr = t.addr;
`uvm_info("DRV","Send data to DUT", UVM_NONE);
t.print(uvm_default_line_printer);
seq_item_port.item_done();
@(posedge rif.clk);
 
if(t.wr == 1'b0)
@(posedge rif.clk);
 
end
endtask
 
endclass
