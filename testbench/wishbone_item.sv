`ifndef WISHBONE_ITEM__SV
`define WISHBONE_ITEM__SV


class wishbone_item extends uvm_sequence_item;

  rand bit[7:0]     wr_addr;
  rand bit[31:0]    wr_data;

  `uvm_object_utils_begin(wishbone_item)
    `uvm_field_int( wr_addr     , UVM_DEFAULT )
    `uvm_field_int( wr_data     , UVM_DEFAULT )
  `uvm_object_utils_end

  // ======== Constraints ========
  constraint C_wr_addr {
    wr_addr == 8'h00 ||     // Configuration register 0   : Address 0x00
    wr_addr == 8'h08 ||     // Interrupt Pending Register : Address 0x08
    wr_addr == 8'h0C ||     // Interrupt Status Register  : Address 0x0C
    wr_addr == 8'h10;       // Interrupt Mask Register    : Address 0x010
  }

  function new(input string name="wishbone_item");
    super.new();
  endfunction : new

endclass : wishbone_item

`endif // WISHBONE_ITEM__SV
