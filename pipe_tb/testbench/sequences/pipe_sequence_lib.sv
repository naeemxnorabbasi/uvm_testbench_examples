class random_sequence extends uvm_sequence #(data_packet);
   `uvm_object_utils(random_sequence)

   function new(input string name = "random_sequence");
      super.new(name);
   endfunction // new
   
   virtual task body();
      `uvm_do(req);
   endtask // body
   
endclass // random_sequence



class data0_sequence extends uvm_sequence #(data_packet);
   `uvm_object_utils(data0_sequence)

   function new(input string name = "data0_sequence");
      super.new(name);
   endfunction // new
   
   virtual task body();
      `uvm_do_with(req, {req.data_in0 == 16'h0;});
   endtask // body

endclass // data0_sequence



class data1_sequence extends uvm_sequence #(data_packet);
   `uvm_object_utils(data1_sequence)

   function new(input string name = "data1_sequence");
      super.new(name);
   endfunction // new
   
   virtual task body();
      req = data_packet::type_id::create("req");
      start_item(req);
      assert(req.randomize() with {data_in1 == 'hffff;});
      finish_item(req);
   endtask // body
   
endclass // data1_sequence



class many_random_sequence extends uvm_sequence #(data_packet);
   `uvm_object_utils(many_random_sequence)

   rand int loop;

   constraint limit {loop inside {[5:10]};}
   
   function new(input string name = "many_random_sequence");
      super.new(name);
   endfunction // new
   
   virtual task body();
      for(int i = 0; i< loop; i++) begin
	 `uvm_do(req);
      end
   endtask // body
   
endclass // many_random_sequence



