library verilog;
use verilog.vl_types.all;
entity int_to_float_converter is
    port(
        clock           : in     vl_logic;
        dataa           : in     vl_logic_vector(31 downto 0);
        result          : out    vl_logic_vector(31 downto 0)
    );
end int_to_float_converter;
