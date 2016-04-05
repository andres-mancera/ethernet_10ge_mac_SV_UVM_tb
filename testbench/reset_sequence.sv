//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : reset_sequence.sv                                   //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef RESET_SEQUENCE__SV
`define RESET_SEQUENCE__SV

`include "reset_item.sv"


class reset_sequence extends uvm_sequence #(reset_item);

  `uvm_object_utils(reset_sequence)

  function new(input string name="reset_sequence");
    super.new(name);
    `uvm_info( get_name(), $sformatf("Hierarchy: %m"), UVM_HIGH )
  endfunction : new


  virtual task body();
    `uvm_do_with(req, { reset_n==LOW; } );
    `uvm_do_with(req, { reset_n==HIGH; } );
  endtask : body


  virtual task pre_start();
    if ( starting_phase != null )
      starting_phase.raise_objection( this );
  endtask : pre_start


  virtual task post_start();
    if  ( starting_phase != null )
      starting_phase.drop_objection( this );
  endtask : post_start

endclass : reset_sequence

`endif  // RESET_SEQUENCE__SV
