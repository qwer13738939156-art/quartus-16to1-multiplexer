// ============================================================================
// File: mux4to1.v
// Description: 4:1 Multiplexer (基础构建块)
// Author: FPGA Design
// Date: 2026-06-01
// ============================================================================

module mux4to1 (
    input  [7:0] in0, in1, in2, in3,  // 4个8位数据输入
    input  [1:0] sel,                  // 2位选择信号
    output [7:0] out                   // 8位数据输出
);

    // 使用 always@(*) 块实现多路选择
    always @(*) begin
        case (sel)
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            2'b11: out = in3;
            default: out = 8'hxx;      // 未定义状态
        endcase
    end

endmodule
