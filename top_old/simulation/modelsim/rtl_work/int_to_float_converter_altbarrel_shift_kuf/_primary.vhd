library verilog;
use verilog.vl_types.all;
entity int_to_float_converter_altbarrel_shift_kuf is
    port(
        aclr            : in     vl_logic;
        clk_en          : in     vl_logic;
        clock           : in     vl_logic;
        data            : in     vl_logic_vector(31 downto 0);
        distance        : in     vl_logic_vector(4 downto 0);
        result          : out    vl_logic_vector(31 downto 0)
    );
end int_to_float_converter_altbarrel_shift_kuf;
