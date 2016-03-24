`include "packet.sv"


class packet_sequence extends uvm_sequence #(packet);

   `uvm_object_utils(packet_sequence)

endclass : packet_sequence
