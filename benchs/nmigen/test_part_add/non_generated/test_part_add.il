attribute \generator "nMigen"
attribute \nmigen.hierarchy "top.add1.ripple"
module \ripple
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:51"
  wire width 4 input 0 \results_in
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:52"
  wire width 3 input 1 \gates
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:53"
  wire width 4 output 2 \output
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:59"
  wire width 4 \intermed
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:64"
  wire width 1 $1
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:64"
  cell $mux $2
    parameter \WIDTH 1'1
    connect \A \intermed [3]
    connect \B \results_in [2]
    connect \S \gates [2]
    connect \Y $1
  end
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:64"
  wire width 1 $3
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:64"
  cell $mux $4
    parameter \WIDTH 1'1
    connect \A \intermed [2]
    connect \B \results_in [1]
    connect \S \gates [1]
    connect \Y $3
  end
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:64"
  wire width 1 $5
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:64"
  cell $mux $6
    parameter \WIDTH 1'1
    connect \A \intermed [1]
    connect \B \results_in [0]
    connect \S \gates [0]
    connect \Y $5
  end
  process $group_0
    assign \intermed 4'0000
    assign \intermed [3] \results_in [3]
    assign \intermed [2] $1
    assign \intermed [1] $3
    assign \intermed [0] $5
    sync init
  end
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:70"
  wire width 1 $7
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:70"
  cell $and $8
    parameter \A_SIGNED 1'0
    parameter \A_WIDTH 1'1
    parameter \B_SIGNED 1'0
    parameter \B_WIDTH 1'1
    parameter \Y_WIDTH 1'1
    connect \A \gates [0]
    connect \B \intermed [1]
    connect \Y $7
  end
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:70"
  wire width 1 $9
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:70"
  cell $and $10
    parameter \A_SIGNED 1'0
    parameter \A_WIDTH 1'1
    parameter \B_SIGNED 1'0
    parameter \B_WIDTH 1'1
    parameter \Y_WIDTH 1'1
    connect \A \gates [1]
    connect \B \intermed [2]
    connect \Y $9
  end
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:70"
  wire width 1 $11
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:70"
  cell $and $12
    parameter \A_SIGNED 1'0
    parameter \A_WIDTH 1'1
    parameter \B_SIGNED 1'0
    parameter \B_WIDTH 1'1
    parameter \Y_WIDTH 1'1
    connect \A \gates [2]
    connect \B \intermed [3]
    connect \Y $11
  end
  process $group_1
    assign \output 4'0000
    assign \output { $11 $9 $7 \intermed [0] }
    sync init
  end
