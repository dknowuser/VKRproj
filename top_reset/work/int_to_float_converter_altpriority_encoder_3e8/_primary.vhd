library verilog;
use verilog.vl_types.all;
entity int_to_float_converter_altpriority_encoder_3e8 is
    port(
        data            : in     vl_logic_vector(1 downto 0);
        q               : out    vl_logic_vector(0 downto 0);
        zero            : out    vl_logic
    );
end int_to_float_converter_altpriority_encoder_3e8;
