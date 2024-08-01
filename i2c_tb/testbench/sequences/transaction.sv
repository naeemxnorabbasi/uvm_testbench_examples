
`include "uvm_macros.svh"
import uvm_pkg::*;
 
 
//////////////////////////////////////////////////////////
 
typedef enum bit [1:0]   {readd = 0, writed = 1, rstdut = 2} oper_mode;
 
 
class transaction extends uvm_sequence_item;
 `uvm_object_utils(transaction)


 oper_mode op;
 logic wr;
 randc logic [6:0] addr;
 rand logic [7:0] din;
 logic [7:0] datard;
 logic done;
       
 constraint addr_c { addr <= 10;}
 
 
 function new(string name = "transaction");
   super.new(name);
 endfunction
 
endclass : transaction
 
 
///////////////////////////////////////////////////////////////////////
 
 
///////////////////write seq
class write_data extends uvm_sequence#(transaction);
 `uvm_object_utils(write_data)


 transaction tr;
 
 function new(string name = "write_data");
   super.new(name);
 endfunction


 virtual task body();
   repeat(15)
     begin
       tr = transaction::type_id::create("tr");
       start_item(tr);
       assert(tr.randomize);
       tr.op = writed;
       `uvm_info("SEQ", $sformatf("MODE : WRITE DIN : %0d ADDR : %0d ", tr.din, tr.addr), UVM_NONE);
       finish_item(tr);
     end
 endtask


 
endclass
//////////////////////////////////////////////////////////
 
 
class read_data extends uvm_sequence#(transaction);
 `uvm_object_utils(read_data)


 transaction tr;
 
 function new(string name = "read_data");
   super.new(name);
 endfunction


 virtual task body();
   repeat(15)
     begin
       tr = transaction::type_id::create("tr");
       start_item(tr);
       assert(tr.randomize);
       tr.op = readd;
       `uvm_info("SEQ", $sformatf("MODE : READ ADDR : %0d ", tr.addr), UVM_NONE);
       finish_item(tr);
     end
 endtask


 
endclass
/////////////////////////////////////////////////////////////////////
 
class reset_dut extends uvm_sequence#(transaction);
 `uvm_object_utils(reset_dut)


 transaction tr;
 
 function new(string name = "reset_dut");
   super.new(name);
 endfunction


 virtual task body();
   repeat(15)
     begin
       tr = transaction::type_id::create("tr");
       start_item(tr);
       assert(tr.randomize);
       tr.op = rstdut;
       `uvm_info("SEQ", "MODE : RESET", UVM_NONE);
       finish_item(tr);
     end
 endtask


 
endclass
