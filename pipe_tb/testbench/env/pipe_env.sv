////////////////////////////////////////////////////////////////////////////////
 
class pipe_env extends uvm_env;
`uvm_component_utils(pipe_env)
 
function new(input string name = "pipe_env", uvm_component parent);
   super.new(name,parent);
endfunction // new
   
pipe_agent agent;
 
 
virtual function void build_phase(uvm_phase phase);
   super.build_phase(phase);
   agent = pipe_agent::type_id::create("agent",this);
   `uvm_info(get_full_name(), "Build stage complete.", UVM_LOW)
endfunction // build_phase
   
endclass // pipe_env

