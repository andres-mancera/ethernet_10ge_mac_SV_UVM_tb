//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : wishbone_sequence.sv                                //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef WISHBONE_SEQUENCE__SV
`define WISHBONE_SEQUENCE__SV

`include "wishbone_item.sv"


class wishbone_init_sequence extends uvm_sequence #(wishbone_item);

  `uvm_object_utils(wishbone_init_sequence)

  function new(input string name="wishbone_init_sequence");
    super.new(name);
    `uvm_info( get_name(), $sformatf("Hierarchy: %m"), UVM_HIGH )
  endfunction : new


  virtual task body();
    // Write to the Configuration register and enable transmission of frames
    `uvm_do_with(req, { xtxn_n==WRITE; xtxn_addr==8'h00; xtxn_data==32'h1; } );
    // Write to the Interrupt Mark register and enable all the interrupts
    `uvm_do_with(req, { xtxn_n==WRITE; xtxn_addr==8'h10; xtxn_data==32'hFFFF_FFFF; } );
  endtask : body


  virtual task pre_start();
    if ( starting_phase != null )
      starting_phase.raise_objection( this );
  endtask : pre_start


  virtual task post_start();
    if  ( starting_phase != null )
      starting_phase.drop_objection( this );
  endtask : post_start

endclass : wishbone_init_sequence




class wishbone_eot_sequence extends uvm_sequence #(wishbone_item);

  `uvm_object_utils(wishbone_eot_sequence)

  function new(input string name="wishbone_eot_sequence");
    super.new(name);
    `uvm_info( get_name(), $sformatf("Hierarchy: %m"), UVM_HIGH )
  endfunction : new


  virtual task body();
    // Read the Configuration register 0
    `uvm_do_with(req, { xtxn_n==READ; xtxn_addr==8'h00; } );
    // Read the Interrupt Pending register
    `uvm_do_with(req, { xtxn_n==READ; xtxn_addr==8'h08; } );
    // Read the Interrupt Status register
    `uvm_do_with(req, { xtxn_n==READ; xtxn_addr==8'h0C; } );
    // Read the Interrupt Mask register
    `uvm_do_with(req, { xtxn_n==READ; xtxn_addr==8'h10; } );
  endtask : body


  virtual task pre_start();
    if ( starting_phase != null )
      starting_phase.raise_objection( this );
  endtask : pre_start


  virtual task post_start();
    if  ( starting_phase != null )
      starting_phase.drop_objection( this );
  endtask : post_start

endclass : wishbone_eot_sequence

`endif  // WISHBONE_SEQUENCE__SV
