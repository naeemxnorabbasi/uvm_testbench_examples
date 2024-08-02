 
//////////////// BASE TEST ///////////
//////////////////////////////////////
class base_test extends uvm_test;
`uvm_component_utils(base_test)
 
   pipe_env env;
   uvm_table_printer printer;
   
   function new(input string name = "base_test", uvm_component parent);
      super.new(name,parent);
   endfunction

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env = pipe_env::type_id::create("env", this);
      printer = new();
      printer.knobs.depth = 5;
   endfunction // build_phase
   
   virtual function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      `uvm_info(get_type_name(), $sformatf("printing the test topolgy:\n%s", this.sprint(printer)), UVM_LOW)
   endfunction // end_of_elaboration_phase
		
   virtual task run_phase(uvm_phase phase);
      phase.phase_done.set_drain_time(this, 150000);	       
   endtask // run_phase
		
endclass // base_test

//////////////// RANDOM TEST ///////////
////////////////////////////////////////
class random_test extends base_test;
`uvm_component_utils(random_test)

function new(input string name, uvm_component parent);
   super.new(name, parent);
endfunction // new

virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction // build_phase

virtual task run_phase(uvm_phase phase);
    random_sequence seq;

    super.run_phase(phase);    
    phase.raise_objection(this);
    seq = random_sequence::type_id::create("seq");
    seq.start(env.agent.sequencer);
    phase.drop_objection(this);
endtask // run_phase
		
endclass // random_test
		


//////////////// DATA0 TEST ////////////
////////////////////////////////////////
class data0_test extends base_test;
`uvm_component_utils(data0_test)

function new(input string name, uvm_component parent);
   super.new(name, parent);
endfunction // new

virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction // build_phase

virtual task run_phase(uvm_phase phase);
    data0_sequence seq;

    super.run_phase(phase);    
    phase.raise_objection(this);
       seq = data0_sequence::type_id::create("seq");
       seq.start(env.agent.sequencer);
    phase.drop_objection(this);
endtask // run_phase
		
endclass // data0_test
		


//////////////// DATA1 TEST ////////////
////////////////////////////////////////
class data1_test extends base_test;
`uvm_component_utils(data1_test)

function new(input string name, uvm_component parent);
   super.new(name, parent);
endfunction // new

virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction // build_phase
		
virtual task run_phase(uvm_phase phase);
    data1_sequence seq;

    super.run_phase(phase);    
    phase.raise_objection(this);
       seq = data1_sequence::type_id::create("seq");
       seq.start(env.agent.sequencer);
    phase.drop_objection(this);
endtask // run_phase
		
endclass // data1_test
		

//////////////// MANYY RANDOM TEST ///////////
//////////////////////////////////////////////
class many_random_test extends base_test;
`uvm_component_utils(many_random_test)

function new(input string name, uvm_component parent);
   super.new(name, parent);
endfunction // new

virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction // build_phase		

virtual task run_phase(uvm_phase phase);
    many_random_sequence seq;


    super.run_phase(phase);    
    phase.raise_objection(this);
       seq = many_random_sequence::type_id::create("seq");
       seq.start(env.agent.sequencer);
    phase.drop_objection(this);
endtask // run_phase
	
endclass // many_random_test


//////////////// TEST ///////////
//////////////////////////////////////////////
class test extends base_test;
`uvm_component_utils(test)

function new(input string name, uvm_component parent);
   super.new(name, parent);
endfunction // new

virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
endfunction // build_phase		


 // Define the function to print the hierarchy
  virtual function void print_hierarchy();
    uvm_top.print_topology();
  endfunction : print_hierarchy


virtual task run_phase(uvm_phase phase);
    many_random_sequence seq;
   
    super.run_phase(phase);   
    print_hierarchy();
    phase.raise_objection(this);
       seq = many_random_sequence::type_id::create("seq");
       seq.start(env.agent.sequencer);
    phase.drop_objection(this);
endtask // run_phase
	
endclass // test
