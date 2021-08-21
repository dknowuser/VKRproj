library verilog;
use verilog.vl_types.all;
entity Send_Data_via_USB is
    generic(
        counter_freq    : integer := 1
    );
    port(
        clk             : in     vl_logic;
        txe             : in     vl_logic;
        data_in         : in     vl_logic_vector(31 downto 0);
        send            : in     vl_logic;
        rd              : out    vl_logic;
        wr              : out    vl_logic;
        data_out        : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of counter_freq : constant is 1;
end Send_Data_via_USB;
