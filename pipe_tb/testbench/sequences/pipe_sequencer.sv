class pipe_sequencer extends uvm_sequencer #(data_packet);
   `uvm_sequencer_utils(pipe_sequencer)

   function new(input string name, uvm_component parent);
      super.new(name, parent);
   endfunction // new
   
endclass // pipe_sequencer
