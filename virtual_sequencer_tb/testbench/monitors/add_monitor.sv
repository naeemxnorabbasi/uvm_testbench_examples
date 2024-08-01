
class add_mon extends uvm_monitor;
`uvm_component_utils(add_mon)
 
uvm_analysis_port#(add_transaction) send;
add_transaction tr;
virtual add_if aif;
 
   function new(input string inst = "add_mon", uvm_component parent = null);
   super.new(inst,parent);
   endfunction
  
   virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   tr = add_transaction::type_id::create("tr");
   send = new("send", this);
     if(!uvm_config_db#(virtual add_if)::get(this,"","aif",aif))
       `uvm_error("MON","Unable to access Interface");
   endfunction
  
  
   virtual task run_phase(uvm_phase phase);
   forever begin
     @(posedge aif.clk);
     if(aif.rst)
       begin
         tr.rst = 1'b1;
         send.write(tr);
       end
     else
        begin
          @(posedge aif.clk);
          @(posedge aif.clk);
           tr.rst         = 1'b0;
           tr.add_in1     = aif.add_in1;
           tr.add_in2     = aif.add_in2;
           tr.add_out     = aif.add_out;
           send.write(tr);
        end
  
  
   end
  endtask
 
endclass
 
