////////////////////////////////////////////////////////////////////
class driver extends uvm_driver #(transaction);
`uvm_component_utils(driver)
 
function new(input string inst = " DRV", uvm_component c);
super.new(inst, c);
endfunction
 
transaction data;
virtual add_if aif;
 
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
data = transaction::type_id::create("TRANS");
if(!uvm_config_db #(virtual add_if)::get(this,"","aif",aif))
`uvm_info("DRV","Unable to access uvm_config_db",UVM_NONE);
endfunction
 
virtual task run_phase(uvm_phase phase);
forever begin
seq_item_port.get_next_item(data);
aif.a = data.a;
aif.b = data.b;
 `uvm_info("DRV", $sformatf("Trigger DUT a: %0d ,b :  %0d",data.a, data.b), UVM_NONE);
data.print(uvm_default_line_printer);
seq_item_port.item_done();
end
endtask
endclass
