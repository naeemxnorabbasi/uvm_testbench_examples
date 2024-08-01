 
class generator extends uvm_sequence#(transaction);
`uvm_object_utils(generator)
 
transaction t;
integer i;
 
function new(input string inst = "GEN");
super.new(inst);
endfunction
 
virtual task body();
t = transaction::type_id::create("TRANS");
for(i =0; i< 30; i++) begin
start_item(t);
t.randomize();
`uvm_info("GEN", "Data send to Driver", UVM_NONE);
t.print(uvm_default_line_printer);
finish_item(t);
#20;
end
endtask
endclass
