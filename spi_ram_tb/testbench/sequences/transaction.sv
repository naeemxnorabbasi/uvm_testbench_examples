
`include "uvm_macros.svh"
import uvm_pkg::*;
 
 
////////////////////////////////////////////////////////////////////////////////////
class spi_config extends uvm_object; /////configuration of env
 `uvm_object_utils(spi_config)


 function new(string name = "spi_config");
   super.new(name);
 endfunction


 uvm_active_passive_enum is_active = UVM_ACTIVE;


endclass
 
//////////////////////////////////////////////////////////
 
typedef enum bit [1:0]   {readd = 0, writed = 1, rstdut = 2} oper_mode;
 
 
class transaction extends uvm_sequence_item;
   randc logic [7:0] addr;
   rand logic [7:0] din;
        logic [7:0] dout;
   rand oper_mode   op;
        logic rst;
   rand logic miso;
        logic cs;    
        logic done;
        logic err;
        logic ready;
        logic mosi;
       
 constraint addr_c { addr <= 10;}
 
       `uvm_object_utils_begin(transaction)
       `uvm_field_int (addr,UVM_ALL_ON)
       `uvm_field_int (din,UVM_ALL_ON)
       `uvm_field_int (dout,UVM_ALL_ON)
       `uvm_field_int (ready,UVM_ALL_ON)
       `uvm_field_int (rst,UVM_ALL_ON)
       `uvm_field_int (done,UVM_ALL_ON)
       `uvm_field_int (miso,UVM_ALL_ON)
       `uvm_field_int (mosi,UVM_ALL_ON)
       `uvm_field_int (cs,UVM_ALL_ON)
       `uvm_field_int (err,UVM_ALL_ON)
       `uvm_field_enum(oper_mode, op, UVM_DEFAULT)
       `uvm_object_utils_end


 
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
       tr.addr_c.constraint_mode(1);
       start_item(tr);
       assert(tr.randomize);
       tr.op = writed;
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
       tr.addr_c.constraint_mode(1);
       start_item(tr);
       assert(tr.randomize);
       tr.op = readd;
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
       tr.addr_c.constraint_mode(1);
       start_item(tr);
       assert(tr.randomize);
       tr.op = rstdut;
       finish_item(tr);
     end
 endtask


 
endclass
////////////////////////////////////////////////////////////
 
 
 
class writeb_readb extends uvm_sequence#(transaction);
 `uvm_object_utils(writeb_readb)


 transaction tr;
 
 function new(string name = "writeb_readb");
   super.new(name);
 endfunction


 virtual task body();
   
   repeat(10)
     begin
       tr = transaction::type_id::create("tr");
       tr.addr_c.constraint_mode(1);
       start_item(tr);
       assert(tr.randomize);
       tr.op = writed;
       finish_item(tr); 
     end
      
   repeat(10)
     begin
       tr = transaction::type_id::create("tr");
       tr.addr_c.constraint_mode(1);
       start_item(tr);
       assert(tr.randomize);
       tr.op = readd;
       finish_item(tr);
     end  
  
 endtask


 
endclass
 
 
