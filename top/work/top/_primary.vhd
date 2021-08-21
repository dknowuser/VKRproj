library verilog;
use verilog.vl_types.all;
entity top is
    generic(
        K               : integer := 20;
        K_float         : integer := 1101004800;
        L               : integer := 24;
        M               : integer := 1169915904;
        threshold       : integer := 1280
    );
    port(
        clk             : in     vl_logic;
        txe             : in     vl_logic;
        rxf             : in     vl_logic;
        rd              : out    vl_logic;
        wr              : out    vl_logic;
        x_in            : in     vl_logic_vector(15 downto 0);
        data_out        : inout  vl_logic_vector(7 downto 0);
        test            : out    vl_logic_vector(2 downto 0);
        adc_clk         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of K : constant is 1;
    attribute mti_svvh_generic_type of K_float : constant is 1;
    attribute mti_svvh_generic_type of L : constant is 1;
    attribute mti_svvh_generic_type of M : constant is 1;
    attribute mti_svvh_generic_type of threshold : constant is 1;
end top;
