/////////////////////////////////////////////////////////////////////////
class sco extends uvm_scoreboard;
`uvm_component_utils(sco)
 
 uvm_analysis_imp#(transaction,sco) recv;
 
 
   function new(input string inst = "sco", uvm_component parent = null);
   super.new(inst,parent);
   endfunction
  
   virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   recv = new("recv", this);
   endfunction
  
  
 virtual function void write(transaction tr);
     if(tr.y == (tr.a * tr.b))
        `uvm_info("SCO", $sformatf("Test Passed -> a : %0d  b : %0d  y : %0d", tr.a, tr.b, tr.y), UVM_NONE)
     else
        `uvm_error("SCO", $sformatf("Test Failed -> a : %0d  b : %0d  y : %0d", tr.a, tr.b, tr.y))
    
   $display("----------------------------------------------------------------");
   endfunction
 
endclass
 
