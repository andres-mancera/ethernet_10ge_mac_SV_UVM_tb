//////////////////////////////////////////////////////////////////////
//                                                                  //
//  File name : wishbone_item.sv                                    //
//  Author    : G. Andres Mancera                                   //
//  License   : GNU Lesser General Public License                   //
//  Course    : System and Functional Verification Using UVM        //
//              UCSC Silicon Valley Extension                       //
//                                                                  //
//////////////////////////////////////////////////////////////////////
`ifndef WISHBONE_ITEM__SV
`define WISHBONE_ITEM__SV


class wishbone_item extends uvm_sequence_item;

  typedef enum bit { READ=0, WRITE=1 } xtxn_mode;

  rand xtxn_mode    xtxn_n;
  rand bit[7:0]     xtxn_addr;
  rand bit[31:0]    xtxn_data;

  `uvm_object_utils_begin(wishbone_item)
    `uvm_field_enum( xtxn_mode, xtxn_n  , UVM_DEFAULT )
    `uvm_field_int( xtxn_addr           , UVM_DEFAULT )
    `uvm_field_int( xtxn_data           , UVM_DEFAULT )
  `uvm_object_utils_end

  // ======== Constraints ========
  constraint C_xtxn_addr {
    xtxn_addr == 8'h00 ||   // Configuration register 0   : Address 0x00
    xtxn_addr == 8'h08 ||   // Interrupt Pending Register : Address 0x08
    xtxn_addr == 8'h0C ||   // Interrupt Status Register  : Address 0x0C
    xtxn_addr == 8'h10;     // Interrupt Mask Register    : Address 0x010
  }

  function new(input string name="wishbone_item");
    super.new();
  endfunction : new

endclass : wishbone_item

`endif // WISHBONE_ITEM__SV
