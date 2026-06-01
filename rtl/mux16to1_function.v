// ============================================================================
// File: mux16to1_function.v
// Description: 16:1 Multiplexer - 函数法实现
// Author: FPGA Design
// Date: 2026-06-01
//
// 实现原理:
// 使用Verilog函数(function)实现多路选择逻辑
// 函数可被内联优化，性能最优，综合结果最佳
// 函数不能含有延时和时序操作，纯组合逻辑
// ============================================================================

module mux16to1_function (
    input  [15:0] in,      // 16位数据输入
    input  [3:0]  sel,     // 4位选择信号
    output [7:0]  out      // 8位数据输出
);

    // 函数定义：多路选择器函数
    function [7:0] select_input;
        input [15:0] data;     // 16位输入数据
        input [3:0] index;     // 4位选择索引
        begin
            case (index)
                4'b0000: select_input = data[7:0];
                4'b0001: select_input = data[15:8];
                4'b0010: select_input = {data[6:0], 1'b0};
                4'b0011: select_input = {data[5:0], 2'b0};
                4'b0100: select_input = {data[4:0], 3'b0};
                4'b0101: select_input = {data[3:0], 4'b0};
                4'b0110: select_input = {data[2:0], 5'b0};
                4'b0111: select_input = {data[1:0], 6'b0};
                4'b1000: select_input = {data[0], 7'b0};
                4'b1001: select_input = 8'b0;
                4'b1010: select_input = data[7:0];
                4'b1011: select_input = data[15:8];
                4'b1100: select_input = {data[14:8], data[0]};
                4'b1101: select_input = {data[13:8], data[1:0]};
                4'b1110: select_input = {data[12:8], data[2:0]};
                4'b1111: select_input = {data[11:8], data[3:0]};
                default: select_input = 8'hxx;
            endcase
        end
    endfunction

    // 使用函数实现组合逻辑输出
    assign out = select_input(in, sel);

endmodule
