Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity REAL_CLK5 is
port
(
	CLK:    			in  std_logic;
	RESET:  			in  std_logic;
	TESTMODE:    		in	std_logic;
	LOAD:	    		in	std_logic;
	ADDRS:	    		in	std_logic_vector(1 downto 0);
	DATA_IN:    		in	std_logic_vector(5 downto 0);
	BASYS_SEGMENTS_OUT:	out std_logic_vector(6 downto 0);
	BASYS_ANODE_OUT:	out	std_logic_vector(3 downto 0);
	SSD_SEGMENTS_OUT:	out std_logic_vector(6 downto 0);
	SSD_CATHODE_OUT:	out	std_logic
);
end REAL_CLK5;

architecture REAL_CLK5_ARC of REAL_CLK5 is

--components--

component CLK_CNTR
port
(
	CLK:    		in  std_logic;
	RESET:  		in  std_logic;
	TESTMODE:    	in std_logic;
	LOAD:			in	std_logic;
	DATA_IN:   		in	std_logic_vector(5 downto 0);
	SEL_HOUR:		in	std_logic;
	SEL_MIN:		in	std_logic;
	SEL_SEC:		in	std_logic;
	SECONDS_OUT:	out	std_logic_vector(5 downto 0);
	MINUTES_OUT:	out	std_logic_vector(5 downto 0);
	HOURS_OUT:		out	std_logic_vector(4 downto 0)
);	
end component;


component DECODER
port
(
	ADDRS:    		in  std_logic_vector(1 downto 0);
	SEL_HOUR:		out	std_logic;
	SEL_MIN:		out	std_logic;
	SEL_SEC:		out	std_logic
);	
end component;


component BIN_TO_BCD
port
(
	BIN : in  std_logic_vector (5 downto 0);
	MS_DIGIT : out std_logic_vector (3 downto 0);
	LS_DIGIT : out std_logic_vector (3 downto 0)
);	
end component;

component BCD_TO_7SEGMENT
port
(
	BCD_IN:			 in  std_logic_vector(3 downto 0);
	Seven_Segment:	 out std_logic_vector(6 downto 0)
);
end component;

component BCD_TO_7SEGMENT_PMOD_SSD
port
(
	BCD_IN_PMOD_SSD 			: in  std_logic_vector(3 downto 0);
	Seven_Segment_PMOD_SSD 	: out std_logic_vector(6 downto 0)
);
end component;

--signals from other vhdl--
--CLK_CNTR:
signal SECONDS_OUT:			std_logic_vector(5 downto 0);
signal MINUTES_OUT:			std_logic_vector(5 downto 0);
signal HOURS_OUT:			std_logic_vector(4 downto 0);
signal HOURS_OUT_6_bit:	std_logic_vector(5 downto 0);
--DECODER and CLK_CNTR
signal SEL_HOUR:			std_logic;
signal SEL_MIN:				std_logic;
signal SEL_SEC:				std_logic;

--BIN_TO_BCD:
signal MS_DIGIT_SECONDS:	std_logic_vector (3 downto 0);
signal LS_DIGIT_SECONDS:	std_logic_vector (3 downto 0);
signal MS_DIGIT_MINUTES:	std_logic_vector (3 downto 0);
signal LS_DIGIT_MINUTES:	std_logic_vector (3 downto 0);
signal MS_DIGIT_HOURS:	 	std_logic_vector (3 downto 0);
signal LS_DIGIT_HOURS: 		std_logic_vector (3 downto 0);
--BCD_TO_7SEGMENT:
signal SEGMENT_MS_HOURS:	std_logic_vector(6 downto 0);
signal SEGMENT_LS_HOURS:	std_logic_vector(6 downto 0);
signal SEGMENT_MS_MINUTES:	std_logic_vector(6 downto 0);
signal SEGMENT_LS_MINUTES:	std_logic_vector(6 downto 0);
--BCD_TO_7SEGMENT_PMOD_SSD:
signal SEGMENT_MS_SECONDS:	std_logic_vector(6 downto 0);
signal SEGMENT_LS_SECONDS:	std_logic_vector(6 downto 0);
--MUX_COUNTER:
signal MUX_COUNTER:		std_logic_vector(19 downto 0);

begin
--port-maps:
--zero extend for hours
HOURS_OUT_6_bit <= '0' & HOURS_OUT;
--CLK_CNTR:
U1:	CLK_CNTR 				
port map
(
CLK => CLK,
RESET => RESET,
TESTMODE => TESTMODE,
LOAD => LOAD,
DATA_IN => DATA_IN,
SEL_HOUR => SEL_HOUR,
SEL_MIN => SEL_MIN,
SEL_SEC => SEL_SEC,
SECONDS_OUT => SECONDS_OUT,
MINUTES_OUT => MINUTES_OUT,
HOURS_OUT => HOURS_OUT
);
--DECODER
U2: DECODER
port map
(
ADDRS => ADDRS,
SEL_HOUR => SEL_HOUR,
SEL_MIN => SEL_MIN,
SEL_SEC => SEL_SEC
);

--BIN_TO_BCD:
U3:	BIN_TO_BCD	 		
port map 
(
BIN => SECONDS_OUT,
MS_DIGIT => MS_DIGIT_SECONDS,
LS_DIGIT => LS_DIGIT_SECONDS
);

