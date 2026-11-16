library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;

entity TB_REAL_CLK5_A is
end TB_REAL_CLK5_A;

architecture TB_REAL_CLK5_A_ARC of TB_REAL_CLK5_A is

component REAL_CLK5
port
(
	CLK:				in  std_logic;
	RESET:				in  std_logic;
	TESTMODE:			in std_logic;
	LOAD:	    		in	std_logic;
	ADDRS:	    		in	std_logic_vector(1 downto 0);
	DATA_IN:    		in	std_logic_vector(5 downto 0);
	BASYS_SEGMENTS_OUT:	out std_logic_vector(6 downto 0);
	BASYS_ANODE_OUT:	out	std_logic_vector(3 downto 0);
	SSD_SEGMENTS_OUT:	out std_logic_vector(6 downto 0);
	SSD_CATHODE_OUT:	out	std_logic
 );

end component;

signal tb_CLK: 		std_logic := '1';
signal tb_RESET:  	std_logic := '0';
signal tb_TESTMODE: std_logic := '1';
signal tb_LOAD:	   	std_logic := '0';
signal tb_ADDRS:	std_logic_vector(1 downto 0);
signal tb_DATA_IN: 	std_logic_vector(5 downto 0);
signal tb_BASYS_SEGMENTS_OUT: std_logic_vector(6 downto 0);
signal tb_BASYS_ANODE_OUT: std_logic_vector(3 downto 0);
signal tb_SSD_SEGMENTS_OUT: std_logic_vector(6 downto 0);
signal tb_SSD_CATHODE_OUT: std_logic;


begin

DUT: REAL_CLK5
port map
(
	CLK   => tb_CLK,
	RESET => tb_RESET,
	TESTMODE => tb_TESTMODE,
	LOAD => tb_LOAD,
	ADDRS => tb_ADDRS,
	DATA_IN => tb_DATA_IN,
	BASYS_SEGMENTS_OUT => tb_BASYS_SEGMENTS_OUT,
	BASYS_ANODE_OUT => tb_BASYS_ANODE_OUT,
	SSD_SEGMENTS_OUT => tb_SSD_SEGMENTS_OUT,
	SSD_CATHODE_OUT => tb_SSD_CATHODE_OUT
);


tb_CLK <= not(tb_CLK) after 5 ns;

process
begin
	tb_LOAD <= '1';
	tb_ADDRS <= "00";
	tb_DATA_IN <= "010111";
	wait for 15 ns;
	tb_ADDRS <= "01";
	tb_DATA_IN <= "111010";
	wait for 15 ns;
    tb_ADDRS <= "10";
	tb_DATA_IN <= "000000";
	wait for 10 ns;
	tb_LOAD <= '0';
	wait;
end process;


end TB_REAL_CLK5_A_ARC;
