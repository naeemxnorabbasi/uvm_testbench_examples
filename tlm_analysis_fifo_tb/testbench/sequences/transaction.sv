
`include "uvm_macros.svh"
import uvm_pkg::*;
 
////////////////////////////////////////////////////////////
class transaction extends uvm_sequence_item;




  rand bit [3:0] a;
  rand bit [3:0] b;
  rand bit [3:0] c;
  rand bit [3:0] d;
  rand bit [1:0] sel;
       bit [3:0] y;
      
  function new(input string path = "transaction");
   super.new(path);
  endfunction


 `uvm_object_utils_begin(transaction)
 `uvm_field_int(a, UVM_DEFAULT)
 `uvm_field_int(b, UVM_DEFAULT)
 `uvm_field_int(c, UVM_DEFAULT)
 `uvm_field_int(d, UVM_DEFAULT)
 `uvm_field_int(sel, UVM_DEFAULT)
 `uvm_field_int(y, UVM_DEFAULT)
 `uvm_object_utils_end


 
endclass
 
