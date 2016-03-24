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
    `uvm_do(req);
  endtask : body

endclass : packet_sequence

`endif // PACKET_SEQUENCE__SV
