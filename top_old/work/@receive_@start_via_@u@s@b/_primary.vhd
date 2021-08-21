library verilog;
use verilog.vl_types.all;
entity Receive_Start_via_USB is
    generic(
        start           : integer := 0;
        get_data        : integer := 1;
        stop            : integer := 2;
        Start_template  : vl_logic_vector(0 to 7) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        clk             : in     vl_logic;
        data_in         : in     vl_logic_vector(7 downto 0);
        rxf             : in     vl_logic;
        rd              : out    vl_logic;
        wr              : out    vl_logic;
        \Start\         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of start : constant is 1;
    attribute mti_svvh_generic_type of get_data : constant is 1;
    attribute mti_svvh_generic_type of stop : constant is 1;
    attribute mti_svvh_generic_type of Start_template : constant is 1;
end Receive_Start_via_USB;