U4:	BIN_TO_BCD
port map
(
BIN => MINUTES_OUT,
MS_DIGIT => MS_DIGIT_MINUTES,
LS_DIGIT => LS_DIGIT_MINUTES
);

U5:	BIN_TO_BCD
port map 
(
BIN => HOURS_OUT_6_bit,
MS_DIGIT => MS_DIGIT_HOURS,
LS_DIGIT => LS_DIGIT_HOURS
);
--BCD_TO_7SEGMENT:
U6:	BCD_TO_7SEGMENT
port map 
(
BCD_IN => MS_DIGIT_HOURS,
Seven_Segment => SEGMENT_MS_HOURS
);
U7:	BCD_TO_7SEGMENT
port map 
(
BCD_IN => LS_DIGIT_HOURS,
Seven_Segment => SEGMENT_LS_HOURS
);
U8:	BCD_TO_7SEGMENT
port map 
(
BCD_IN => MS_DIGIT_MINUTES,
Seven_Segment => SEGMENT_MS_MINUTES
);
U9:	BCD_TO_7SEGMENT 	
port map 
(
BCD_IN => LS_DIGIT_MINUTES,
Seven_Segment => SEGMENT_LS_MINUTES
);
--BCD_TO_7SEGMENT_PMOD_SSD:
U10:	BCD_TO_7SEGMENT_PMOD_SSD 
port map 
(
BCD_IN_PMOD_SSD => MS_DIGIT_SECONDS,
Seven_Segment_PMOD_SSD => SEGMENT_MS_SECONDS
);
U11: BCD_TO_7SEGMENT_PMOD_SSD 
port map 
(
BCD_IN_PMOD_SSD => LS_DIGIT_SECONDS,
Seven_Segment_PMOD_SSD => SEGMENT_LS_SECONDS
);


--MUX_COUNTER:
process
begin
	wait until rising_edge(CLK);
	if (RESET = '1') then
		MUX_COUNTER <= (others => '0');
	else
		MUX_COUNTER <= MUX_COUNTER + 1;		
	end if;
end process;

--Basys Mux
process (TESTMODE,MUX_COUNTER,SEGMENT_MS_HOURS,SEGMENT_LS_HOURS,SEGMENT_MS_MINUTES,SEGMENT_LS_MINUTES)
begin
if (TESTMODE = '0') then
case MUX_COUNTER(19 downto 18) is
    when "00" =>
        BASYS_ANODE_OUT <= "0111"; 
        BASYS_SEGMENTS_OUT <= SEGMENT_MS_HOURS;
    when "01" =>
        BASYS_ANODE_OUT <= "1011"; 
        BASYS_SEGMENTS_OUT <= SEGMENT_LS_HOURS;
    when "10" =>
        BASYS_ANODE_OUT <= "1101"; 
        BASYS_SEGMENTS_OUT <= SEGMENT_MS_MINUTES;
    when "11" =>
        BASYS_ANODE_OUT <= "1110"; 
        BASYS_SEGMENTS_OUT <= SEGMENT_LS_MINUTES; 
	when others =>
		BASYS_ANODE_OUT <= "XXXX"; 
        BASYS_SEGMENTS_OUT <= "XXXXXXX";
    end case;
else
case MUX_COUNTER(1 downto 0) is
    when "00" =>
        BASYS_ANODE_OUT <= "0111"; 
        BASYS_SEGMENTS_OUT <= SEGMENT_MS_HOURS;
    when "01" =>
        BASYS_ANODE_OUT <= "1011"; 
        BASYS_SEGMENTS_OUT <= SEGMENT_LS_HOURS;
    when "10" =>
        BASYS_ANODE_OUT <= "1101"; 
        BASYS_SEGMENTS_OUT <= SEGMENT_MS_MINUTES;
    when "11" =>
        BASYS_ANODE_OUT <= "1110"; 
        BASYS_SEGMENTS_OUT <= SEGMENT_LS_MINUTES; 
	when others =>
		BASYS_ANODE_OUT <= "XXXX"; 
        BASYS_SEGMENTS_OUT <= "XXXXXXX";
    end case;
end if;
end process;

--SSD Mux
process (TESTMODE,MUX_COUNTER,SEGMENT_MS_SECONDS,SEGMENT_LS_SECONDS)
begin
if (TESTMODE = '0') then
case MUX_COUNTER(18) is
    when '0' =>
        SSD_CATHODE_OUT <= '1'; 
        SSD_SEGMENTS_OUT <= SEGMENT_MS_SECONDS;
    when '1' =>
        SSD_CATHODE_OUT <= '0'; 
        SSD_SEGMENTS_OUT <= SEGMENT_LS_SECONDS;
	when others =>
		SSD_CATHODE_OUT <= 'X'; 
        SSD_SEGMENTS_OUT <= "XXXXXXX";
    end case;
else
case MUX_COUNTER(0) is
    when '0' =>
        SSD_CATHODE_OUT <= '1'; 
        SSD_SEGMENTS_OUT <= SEGMENT_MS_SECONDS;
    when '1' =>
        SSD_CATHODE_OUT <= '0'; 
        SSD_SEGMENTS_OUT <= SEGMENT_LS_SECONDS;
	when others =>
		SSD_CATHODE_OUT <= 'X'; 
        SSD_SEGMENTS_OUT <= "XXXXXXX";
    end case;
end if;
end process;

end REAL_CLK5_ARC;