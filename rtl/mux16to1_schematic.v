// ============================================================================
// File: mux16to1_schematic.v
// Description: 16:1 Multiplexer - 原理图法实现 (层级化4:1 MUX)
// Author: FPGA Design
// Date: 2026-06-01
// 
// 实现原理:
// 使用5个4:1多路选择器构成树形结构
// 第一级：4个4:1 MUX分别选择in[3:0], in[7:4], in[11:8], in[15:12]
// 第二级：1个4:1 MUX选择第一级的输出
// ============================================================================

module mux16to1_schematic (
    input  [15:0] in,      // 16位数据输入
    input  [3:0]  sel,     // 4位选择信号
    output [7:0]  out      // 8位数据输出
);

    wire [7:0] out0, out1, out2, out3;  // 第一级4:1 MUX的输出

    // 第一级：4个4:1多路选择器
    mux4to1 mux0 (.in0(in[0]), .in1(in[1]), .in2(in[2]), .in3(in[3]), 
                  .sel(sel[1:0]), .out(out0));
    
    mux4to1 mux1 (.in0(in[4]), .in1(in[5]), .in2(in[6]), .in3(in[7]), 
                  .sel(sel[1:0]), .out(out1));
    
    mux4to1 mux2 (.in0(in[8]), .in1(in[9]), .in2(in[10]), .in3(in[11]), 
                  .sel(sel[1:0]), .out(out2));
    
    mux4to1 mux3 (.in0(in[12]), .in1(in[13]), .in2(in[14]), .in3(in[15]), 
                  .sel(sel[1:0]), .out(out3));

    // 第二级：1个4:1多路选择器选择第一级的输出
    mux4to1 mux_final (.in0(out0), .in1(out1), .in2(out2), .in3(out3), 
                       .sel(sel[3:2]), .out(out));

endmodule
