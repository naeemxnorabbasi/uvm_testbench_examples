
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
   `uvm_info("SCO", $sformatf("rst : %0b  din : %0b  dout : %0b", tr.rst, tr.din, tr.dout), UVM_NONE);
   if(tr.rst == 1'b1)
     `uvm_info("SCO", "DFF Reset", UVM_NONE)
   else if(tr.rst == 1'b0 && (tr.din == tr.dout))
     `uvm_info("SCO", "TEST PASSED", UVM_NONE)
   else
     `uvm_info("SCO", "TEST FAILED", UVM_NONE)
    
        
   $display("----------------------------------------------------------------");
   endfunction
 
endclass
 
