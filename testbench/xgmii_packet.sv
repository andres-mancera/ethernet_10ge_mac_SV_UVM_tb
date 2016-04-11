//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : xgmii_packet.sv                                     //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef XGMII_PACKET__SV
`define XGMII_PACKET__SV


class xgmii_packet extends uvm_sequence_item;

  // Signals to be driven into the RTL
  rand bit [7:0]        control;            // 1 Byte
  rand bit [63_0]       data;               // 8 Bytes

  `uvm_object_utils_begin(xgmii_packet)
    `uvm_field_int( control     , UVM_DEFAULT )
    `uvm_field_int( data        , UVM_DEFAULT )
  `uvm_object_utils_end

  function new(input string name="xgmii_packet");
    super.new();
  endfunction : new

endclass : xgmii_packet

`endif // XGMII_PACKET__SV
