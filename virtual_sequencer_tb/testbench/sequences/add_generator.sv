///////////////////////////////////////////////////////////////////////////
    
class add_gen extends top_vseq_base;
  `uvm_object_utils(add_gen)
 
 
    add_sequence aseq;
 
 
  function new(string name="add_gen");
       super.new(name);
   endfunction
 
 
   virtual task body();
     aseq =  add_sequence::type_id::create("aseq");
     super.body();
     aseq.start(vseqr.VA);
   endtask


 
endclass      
    
