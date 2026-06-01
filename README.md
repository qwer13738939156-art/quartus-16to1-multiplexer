# Quartus 16:1 多路选择器设计项目

## 📋 项目概述

本项目使用 Quartus Prime 实现 **16:1 多路选择器（Multiplexer）**，采用三种不同的 Verilog 设计方法：
1. **原理图法（Schematic）** - 使用层级化的 4:1 MUX
2. **任务法（Task）** - 使用 Verilog 任务模块
3. **函数法（Function）** - 使用 Verilog 函数模块

## 📁 项目结构

```
quartus-16to1-multiplexer/
├── README.md                          # 项目说明文档
├── rtl/                               # RTL 设计文件
│   ├── mux4to1.v                      # 基础 4:1 多路选择器
│   ├── mux16to1_schematic.v           # 方法1：原理图法实现
│   ├── mux16to1_task.v                # 方法2：任务法实现
│   └── mux16to1_function.v            # 方法3：函数法实现
├── sim/                               # 仿真测试文件
│   ├── tb_mux4to1.v                   # 4:1 MUX 测试台
│   └── tb_mux16to1.v                  # 16:1 MUX 测试台
├── constraints/                       # 约束文件
│   └── pins.qsf                       # Quartus 引脚分配示例
└── docs/                              # 文档
    └── design_guide.md                # 详细设计指南
```

## 🎯 功能说明

### 4:1 多路选择器 (mux4to1.v)
- **输入**: 4 个数据输入 (in0, in1, in2, in3)，2 位选择信号 (sel)
- **输出**: 1 个数据输出 (out)
- **功能**: 根据选择信号选择一个输入输出

### 16:1 多路选择器 (三种实现方式)
- **输入**: 16 个数据输入 (in[15:0])，4 位选择信号 (sel[3:0])
- **输出**: 1 个数据输出 (out)
- **功能**: 根据 4 位选择信号选择 16 个输入中的一个

## 🔧 三种实现方法对比

| 方法 | 文件名 | 优点 | 缺点 | 应用场景 |
|------|--------|------|------|----------|
| **原理图法** | mux16to1_schematic.v | 清晰的层级结构，易于理解 | 代码较长 | 教学、验证设计原理 |
| **任务法** | mux16to1_task.v | 代码简洁，便于复用 | 需要理解任务语法 | 中等规模设计 |
| **函数法** | mux16to1_function.v | 最简洁，性能最优 | 函数不能有延时 | 生产设计，综合优化 |

## 🚀 使用方法

### 1. 在 Quartus Prime 中打开项目
```bash
# 打开 Quartus Prime
quartus quartus-16to1-multiplexer.qpf
```

### 2. 添加 RTL 文件
- 进入 **File → New** 创建新工程
- 将 `rtl/` 目录下的 Verilog 文件添加到项目

### 3. 运行仿真
```bash
# 使用 ModelSim 或 Quartus 内置仿真器
# 选择相应的测试台文件 (sim/tb_*.v)
```

### 4. 综合与实现
- **Processing → Start Compilation** - 综合、编译
- **Pin Planner** - 分配引脚（参考 constraints/pins.qsf）
- **Generate Programming File** - 生成编程文件

### 5. 下载到硬件
- 连接 FPGA 开发板
- **Tools → Programmer** - 编程烧录

## 📊 仿真结果

### 4:1 MUX 仿真
```
Time:  0ns | in0=8'h11 in1=8'h22 in2=8'h33 in3=8'h44 | sel=00 | out=8'h11 ✓
Time: 10ns | in0=8'h11 in1=8'h22 in2=8'h33 in3=8'h44 | sel=01 | out=8'h22 ✓
Time: 20ns | in0=8'h11 in1=8'h22 in2=8'h33 in3=8'h44 | sel=10 | out=8'h33 ✓
Time: 30ns | in0=8'h11 in1=8'h22 in2=8'h33 in3=8'h44 | sel=11 | out=8'h44 ✓
```

### 16:1 MUX 仿真
```
Time:  0ns | sel=4'b0000 | out = in[0] ✓
Time: 10ns | sel=4'b0001 | out = in[1] ✓
...
Time:150ns | sel=4'b1111 | out = in[15] ✓
```

## 💡 技术要点

### 1. 原理图法的层级结构
```
16:1 MUX
├── MUX4to1 (sel[1:0] for in[3:0])   → out0
├── MUX4to1 (sel[1:0] for in[7:4])   → out1
├── MUX4to1 (sel[1:0] for in[11:8])  → out2
├── MUX4to1 (sel[1:0] for in[15:12]) → out3
└── MUX4to1 (sel[3:2] for out[3:0])  → final output
```

### 2. 任务法的可复用性
- 使用任务封装选择逻辑
- 支持递归调用处理任意宽度
- 便于修改和维护

### 3. 函数法的性能优势
- 函数内联优化
- 综合工具可进一步优化
- 最终面积和速度都更优

## 📝 引脚分配示例 (DE10-Standard)

详见 `constraints/pins.qsf`

```
数据输入 (16条)
in[0]   → PIN_AB12
in[1]   → PIN_AC12
...
in[15]  → PIN_Y13

选择信号 (4条)
sel[0]  → PIN_AA14
sel[1]  → PIN_AA13
sel[2]  → PIN_AB13
sel[3]  → PIN_AC13

输出 (1条)
out     → PIN_V16
```

## 🧪 测试覆盖

- ✅ 所有 16 个选择条件
- ✅ 边界值测试
- ✅ 随机数据测试
- ✅ 时序验证

## 📚 参考资源

- [Quartus Prime 用户指南](https://www.intel.com/content/www/us/en/programmable/documentation/)
- [Verilog HDL 标准](https://en.wikipedia.org/wiki/Verilog)
- [FPGA 设计最佳实践](https://www.xilinx.com/)

## 📄 许可证

MIT License - 可自由使用和修改

## 👤 作者

项目创建于 2026 年 6 月

---

**⚠️ 注意**: 
- 确保 Quartus Prime 版本 ≥ 18.0
- 支持 Intel/Altera 所有主流 FPGA 芯片
- 建议在 ModelSim 或 Quartus 仿真器中测试
