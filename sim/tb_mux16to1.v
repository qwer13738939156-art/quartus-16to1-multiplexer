// ============================================================================
// File: tb_mux16to1.v
// Description: 16:1 Multiplexer 测试台 (Test Bench)
// Author: FPGA Design
// Date: 2026-06-01
//
// 可以选择测试以下任一模块:
// - mux16to1_schematic  (原理图法)
// - mux16to1_task       (任务法)
// - mux16to1_function   (函数法)
// ============================================================================

`timescale 1ns / 1ps

module tb_mux16to1;

    // 声明测试信号
    reg [15:0] in;
    reg [3:0]  sel;
    wire [7:0] out;
    integer i, j, pass_count, fail_count;

    // 选择要测试的实现方式 (修改下面的注释)
    mux16to1_schematic dut (  // 可改为: mux16to1_task 或 mux16to1_function
        .in(in),
        .sel(sel),
        .out(out)
    );

    // 初始化和测试过程
    initial begin
        pass_count = 0;
        fail_count = 0;

        // 打印表头
        $display("\n========== 16:1 Multiplexer 仿真开始 ==========");
        $display("\nTest 1: 基本功能测试 (所有16个选择条件)");
        $display("---------------------------------------------------------------------------");
        $display("Time(ns) | in[15:0] | sel[3:0] | out[7:0] | Expected | Status");
        $display("---------------------------------------------------------------------------");

        // 初始化输入数据: in[i] = 8'h10 + i
        for (i = 0; i < 16; i = i + 1) begin
            in[i*8 +: 8] = 8'h10 + i;  // in[0:7]=0x10, in[8:15]=0x11, ...
        end

        // 测试所有16个选择条件
        for (sel = 0; sel < 16; sel = sel + 1) begin
            #10;
            begin
                reg [7:0] expected;
                expected = 8'h10 + sel;
                if (out == expected) begin
                    pass_count = pass_count + 1;
                    $display("%7d | 0x%-4h | %4b | 0x%-4h | 0x%-4h | ✓ PASS",
                             $time, in, sel, out, expected);
                end else begin
                    fail_count = fail_count + 1;
                    $display("%7d | 0x%-4h | %4b | 0x%-4h | 0x%-4h | ✗ FAIL",
                             $time, in, sel, out, expected);
                end
            end
        end

        // 随机测试
        $display("\nTest 2: 随机数据测试");
        $display("---------------------------------------------------------------------------");
        for (i = 0; i < 16; i = i + 1) begin
            for (j = 0; j < 16; j = j + 1) begin
                in[j*8 +: 8] = $random % 256;  // 随机生成8位数据
            end
            sel = $random % 16;  // 随机选择
            #10;
            begin
                reg [7:0] expected;
                expected = in[sel*8 +: 8];
                if (out == expected) begin
                    pass_count = pass_count + 1;
                end else begin
                    fail_count = fail_count + 1;
                    $display("%7d | Random data | sel=%4b | out=0x%-4h | expected=0x%-4h | ✗ FAIL",
                             $time, sel, out, expected);
                end
            end
        end

        // 打印测试总结
        $display("\n========== 仿真统计 ==========");
        $display("总测试数: %d", pass_count + fail_count);
        $display("通过数:   %d ✓", pass_count);
        $display("失败数:   %d ✗", fail_count);
        if (fail_count == 0) begin
            $display("\n【结果】所有测试通过！✓");
        end else begin
            $display("\n【结果】有 %d 个测试失败！✗", fail_count);
        end
        $display("========== 仿真完成 ==========");

        $finish;  // 结束仿真
    end

endmodule
