 
`include "uvm_macros.svh"
import uvm_pkg::*;
 
class transaction extends uvm_sequence_item;
rand bit wr;
rand bit [7:0] din;
rand bit [3:0] addr;
bit [7:0] dout;
 
constraint addr_c {addr > 2; addr < 8;};
 
function new(input string inst = "TRANS");
super.new(inst);
endfunction
 
`uvm_object_utils_begin(transaction)
`uvm_field_int(wr,UVM_DEFAULT)
`uvm_field_int(din,UVM_DEFAULT)
`uvm_field_int(addr,UVM_DEFAULT)
`uvm_field_int(dout,UVM_DEFAULT)
`uvm_object_utils_end
 
endclass
