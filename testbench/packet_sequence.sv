`ifndef PACKET_SEQUENCE__SV
`define PACKET_SEQUENCE__SV

`include "packet.sv"


class packet_sequence extends uvm_sequence #(packet);

  `uvm_object_utils(packet_sequence)

  function new(input string name="packet_sequence");
    super.new(name);
    `uvm_info( get_name(), $sformatf("Hierarchy: %m"), UVM_HIGH )
  endfunction : new


  virtual task body();
    repeat(5) begin
      `uvm_do(req);
    end
  endtask : body


  virtual task pre_start();
    if ( starting_phase != null )
      starting_phase.raise_objection( this );
  endtask : pre_start


  virtual task post_start();
    if  ( starting_phase != null )
      starting_phase.drop_objection( this );
  endtask : post_start

endclass : packet_sequence

`endif  // PACKET_SEQUENCE__SV
