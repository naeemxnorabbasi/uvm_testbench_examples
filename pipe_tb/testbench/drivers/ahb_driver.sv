class ahb_driver extends uvm_driver #(ahb_transfer);
   virtual ahb_if vif;
   string  ahb_intf;

   typedef enum	bit [2:0] {SINGLE, INC, WRAP4, INCR4, WRAP8, INC8, WRAP16, INCR16} hburst_t;
   typedef enum	bit [2:0] {HSIZE_8, HSIZE_16, HSIZE_32} hsize_t;   
   typedef enum	bit [1:0] {IDLE, BUSY, NONSEQ, SEQ} htrans_t;
   typedef enum	bit {OK, ERROR} hresp_t;
   typedef enum	bit {READ, WRITE} hwrite_t;
   typedef enum	bit {NOT_READY, READY} hready_t;

   mailbox #(ahb_transfer) address_box = new(1);
   mailbox #(ahb_transfer) data_box = new(1);   

   function new(input string name, uvm_component parent);
      super.new(name, parent);
   endfunction // new

   virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      if(!uvm_config_db #(virtual ahb_if)::get(this,"","ahb_intf",vif)) 
	`uvm_fatal("NOVIF",{"virtual interface must be set for:",get_full_name(),".vif"});

      `uvm_info(get_full_name(), "Build phase complete.", UVM_LOW)
      
   endfunction // build_phase

   virtual task run_phase(uvm_phase phase);
      fork
	 reset();
	 get_and_drive();
	 address_phase();
	 data_phase();
      join
   endtask // run_phase

   virtual task reset();
      @(negedge vif.hresetn);
      `uvm_info(get_type_name(), "RESETTING SYSTEM", UVM_LOW)
      vif.hsel <= 1'b0;
      vif.haddr <= 32'b0;      
      vif.hwrite <= READ;      
      vif.hsize <= HSIZE_8;      
      vif.hbusrt <= SINGLE;      
      vif.hprot <= 4'b0;      
      vif.htrans <= IDLE;      
      vif.hmastlock <= 1'b0;      
      vif.hready <= READY;      
      vif.hwdata <= 32'b0;      

      `uvm_info(get_type_name(), "DONE RESETTING SYSTEM", UVM_LOW)

   endtask // reset

   virtual task get_and_drive();
      ahb_transfer pkt;
      forever begin
	 @(posedge vif.hrestn);
	 `uvm_info(get_type_name(),"DRIVING SYSTEM", UVM_LOW )
	 while(vif/hresetn != 1'b0) begin
	    seq_item_port.get_next_item(req);
	    $cast(pkt,req.clone());
	    address_box.put(pkt);
	    seq_item_port.item_done();
	 end
      end
      
   endtask // get_and_drive


   virtual task address_phase();
      ahb_transfer addr_pkt;
      forever begin
	 vif.htrans <= IDLE;
	 address_box.get(addr_pkt);
	 while(vif.hready == NOT_READY) begin
	    @(posedge vif.hclk);
	 end
	 
	 vif.haddr <= addr_pkt.haddr;
	 vif.hbusrt <= addr_pkt.hbusrt;
	 vif.hmastlock <= addr_pkt.hmastlock;
	 vif.hprot <= addr_pkt.hprot;
	 vif.hsize <= addr_pkt.hsize;
	 vif.hwrite <= addr_pkt.hwrite;
	 vif.htrans <= addr_pkt.htrans;
	 vif.addr <= 1'b1; /*only one slave*/

	 @(posedge vif.hclk);
	 data_box.put(addr_pkt);
	 
      end
   endtask // address_phase

   virtual task data_phase();
      ahb_transfer data_pkt;
      forever begin
	 data_box.get(data_pkt);

	 if(data_pkt.hwrite == WRITE) begin
	    vif.hwdata <= data_pkt.hwdata;
	    `uvm_info(get_type_name(),$sformatf("WRITING DATA: %0h at %0t",data_pkt.hwdata,$time),UVM_LOW)

	    while(vif.hready == NOT_READY) begin
	       @(posedge vif.hclk);
	    end
	 end

	 if(data_pkt.hwrite == READ) begin
	    @(posedge vif.hclk);
	    
	    while(vif.hready == NOT_READY) begin
	       @(posedge vif.hclk);
	    end

	    vif.hrdata <= data_pkt.hrdata;
	    `uvm_info(get_type_name(),$sformatf("READING DATA: %0h at %0t",data_pkt.hwdata,$time),UVM_LOW)
	 end
	 seq_item_port.put(data_pkt);
      end
   endtask // data_phase
   
endclass // ahb_driver
