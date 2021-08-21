library verilog;
use verilog.vl_types.all;
entity int_to_float_converter_altpriority_encoder_bv7 is
    port(
        data            : in     vl_logic_vector(7 downto 0);
        q               : out    vl_logic_vector(2 downto 0)
    );
end int_to_float_converter_altpriority_encoder_bv7;
