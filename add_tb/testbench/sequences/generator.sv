//////////////////////////////////////////////////////////////
class generator extends uvm_sequence #(transaction);
`uvm_object_utils(generator)
 
transaction t;
integer i;
 
function new(input string inst = "GEN");
super.new(inst);
endfunction
 
 
virtual task body();
t = transaction::type_id::create("TRANS");
for(i =0; i< 1000; i++) begin
start_item(t);
t.randomize();
`uvm_info("GEN",$sformatf("Data send to Driver a :%0d , b :%0d",t.a,t.b), UVM_NONE);
t.print(uvm_default_line_printer);
finish_item(t);
#10; 
end
endtask
 
endclass
