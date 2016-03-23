
xemacs -batch verilog/sync_clk_wb.v -l ../custom.el -f verilog-auto -f save-buffer
xemacs -batch verilog/sync_clk_xgmii_tx.v -l ../custom.el -f verilog-auto -f save-buffer
xemacs -batch verilog/sync_clk_core.v -l ../custom.el -f verilog-auto -f save-buffer

xemacs -batch verilog/wishbone_if.v -l ../custom.el -f verilog-auto -f save-buffer
xemacs -batch verilog/fault_sm.v -l ../custom.el -f verilog-auto -f save-buffer

xemacs -batch verilog/rx_dequeue.v -l ../custom.el -f verilog-auto -f save-buffer
xemacs -batch verilog/rx_enqueue.v -l ../custom.el -f verilog-auto -f save-buffer
xemacs -batch verilog/rx_data_fifo.v -l ../custom.el -f verilog-auto -f save-buffer
xemacs -batch verilog/rx_hold_fifo.v -l ../custom.el -f verilog-auto -f save-buffer

xemacs -batch verilog/tx_dequeue.v -l ../custom.el -f verilog-auto -f save-buffer
xemacs -batch verilog/tx_enqueue.v -l ../custom.el -f verilog-auto -f save-buffer
xemacs -batch verilog/tx_data_fifo.v -l ../custom.el -f verilog-auto -f save-buffer
xemacs -batch verilog/tx_hold_fifo.v -l ../custom.el -f verilog-auto -f save-buffer

xemacs -batch verilog/xge_mac.v -l ../custom.el -f verilog-auto -f save-buffer

#xemacs -batch verilog/top_altera.v -l ../custom.el -f verilog-auto -f save-buffer
#xemacs -batch verilog/top_altera_loopback.v -l ../custom.el -f verilog-auto -f save-buffer

#xemacs -batch verilog/loopback_block.v -l ../custom.el -f verilog-auto -f save-buffer


#xemacs -batch ../tbench/verilog/tb_altera.v -l ../../rtl/custom.el -f verilog-auto -f save-buffer
#xemacs -batch ../tbench/verilog/tb_altera_loopback.v -l ../../rtl/custom.el -f verilog-auto -f save-buffer
xemacs -batch ../tbench/verilog/tb_xge_mac.v -l ../../rtl/custom.el -f verilog-auto -f save-buffer

