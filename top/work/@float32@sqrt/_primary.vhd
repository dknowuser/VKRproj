library verilog;
use verilog.vl_types.all;
entity Float32Sqrt is
    port(
        CLK             : in     vl_logic;
        nRST            : in     vl_logic;
        arg             : in     vl_logic_vector(31 downto 0);
        loadArgs        : in     vl_logic;
        status          : out    vl_logic_vector(2 downto 0);
        busy            : out    vl_logic;
        sqrt            : out    vl_logic_vector(31 downto 0)
    );
end Float32Sqrt;
