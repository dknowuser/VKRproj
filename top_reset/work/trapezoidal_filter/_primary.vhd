library verilog;
use verilog.vl_types.all;
entity trapezoidal_filter is
    generic(
        K               : integer := 6;
        K_float         : integer := 1086324736;
        L               : integer := 24;
        M               : integer := 1112014848
    );
    port(
        clk             : in     vl_logic;
        x_in            : in     vl_logic_vector(31 downto 0);
        y               : out    vl_logic_vector(31 downto 0);
        ready           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of K : constant is 1;
    attribute mti_svvh_generic_type of K_float : constant is 1;
    attribute mti_svvh_generic_type of L : constant is 1;
    attribute mti_svvh_generic_type of M : constant is 1;
end trapezoidal_filter;
