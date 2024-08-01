///////////////////////////////////////////////////////////////
 
class mul_mon extends uvm_monitor;
`uvm_component_utils(mul_mon)
 
uvm_analysis_port#(mul_transaction) send;
mul_transaction tr;
virtual mul_if mif;
 
   function new(input string inst = "mul_mon", uvm_component parent = null);
   super.new(inst,parent);
   endfunction
  
   virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   tr = mul_transaction::type_id::create("tr");
   send = new("send", this);
     if(!uvm_config_db#(virtual mul_if)::get(this,"","mif",mif))//uvm_test_top.env.agent.drv.aif
       `uvm_error("MUL_MON","Unable to access Interface");
   endfunction
  
  
   virtual task run_phase(uvm_phase phase);
   forever begin
     @(posedge mif.clk);
     if(mif.rst)
       begin
         tr.rst = 1'b1;
         send.write(tr);
       end
     else
        begin
          @(posedge mif.clk);
          @(posedge mif.clk);
           tr.rst         = 1'b0;
           tr.mul_in1     = mif.mul_in1;
           tr.mul_in2     = mif.mul_in2;
           tr.mul_out     = mif.mul_out;
           send.write(tr);
        end
  
  
   end
  endtask
 
endclass
/////////////////////////////////////////////////////////////////////////////////////////////
