library verilog;
use verilog.vl_types.all;
entity measure_pulse_height is
    generic(
        K               : integer := 6;
        L               : integer := 24
    );
    port(
        clk             : in     vl_logic;
        y               : in     vl_logic_vector(31 downto 0);
        threshold       : in     vl_logic_vector(31 downto 0);
        start           : in     vl_logic;
        pulse_height    : out    vl_logic_vector(31 downto 0);
        ready           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of K : constant is 1;
    attribute mti_svvh_generic_type of L : constant is 1;
end measure_pulse_height;