end
attribute \generator "nMigen"
attribute \nmigen.hierarchy "top.add1"
module \add1
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:178"
  wire width 16 input 0 \a
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:179"
  wire width 16 input 1 \b
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:180"
  wire width 4 input 2 \carry_in
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:182"
  wire width 16 output 3 \output
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:181"
  wire width 4 output 4 \carry_out
  attribute \src "examples/top.py:41"
  wire width 3 input 5 \pmask
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:51"
  wire width 4 \ripple_results_in
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:52"
  wire width 3 \ripple_gates
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_cmp/ripple.py:53"
  wire width 4 \ripple_output
  cell \ripple \ripple
    connect \results_in \ripple_results_in
    connect \gates \ripple_gates
    connect \output \ripple_output
  end
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:229"
  wire width 1 \a_bit_3
  attribute \src "/home/lkcl/nmigen/nmigen/hdl/ast.py:275"
  wire width 1 $1
  attribute \src "/home/lkcl/nmigen/nmigen/hdl/ast.py:275"
  cell $not $2
    parameter \A_SIGNED 1'0
    parameter \A_WIDTH 1'1
    parameter \Y_WIDTH 1'1
    connect \A \pmask [0]
    connect \Y $1
  end
  attribute \src "/home/lkcl/nmigen/nmigen/hdl/ast.py:275"
  wire width 1 $3
  attribute \src "/home/lkcl/nmigen/nmigen/hdl/ast.py:275"
  cell $or $4
    parameter \A_SIGNED 1'0
    parameter \A_WIDTH 1'1
    parameter \B_SIGNED 1'0
    parameter \B_WIDTH 1'1
    parameter \Y_WIDTH 1'1
    connect \A $1
    connect \B \carry_in [1]
    connect \Y $3
  end
  process $group_0
    assign \a_bit_3 1'0
    assign \a_bit_3 $3
    sync init
  end
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:229"
  wire width 1 \a_bit_6
  attribute \src "/home/lkcl/nmigen/nmigen/hdl/ast.py:275"
  wire width 1 $5
  attribute \src "/home/lkcl/nmigen/nmigen/hdl/ast.py:275"
  cell $not $6
    parameter \A_SIGNED 1'0
    parameter \A_WIDTH 1'1
    parameter \Y_WIDTH 1'1
    connect \A \pmask [1]
    connect \Y $5
  end
  attribute \src "/home/lkcl/nmigen/nmigen/hdl/ast.py:275"
  wire width 1 $7
  attribute \src "/home/lkcl/nmigen/nmigen/hdl/ast.py:275"
  cell $or $8
    parameter \A_SIGNED 1'0
    parameter \A_WIDTH 1'1
    parameter \B_SIGNED 1'0
    parameter \B_WIDTH 1'1
    parameter \Y_WIDTH 1'1
    connect \A $5
    connect \B \carry_in [2]
    connect \Y $7
  end
  process $group_1
    assign \a_bit_6 1'0
    assign \a_bit_6 $7
    sync init
  end
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:229"
  wire width 1 \a_bit_9
  attribute \src "/home/lkcl/nmigen/nmigen/hdl/ast.py:275"
  wire width 1 $9
  attribute \src "/home/lkcl/nmigen/nmigen/hdl/ast.py:275"
  cell $not $10
    parameter \A_SIGNED 1'0
    parameter \A_WIDTH 1'1
    parameter \Y_WIDTH 1'1
    connect \A \pmask [2]
    connect \Y $9
  end
  attribute \src "/home/lkcl/nmigen/nmigen/hdl/ast.py:275"
  wire width 1 $11
  attribute \src "/home/lkcl/nmigen/nmigen/hdl/ast.py:275"
  cell $or $12
    parameter \A_SIGNED 1'0
    parameter \A_WIDTH 1'1
    parameter \B_SIGNED 1'0
    parameter \B_WIDTH 1'1
    parameter \Y_WIDTH 1'1
    connect \A $9
    connect \B \carry_in [3]
    connect \Y $11
  end
  process $group_2
    assign \a_bit_9 1'0
    assign \a_bit_9 $11
    sync init
  end
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:200"
  wire width 21 \expanded_a
  process $group_3
    assign \expanded_a 21'000000000000000000000
    assign { \expanded_a [19] \expanded_a [18] \expanded_a [17] \expanded_a [16] \expanded_a [15] \expanded_a [14] \expanded_a [13] \expanded_a [12] \expanded_a [11] \expanded_a [10] \expanded_a [9] \expanded_a [8] \expanded_a [7] \expanded_a [6] \expanded_a [5] \expanded_a [4] \expanded_a [3] \expanded_a [2] \expanded_a [1] \expanded_a [0] } { 1'0 \a [15] \a [14] \a [13] \a [12] \a [11] \a [10] \a [9] \a_bit_9 \a [8] \a [7] \a [6] \a_bit_6 \a [5] \a [4] \a [3] \a_bit_3 \a [2] \a [1] \a [0] \carry_in [0] } [19:0]
    sync init
  end
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:201"
  wire width 21 \expanded_b
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:237"
  wire width 1 $13
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:237"
  cell $and $14
    parameter \A_SIGNED 1'0
    parameter \A_WIDTH 1'1
    parameter \B_SIGNED 1'0
    parameter \B_WIDTH 1'1
    parameter \Y_WIDTH 1'1
    connect \A \carry_in [1]
    connect \B \pmask [0]
    connect \Y $13
  end
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:237"
  wire width 1 $15
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:237"
  cell $and $16
    parameter \A_SIGNED 1'0
    parameter \A_WIDTH 1'1
    parameter \B_SIGNED 1'0
    parameter \B_WIDTH 1'1
    parameter \Y_WIDTH 1'1
    connect \A \carry_in [2]
    connect \B \pmask [1]
    connect \Y $15
  end
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:237"
  wire width 1 $17
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:237"
  cell $and $18
    parameter \A_SIGNED 1'0
    parameter \A_WIDTH 1'1
    parameter \B_SIGNED 1'0
    parameter \B_WIDTH 1'1
    parameter \Y_WIDTH 1'1
    connect \A \carry_in [3]
    connect \B \pmask [2]
    connect \Y $17
  end
  process $group_4
    assign \expanded_b 21'000000000000000000000
    assign { \expanded_b [19] \expanded_b [18] \expanded_b [17] \expanded_b [16] \expanded_b [15] \expanded_b [14] \expanded_b [13] \expanded_b [12] \expanded_b [11] \expanded_b [10] \expanded_b [9] \expanded_b [8] \expanded_b [7] \expanded_b [6] \expanded_b [5] \expanded_b [4] \expanded_b [3] \expanded_b [2] \expanded_b [1] \expanded_b [0] } { 1'0 \b [15] \b [14] \b [13] \b [12] \b [11] \b [10] \b [9] $17 \b [8] \b [7] \b [6] $15 \b [5] \b [4] \b [3] $13 \b [2] \b [1] \b [0] \carry_in [0] } [19:0]
    sync init
  end
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:202"
  wire width 21 \expanded_o
  process $group_5
    assign \output 16'0000000000000000
    assign { \output [15] \output [14] \output [13] \output [12] \output [11] \output [10] \output [9] \output [8] \output [7] \output [6] \output [5] \output [4] \output [3] \output [2] \output [1] \output [0] } { \expanded_o [19] \expanded_o [18] \expanded_o [17] \expanded_o [16] \expanded_o [15] \expanded_o [14] \expanded_o [13] \expanded_o [11] \expanded_o [10] \expanded_o [9] \expanded_o [7] \expanded_o [6] \expanded_o [5] \expanded_o [3] \expanded_o [2] \expanded_o [1] }
    sync init
  end
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:197"
  wire width 4 \carry_tmp
  process $group_6
    assign \carry_tmp 4'0000
    assign { \carry_tmp [3] \carry_tmp [2] \carry_tmp [1] \carry_tmp [0] } { \expanded_o [20] \expanded_o [12] \expanded_o [8] \expanded_o [4] }
    sync init
  end
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:262"
  wire width 22 $19
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:262"
  wire width 22 $20
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:262"
  cell $add $21
    parameter \A_SIGNED 1'0
    parameter \A_WIDTH 5'10101
    parameter \B_SIGNED 1'0
    parameter \B_WIDTH 5'10101
    parameter \Y_WIDTH 5'10110
    connect \A \expanded_a
    connect \B \expanded_b
    connect \Y $20
  end
  connect $19 $20
  process $group_7
    assign \expanded_o 21'000000000000000000000
    assign \expanded_o $19 [20:0]
    sync init
  end
  process $group_8
    assign \ripple_results_in 4'0000
    assign \ripple_results_in \carry_tmp
    sync init
  end
  process $group_9
    assign \ripple_gates 3'000
    assign \ripple_gates { \pmask [2] \pmask [1] \pmask [0] }
    sync init
  end
  process $group_10
    assign \carry_out 4'0000
    assign \carry_out \ripple_output
    sync init
  end
end
attribute \generator "nMigen"
attribute \top 1
attribute \nmigen.hierarchy "top"
module \top
  attribute \src "examples/top.py:41"
  wire width 3 input 0 \pmask
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part/partsig.py:41"
  wire width 16 input 1 \sig
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part/partsig.py:41"
  wire width 16 input 2 \sig$1
  attribute \src "examples/top.py:22"
  wire width 16 output 3 \add_output
  attribute \src "examples/top.py:22"
  wire width 16 \add_output$next
  attribute \src "examples/top.py:23"
  wire width 4 input 4 \carry_in
  attribute \src "examples/top.py:24"
  wire width 4 output 5 \add_carry_out
  attribute \src "examples/top.py:24"
  wire width 4 \add_carry_out$next
  attribute \src "/home/lkcl/nmigen/nmigen/hdl/ir.py:540"
  wire width 1 input 6 \clk
  attribute \src "/home/lkcl/nmigen/nmigen/hdl/ir.py:540"
  wire width 1 input 7 \rst
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:178"
  wire width 16 \add1_a
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:179"
  wire width 16 \add1_b
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:180"
  wire width 4 \add1_carry_in
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:182"
  wire width 16 \add1_output
  attribute \src "/home/lkcl/ieee754fpu/src/ieee754/part_mul_add/adder.py:181"
  wire width 4 \add1_carry_out
  cell \add1 \add1
    connect \a \add1_a
    connect \b \add1_b
    connect \carry_in \add1_carry_in
    connect \output \add1_output
    connect \carry_out \add1_carry_out
    connect \pmask \pmask
  end
  process $group_0
    assign \add1_a 16'0000000000000000
    assign \add1_a \sig
    sync init
  end
  process $group_1
    assign \add1_b 16'0000000000000000
    assign \add1_b \sig$1
    sync init
  end
  process $group_2
    assign \add1_carry_in 4'0000
    assign \add1_carry_in \carry_in
    sync init
  end
  process $group_3
    assign \add_output$next \add_output
    assign \add_output$next \add1_output
    attribute \src "/home/lkcl/nmigen/nmigen/hdl/xfrm.py:528"
    switch \rst
      case 1'1
        assign \add_output$next 16'0000000000000000
    end
    sync init
      update \add_output 16'0000000000000000
    sync posedge \clk
      update \add_output \add_output$next
  end
  process $group_4
    assign \add_carry_out$next \add_carry_out
    assign \add_carry_out$next \add1_carry_out
    attribute \src "/home/lkcl/nmigen/nmigen/hdl/xfrm.py:528"
    switch \rst
      case 1'1
        assign \add_carry_out$next 4'0000
    end
    sync init
      update \add_carry_out 4'0000
    sync posedge \clk
      update \add_carry_out \add_carry_out$next
  end
end
