
`include "uvm_macros.svh"
import uvm_pkg::*;
 
/////////////////////////////add env
 
class add_transaction extends uvm_sequence_item;
 `uvm_object_utils(add_transaction)


 rand logic [3:0] add_in1,add_in2;
      logic clk, rst;
      logic [4:0] add_out;


 function new(string name = "add_transaction");
   super.new(name);
 endfunction
 
endclass : add_transaction
 
///////////////////////////////////////////////
 
class add_sequence extends uvm_sequence#(add_transaction);
 `uvm_object_utils(add_sequence)


 add_transaction tr;
 
 function new(string name = "add_sequence");
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
