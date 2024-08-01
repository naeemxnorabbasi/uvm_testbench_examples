 
 
 
 
/////////////////////////////add env
 
class mul_transaction extends uvm_sequence_item;
 `uvm_object_utils(mul_transaction)


 rand logic [3:0] mul_in1,mul_in2;
      logic clk, rst;
 logic [7:0] mul_out;


 function new(string name = "mul_transaction");
   super.new(name);
 endfunction
 
endclass : mul_transaction
 
///////////////////////////////////////////////
 
class mul_sequence extends uvm_sequence#(mul_transaction);
 `uvm_object_utils(mul_sequence)


 mul_transaction tr;
 
 function new(string name = "mul_sequence");
   super.new(name);
 endfunction


 virtual task body();
   repeat(5)
     begin
       `uvm_do(tr)
     end
 endtask


endclass 
//////////////////////////////////////////////////////////////

