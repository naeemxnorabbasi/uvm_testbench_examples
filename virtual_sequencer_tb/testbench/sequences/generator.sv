
  
 
  
 class vsequencer extends uvm_sequencer;
  `uvm_component_utils(vsequencer)
 
   uvm_sequencer #(add_transaction) VA;
   uvm_sequencer #(mul_transaction) VM;
  


   function new(string name, uvm_component parent);
       super.new(name, parent);
   endfunction
 
endclass


 ////////////////////////////////////////////////////////////////////////////
 
 
class top_vseq_base extends uvm_sequence #(uvm_sequence_item);
`uvm_object_utils(top_vseq_base)
 
  // uvm_sequencer #(add_transaction) GA;
  // uvm_sequencer #(mul_transaction) GM;


   vsequencer vseqr;
 
 
 
 
function new(string name = "top_vseq_base");
 super.new(name);
endfunction




task body(); 


 if(!$cast(vseqr, m_sequencer)) begin
   `uvm_error(get_full_name(), "Virtual sequencer pointer cast failed");
 end


 //Handle assignment for virtual sequence's sub-sequencers
//  GA = vseqr.VA;
//  GM = vseqr.VM;




endtask: body
 


endclass: top_vseq_base
 
