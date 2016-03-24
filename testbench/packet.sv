`ifndef PACKET__SV
`define PACKET__SV


class packet extends uvm_sequence_item;

  // Signals to be driven into the RTL
  rand bit [47:0]       mac_dst_addr;       // 6 Bytes
  rand bit [47:0]       mac_src_addr;       // 6 Bytes
  rand bit [15:0]       ether_type;         // 2 Bytes
  rand bit [7:0]        payload [];
  rand bit [31:0]       ipg;                // interpacket gap

  // Signals unrelated to the RTL
  rand bit              sop_mark;
  rand bit              eop_mark;

  `uvm_object_utils_begin(packet)
    `uvm_field_int( mac_dst_addr    , UVM_DEFAULT )
    `uvm_field_int( mac_src_addr    , UVM_DEFAULT )
    `uvm_field_int( ether_type      , UVM_DEFAULT )
    `uvm_field_array_int( payload   , UVM_DEFAULT )
    `uvm_field_int( ipg             , UVM_DEFAULT )
  `uvm_object_utils_end

  // ======== Constraints ========
  constraint C_proper_sop_eop_marks {
    sop_mark == 1;  // SOP mark should be driven
    eop_mark == 1;  // EOP mark should be driven
  }

  constraint C_payload_size {
    payload.size() inside {[46:1500]};
  }

  constraint C_ipg {
    ipg inside {[10:50]};
  }

  function new(input string name="packet");
    super.new();
  endfunction : new

  // FIXME: Decide if adding get/set methods is worth.

endclass : packet

`endif // PACKET__SV
