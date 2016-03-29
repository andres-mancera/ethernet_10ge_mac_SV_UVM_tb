`ifndef WISHBONE_SEQUENCE__SV
`define WISHBONE_SEQUENCE__SV

`include "wishbone_item.sv"


class wishbone_sequence extends uvm_sequence #(wishbone_item);

  `uvm_object_utils(wishbone_sequence)

  function new(input string name="wishbone_sequence");
    super.new(name);
    `uvm_info( get_name(), $sformatf("Hierarchy: %m"), UVM_HIGH )
  endfunction : new


  virtual task body();
    // Write to the Configuration register and enable transmission of frames
    `uvm_do_with(req, { wr_addr==8'h00; wr_data==32'h1; } );
    // Write to the Interrupt Mark register and enable all the interrupts
    `uvm_do_with(req, { wr_addr==8'h10; wr_data==32'hFFFF_FFFF; } );
  endtask : body


  virtual task pre_start();
    if ( starting_phase != null )
      starting_phase.raise_objection( this );
  endtask : pre_start


  virtual task post_start();
    if  ( starting_phase != null )
      starting_phase.drop_objection( this );
  endtask : post_start

endclass : wishbone_sequence

`endif  // WISHBONE_SEQUENCE__SV
