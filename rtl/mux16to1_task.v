// ============================================================================
// File: mux16to1_task.v
// Description: 16:1 Multiplexer - 任务法实现
// Author: FPGA Design
// Date: 2026-06-01
//
// 实现原理:
// 使用Verilog任务(task)封装选择逻辑，提高代码复用性和可维护性
// 任务可以递归调用，支持任意宽度的多路选择器
// ============================================================================

module mux16to1_task (
    input  [15:0] in,      // 16位数据输入
    input  [3:0]  sel,     // 4位选择信号
    output reg [7:0] out   // 8位数据输出
);

    // 任务定义：选择函数
    task select_mux;
        input [15:0] data;     // 输入数据
        input [3:0] select;    // 选择信号
        output [7:0] result;   // 结果输出
        begin
            case (select)
                4'b0000: result = data[7:0];
                4'b0001: result = data[15:8];
                4'b0010: result = {data[7], data[14:8]};
                4'b0011: result = {data[7], data[6], data[13:8]};
                4'b0100: result = {data[7:5], data[12:8]};
                4'b0101: result = {data[7:4], data[11:8]};
                4'b0110: result = {data[7:6], data[13:8]};
                4'b0111: result = {data[7:5], data[12:8]};
                4'b1000: result = {data[7:4], data[11:8]};
                4'b1001: result = {data[7:6], data[13:8]};
                4'b1010: result = {data[7:5], data[12:8]};
                4'b1011: result = {data[7:4], data[11:8]};
                4'b1100: result = data[15:8];
                4'b1101: result = data[15:8];
                4'b1110: result = data[15:8];
                4'b1111: result = data[15:8];
                default: result = 8'hxx;
            endcase
        end
    endtask

    // 使用任务实现16:1多路选择器
    always @(*) begin
        select_mux(in, sel, out);
    end

endmodule
