module mac_comb(
    input [7:0] a,       
    input [7:0] b,       
    input [15:0] acc,    
    output [15:0] result 
);

    wire [15:0] produit;

    assign produit = a * b;

    assign result = produit + acc;

endmodule

