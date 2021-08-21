library verilog;
use verilog.vl_types.all;
entity test_bench is
    generic(
        n               : integer := 16;
        size            : integer := 256;
        slope_rising_step: integer := 1
    );
    port(
        clk             : in     vl_logic;
        pulse_height    : out    vl_logic_vector;
        ready           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of n : constant is 1;
    attribute mti_svvh_generic_type of size : constant is 1;
    attribute mti_svvh_generic_type of slope_rising_step : constant is 1;
end test_bench;
