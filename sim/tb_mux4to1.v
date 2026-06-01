// ============================================================================
// File: tb_mux4to1.v
// Description: 4:1 Multiplexer 测试台 (Test Bench)
// Author: FPGA Design
// Date: 2026-06-01
// ============================================================================

`timescale 1ns / 1ps

module tb_mux4to1;

    // 声明测试信号
    reg [7:0] in0, in1, in2, in3;
    reg [1:0] sel;
    wire [7:0] out;
    integer i;

    // 实例化被测试单元 (DUT: Device Under Test)
    mux4to1 dut (
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .sel(sel),
        .out(out)
    );

    // 初始化和测试过程
    initial begin
        // 设置输入数据
        in0 = 8'h11;
        in1 = 8'h22;
        in2 = 8'h33;
        in3 = 8'h44;

        // 打印表头
        $display("\n========== 4:1 Multiplexer 仿真开始 ==========");
        $display("Time(ns) | in0    | in1    | in2    | in3    | sel | out    | Status");
        $display("---------------------------------------------------------------------------");

        // 测试所有4种选择条件
        for (i = 0; i < 4; i = i + 1) begin
            sel = i[1:0];
            #10;
            $display("%7d | 0x%-4h | 0x%-4h | 0x%-4h | 0x%-4h | %2b | 0x%-4h | %s",
                     $time, in0, in1, in2, in3, sel, out,
                     (check_output(out) ? "✓ PASS" : "✗ FAIL"));
        end

        // 测试随机数据
        $display("\n========== 随机数据测试 ==========");
        for (i = 0; i < 8; i = i + 1) begin
            in0 = $random % 256;
            in1 = $random % 256;
            in2 = $random % 256;
            in3 = $random % 256;
            sel = $random % 4;
            #10;
            $display("%7d | 0x%-4h | 0x%-4h | 0x%-4h | 0x%-4h | %2b | 0x%-4h | %s",
                     $time, in0, in1, in2, in3, sel, out,
                     (check_output(out) ? "✓ PASS" : "✗ FAIL"));
        end

        $display("\n========== 仿真完成 ==========");
        $finish;  // 结束仿真
    end

    // 验证函数：检查输出是否正确
    function check_output;
        input [7:0] result;
        begin
            case (sel)
                2'b00: check_output = (result == in0);
                2'b01: check_output = (result == in1);
                2'b10: check_output = (result == in2);
                2'b11: check_output = (result == in3);
                default: check_output = 0;
            endcase
        end
    endfunction

endmodule
