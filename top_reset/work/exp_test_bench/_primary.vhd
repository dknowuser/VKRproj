library verilog;
use verilog.vl_types.all;
entity exp_test_bench is
    generic(
        size            : integer := 1000;
        K               : integer := 6;
        K_float         : integer := 1086324736;
        L               : integer := 24;
        M               : integer := 1112014848
    );
    port(
        clk             : in     vl_logic;
        rxf             : in     vl_logic;
        txe             : in     vl_logic;
        rd              : out    vl_logic;
        wr              : out    vl_logic;
        data_out        : inout  vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of size : constant is 1;
    attribute mti_svvh_generic_type of K : constant is 1;
    attribute mti_svvh_generic_type of K_float : constant is 1;
    attribute mti_svvh_generic_type of L : constant is 1;
    attribute mti_svvh_generic_type of M : constant is 1;
end exp_test_bench;
