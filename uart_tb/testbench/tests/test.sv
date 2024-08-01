//////////////////////////////////////////////////////////////////////////

class test extends uvm_test;
   `uvm_component_utils(test)
   
   function new(input string inst = "test", uvm_component c);
      super.new(inst,c);
   endfunction
   
   
   env e;
   rand_baud rb;
   rand_baud_with_stop rbs;
   rand_baud_len5p  rb5l;
   rand_baud_len6p rb6l;
   rand_baud_len7p rb7l;
   rand_baud_len8p rb8l;
   ///////////////////////


   rand_baud_len5  rb5lwop;
   rand_baud_len6  rb6lwop;
   rand_baud_len7  rb7lwop;
   rand_baud_len8  rb8lwop;




   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      e       = env::type_id::create("env",this);
      rb      = rand_baud::type_id::create("rb");
      rbs     = rand_baud_with_stop::type_id::create("rbs");
      /////////////fixed length var baud with parity
      rb5l    = rand_baud_len5p::type_id::create("rb5l");
      rb6l    = rand_baud_len6p::type_id::create("rb6l");
      rb7l    = rand_baud_len7p::type_id::create("rb7l");
      rb8l    = rand_baud_len8p::type_id::create("rb8l");


      ///////////////fixed len var baud without parity
      rb5lwop = rand_baud_len5::type_id::create("rb5lwop");
      rb6lwop = rand_baud_len6::type_id::create("rb6lwop");
      rb7lwop = rand_baud_len7::type_id::create("rb7lwop");
      rb8lwop = rand_baud_len8::type_id::create("rb8lwop");




   endfunction
   
   virtual task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      rb8lwop.start(e.a.seqr);
      #20;
      phase.drop_objection(this);
   endtask
endclass

