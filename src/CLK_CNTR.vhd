library IEEE;
	use IEEE.std_logic_1164.all;
	use IEEE.std_logic_unsigned.all;

entity CLK_CNTR is
port
(
  CLK:    in  std_logic;
  RESET:  in  std_logic;
  TESTMODE: in std_logic;
  LOAD:		in	std_logic;
  DATA_IN:   in	std_logic_vector(5 downto 0);
  SEL_HOUR:		in	std_logic;
  SEL_MIN:		in	std_logic;
  SEL_SEC:		in	std_logic;
  SECONDS_OUT: out std_logic_vector(5 downto 0);
  MINUTES_OUT: out std_logic_vector(5 downto 0);
  HOURS_OUT: out std_logic_vector(4 downto 0)
);
end CLK_CNTR;


architecture CLK_CNTR_ARC of CLK_CNTR is
	signal Q: std_logic_vector(26 downto 0);
	signal TC_TIMEBASE: std_logic;
	signal Q_SECONDS: std_logic_vector(5 downto 0);
	signal Q_MINUTES: std_logic_vector(5 downto 0);
	signal Q_HOURS: std_logic_vector(4 downto 0);
begin

process --Q
begin
	wait until rising_edge(CLK);
	if (RESET = '1') then
	Q <= (others => '0');
	TC_TIMEBASE <= '0';
	else
		if (TESTMODE = '1') then
			if (Q < 9) then
				Q <= Q + 1;
				TC_TIMEBASE <= '0';
			else
				Q <= (others => '0');
				TC_TIMEBASE <= '1';
			end if;

		else
			if (Q < 99999999) then
				Q <= Q + 1;
				TC_TIMEBASE <= '0';
			else
				Q <= (others => '0');
				TC_TIMEBASE <= '1';
			end if;
		end if;
	end if;
end process;


process --Q_SECONDS
begin
	wait until rising_edge(CLK);
	if (RESET = '1') then
		Q_SECONDS <= (others => '0');
	else
		if (LOAD = '1') and (SEL_SEC = '1') then
			Q_SECONDS <= DATA_IN;
		elsif (TC_TIMEBASE = '1') then
			if (Q_SECONDS < 59) then
				Q_SECONDS <= Q_SECONDS + 1;
			else
				Q_SECONDS <= (others => '0');
			end if;
		end if;
	end if;
end process;

process --Q_MINUTES
begin
	wait until rising_edge(CLK);
	if (RESET = '1') then
		Q_MINUTES <= (others => '0');
	else
		if (LOAD = '1') and (SEL_MIN = '1') then
			Q_MINUTES <= DATA_IN;
		elsif (TC_TIMEBASE = '1') and (Q_SECONDS = 59) then
			if (Q_MINUTES < 59) then
				Q_MINUTES <= Q_MINUTES + 1;
			else
				Q_MINUTES <= (others => '0');
			end if;
		end if;
	end if;
end process;


process --Q_HOURS
begin
	wait until rising_edge(CLK);
	if (RESET = '1') then
		Q_HOURS <= (others => '0');
	else
		if (LOAD = '1') and (SEL_HOUR = '1') then
			Q_HOURS <= DATA_IN(4 downto 0);
		elsif (TC_TIMEBASE = '1') and (Q_SECONDS = 59) and (Q_MINUTES = 59) then
			if (Q_HOURS < 23) then
				Q_HOURS <= Q_HOURS + 1;
			else
				Q_HOURS <= (others => '0');
			end if;
		end if;
	end if;
end process;

SECONDS_OUT <= Q_SECONDS;
MINUTES_OUT <= Q_MINUTES;
HOURS_OUT <= Q_HOURS;

end CLK_CNTR_ARC;