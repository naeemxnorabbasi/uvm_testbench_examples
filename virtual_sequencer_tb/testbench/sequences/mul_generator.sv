/////////////////////////////////////////////////////////////////////////////     
   
class mul_gen extends top_vseq_base;
  `uvm_object_utils(mul_gen)
 
 
    mul_sequence mseq;
 
 
   function new(string name="mul_gen");
       super.new(name);
   endfunction


 
   virtual task body();
     mseq =  mul_sequence::type_id::create("mseq");
     super.body();
     mseq.start(vseqr.VM);
   endtask
 
endclass   
   
