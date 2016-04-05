//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : packet.sv                                           //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
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

endclass : packet




class packet_bringup extends packet;

  `uvm_object_utils( packet_bringup )

  constraint C_bringup 
    {
      mac_dst_addr      == 48'hAABB_CCDD_EEFF;
      mac_src_addr      == 48'h1122_3344_5566;
      ether_type        dist { 16'h0800:=34, 16'h0806:=33, 16'h88DD:=33 };  // IPv4, ARP, IPv6
      payload.size()    inside {[45:54]};
      foreach( payload[j] )
        {
          payload[j]  == j+1;
        }
      ipg             == 10;
  }

  function new(input string name="packet_bringup");
    super.new(name);
  endfunction : new

endclass : packet_bringup




class packet_oversized extends packet;

  `uvm_object_utils( packet_oversized )

  constraint C_payload_size
    {
      payload.size() inside {[1501:9000]};
    }

  function new(input string name="packet_oversized");
    super.new(name);
  endfunction : new

endclass : packet_oversized




class packet_undersized extends packet;

  `uvm_object_utils( packet_undersized )

  constraint C_payload_size
    {
      // When payload size is less then 46B, the DUT is supposed
      // to pad the packet to the minimum 64B required for Ethernet.
      payload.size() inside {[1:45]};
    }

  function new(input string name="packet_undersized");
    super.new(name);
  endfunction : new

endclass : packet_undersized




class packet_small_large extends packet;

  `uvm_object_utils( packet_small_large )

  constraint C_payload_size
    {
      payload.size() dist { [46:50]:/50, [1456:1500]:/50 };
    }

  function new(input string name="packet_small_large");
    super.new(name);
  endfunction : new

endclass : packet_small_large




class packet_small_ipg extends packet;

  `uvm_object_utils( packet_small_ipg )

  constraint C_ipg
    {
      ipg inside {[1:10]};
    }

  function new(input string name="packet_small_ipg");
    super.new(name);
  endfunction : new

endclass : packet_small_ipg




class packet_zero_ipg extends packet;

  `uvm_object_utils( packet_zero_ipg )

  constraint C_ipg
    {
      ipg == 0;
    }

  function new(input string name="packet_zero_ipg");
    super.new(name);
  endfunction : new

endclass : packet_zero_ipg



`endif // PACKET__SV
