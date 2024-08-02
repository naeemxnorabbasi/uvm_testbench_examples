///////////////////////////////////////////////////////////
class pipe_agent extends uvm_agent;
   protected uvm_active_passive_enum is_active = UVM_ACTIVE;

   pipe_sequencer sequencer;
   pipe_driver driver;
   pipe_monitor monitor;
   
   `uvm_component_utils_begin(pipe_agent)
      `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_ALL_ON)
   `uvm_component_utils_end

   function new(input string name = "pipe_agent", uvm_component parent = null);
      super.new(name,parent);
   endfunction
 
   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      if(is_active == UVM_ACTIVE) begin
	 sequencer = pipe_sequencer::type_id::create("sequencer",this);
	 driver  = pipe_driver::type_id::create("driver", this);
	 monitor =  pipe_monitor::type_id::create("monitor", this);
      end
  endfunction // build_phase
    
  virtual function void connect_phase(uvm_phase phase);
     super.connect_phase(phase);
     if(is_active == UVM_ACTIVE) begin
	driver.seq_item_port.connect(sequencer.seq_item_export);
     end
     `uvm_info(get_full_name(), "Connect stage complete.", UVM_LOW)
  endfunction // connect_phase
   
endclass // pipe_agent

 
