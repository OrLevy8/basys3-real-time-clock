library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.std_logic_unsigned.all;

 
entity BCD_TO_7SEGMENT_PMOD_SSD is
Port (
	BCD_IN_PMOD_SSD 		: in  STD_LOGIC_VECTOR (3 downto 0);
	Seven_Segment_PMOD_SSD 	: out STD_LOGIC_VECTOR (6 downto 0)
);
end BCD_TO_7SEGMENT_PMOD_SSD;
 
architecture BCD_TO_7SEGMENT_PMOD_SSD_ARC of BCD_TO_7SEGMENT_PMOD_SSD is
 
begin
 
process(BCD_IN_PMOD_SSD)
begin
 
	case BCD_IN_PMOD_SSD is
		when x"0" =>	Seven_Segment_PMOD_SSD <= "1111110"; ---0
		when x"1" =>	Seven_Segment_PMOD_SSD <= "0110000"; ---1
		when x"2" =>	Seven_Segment_PMOD_SSD <= "1101101"; ---2
		when x"3" =>	Seven_Segment_PMOD_SSD <= "1111001"; ---3
		when x"4" =>	Seven_Segment_PMOD_SSD <= "0110011"; ---4
		when x"5" =>	Seven_Segment_PMOD_SSD <= "1011011"; ---5
		when x"6" =>	Seven_Segment_PMOD_SSD <= "1011111"; ---6
		when x"7" =>	Seven_Segment_PMOD_SSD <= "1110000"; ---7
		when x"8" =>	Seven_Segment_PMOD_SSD <= "1111111"; ---8
		when x"9" =>	Seven_Segment_PMOD_SSD <= "1111011"; ---9
		when others =>	Seven_Segment_PMOD_SSD <= "XXXXXXX"; ---error
	end case;
 
end process;
 
end BCD_TO_7SEGMENT_PMOD_SSD_ARC;
