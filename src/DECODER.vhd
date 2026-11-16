Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity DECODER is
port
(
	ADDRS					:in std_logic_vector(1 downto 0);
	SEL_HOUR, SEL_MIN, SEL_SEC		:out std_logic
);
end DECODER;

architecture ARC_DEC of DECODER is

begin

	process(ADDRS)
	begin
		case ADDRS is
			when "00" => SEL_HOUR <= '1'; SEL_MIN <= '0'; SEL_SEC <= '0';
			when "01" => SEL_MIN <= '1'; SEL_HOUR <= '0'; SEL_SEC <= '0';
			when "10" => SEL_SEC <= '1'; SEL_HOUR <= '0'; SEL_MIN <= '0';
			when others => SEL_HOUR <= '0'; SEL_MIN <= '0'; SEL_SEC <= '0';
		end case;
    end process;
end ARC_DEC;