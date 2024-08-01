
`include "uvm_macros.svh"
import uvm_pkg::*;
 
//////////////////////////////////////////////////////////////
 
class config_dff extends uvm_object;
 `uvm_object_utils(config_dff)


 uvm_active_passive_enum agent_type = UVM_ACTIVE;


 function new(input string path = "config_dff");
   super.new(path);
  endfunction


endclass
 
////////////////////////////////////////////////////////////
class transaction extends uvm_sequence_item;
`uvm_object_utils(transaction)


 rand bit rst;
 rand bit din;
      bit dout;
      
  function new(input string path = "transaction");
   super.new(path);
  endfunction


 
endclass
 
 
 
 
////////////////////////////////////////////////////////////////////////
 
class valid_din extends uvm_sequence#(transaction);
`uvm_object_utils(valid_din)


   transaction tr;
 
  function new(input string path = "valid_din");
   super.new(path);
  endfunction
 
 
  virtual task body();
  repeat(15)
    begin
        tr = transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize());
        tr.rst = 1'b0;
        `uvm_info("SEQ", $sformatf("rst : %0b  din : %0b  dout : %0b", tr.rst, tr.din, tr.dout), UVM_NONE);
        finish_item(tr);    
    end
  endtask
 
endclass
//////////////////////////////////////////////////////////////////////////////
class rst_dff extends uvm_sequence#(transaction);
`uvm_object_utils(rst_dff)


   transaction tr;
 
  function new(input string path = "rst_dff");
   super.new(path);
  endfunction
 
 
  virtual task body();
  repeat(15)
    begin
        tr = transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize());
        tr.rst = 1'b1;
        `uvm_info("SEQ", $sformatf("rst : %0b  din : %0b  dout : %0b", tr.rst, tr.din, tr.dout), UVM_NONE);
        finish_item(tr);    
    end
  endtask
 
endclass
 
//////////////////////////////////////////////////////////////////////////////
class rand_din_rst extends uvm_sequence#(transaction);
`uvm_object_utils(rand_din_rst)


   transaction tr;
 
  function new(input string path = "rand_din_rst");
   super.new(path);
  endfunction
 
 
  virtual task body();
  repeat(15)
    begin
        tr = transaction::type_id::create("tr");
        start_item(tr);
        assert(tr.randomize());
        `uvm_info("SEQ", $sformatf("rst : %0b  din : %0b  dout : %0b", tr.rst, tr.din, tr.dout), UVM_NONE);
        finish_item(tr);    
    end
  endtask
 
endclass
 
