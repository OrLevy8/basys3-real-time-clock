library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
 
entity BCD_TO_7SEGMENT is
Port (
	BCD_IN 			: in  STD_LOGIC_VECTOR (3 downto 0);
	Seven_Segment 	: out STD_LOGIC_VECTOR (6 downto 0)
);
end BCD_TO_7SEGMENT;
 
architecture BCD_TO_7SEGMENT_ARC of BCD_TO_7SEGMENT is
 
begin
 
process(BCD_IN)
begin
	case BCD_IN is
		when x"0" =>	Seven_Segment <= "0000001"; ---0
		when x"1" =>	Seven_Segment <= "1001111"; ---1
		when x"2" =>	Seven_Segment <= "0010010"; ---2
		when x"3" =>	Seven_Segment <= "0000110"; ---3
		when x"4" =>	Seven_Segment <= "1001100"; ---4
		when x"5" =>	Seven_Segment <= "0100100"; ---5
		when x"6" =>	Seven_Segment <= "0100000"; ---6
		when x"7" =>	Seven_Segment <= "0001111"; ---7
		when x"8" =>	Seven_Segment <= "0000000"; ---8
		when x"9" =>	Seven_Segment <= "0000100"; ---9
		when others =>	Seven_Segment <= "XXXXXXX"; ---error
	end case;
 
end process;
 
end BCD_TO_7SEGMENT_ARC;
