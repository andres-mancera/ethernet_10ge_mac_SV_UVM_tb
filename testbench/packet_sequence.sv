//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : packet_sequence.sv                                  //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef PACKET_SEQUENCE__SV
`define PACKET_SEQUENCE__SV

`include "packet.sv"


class packet_sequence extends uvm_sequence #(packet);

  int unsigned  num_packets = 100;

  `uvm_object_utils(packet_sequence)

  function new(input string name="packet_sequence");
    super.new(name);
    `uvm_info( get_name(), $sformatf("Hierarchy: %m"), UVM_HIGH )
  endfunction : new


  virtual task body();
    repeat (num_packets) begin
      `uvm_do(req);
    end
  endtask : body


  virtual task pre_start();
    if ( starting_phase != null )
      starting_phase.raise_objection( this );
    uvm_config_db #(int unsigned)::get(null, get_full_name(), "num_packets", num_packets);
  endtask : pre_start


  virtual task post_start();
    if  ( starting_phase != null )
      starting_phase.drop_objection( this );
  endtask : post_start

endclass : packet_sequence

`endif  // PACKET_SEQUENCE__SV
