----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:16:32 12/15/2016 
-- Design Name: 
-- Module Name:    color - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MultiIO is
	Port	(	MISO		: in STD_LOGIC;
				A			: in STD_LOGIC_VECTOR(15 downto 4);
				AL			: in STD_LOGIC_VECTOR(1 downto 0);
--				Clk14M	: in STD_LOGIC;
				PHI2		: in STD_LOGIC;
				RW			: in STD_LOGIC;
				PS2DAT	: in STD_LOGIC;		-- (white)
				PS2CLK	: in STD_LOGIC;		-- (yellow)
				CSSER		: out STD_LOGIC;
				LATCH		: out	STD_LOGIC;
				D			: inout STD_LOGIC_VECTOR(7 downto 0);
				RES	   : in STD_LOGIC;
				MOSI		: out STD_LOGIC;
				SCLK		: out	STD_LOGIC;
				SPICS		: out STD_LOGIC;
				IRQ		: out STD_LOGIC
			);
			
end MultiIO;

architecture Behavioral of MultiIO is
	signal BFxx			: STD_LOGIC;
	signal IO			: STD_LOGIC;
	signal PS2Data		: STD_LOGIC_VECTOR (8 downto 0);
	signal PS2Read		: STD_LOGIC;
	signal PS2CLKIN	: STD_LOGIC_VECTOR(1 downto 0);
	signal PS2Edge		: STD_LOGIC;
	signal PS2EdgeL	: STD_LOGIC;
	signal SPIAccess	: STD_LOGIC;
	signal SPIData		: STD_LOGIC;
	signal SPIData1	: STD_LOGIC;
	signal PHI2L		: STD_LOGIC_VECTOR(1 downto 0);
	 
begin
	
	IRQ	<= '0' when PS2Data(8) = '0' else
				'Z';

	BFxx	<=	'1' when A(15 downto 8) = "10111111" else
				'0';

	-- BFFx = serial device 68681
	CSSER <= '0' when BFxx = '1' and A(7 downto 4) = "1111" and PHI2 = '1' else
				'1';
	
	-- Write latch Centronics at BFEx
	LATCH <= '1' when BFxx = '1' and A(7 downto 4) = "1110" and PHI2 = '1' and RW = '0' else
				'0';
	
	-- PS2 and SPI at BFDx
	IO 	<= '1' when BFxx = '1' and A(7 downto 4) = "1101" and PHI2 = '1' else
				'0';
	
-- A1 A0
--  0  0 PS2Data		(R)
--  0  1 PS2Status	(R)
--  0  1 SPICS       (W)
--  1  0 SPIDATA     (R/W)

	D <= 	PS2Data(0) & PS2Data(1) & PS2Data(2) & PS2Data(3) & PS2Data(4) & PS2Data(5) & PS2Data(6) & PS2Data(7)
			when IO = '1' and RW = '1' and AL = "00" else
			
			"0000000" & PS2Data(8)	
			when IO = '1' and RW = '1' and AL = "01" else

			"0000000" & MISO	
			when IO = '1' and RW = '1' and AL = "10" else
			
			"0000000" & SPIData1
			when IO = '1' and RW = '1' and AL = "11" else
			
			"ZZZZZZZZ";

	process (IO, PS2Data, RW, PHI2, RES, SPIAccess, SPIData, SPIData1, AL)
	begin
--		if RES = '0' then
--			SPICS <= '1';			
--			SPIData <= '1';
--			SPIData1 <= '1';
--		els
		if falling_edge(PHI2) then
		   if IO = '1' then
				if AL = "00" and RW = '0' then		-- PS2DATA, Rest shift-register
					PS2Read <= '1';
				elsif AL = "10" then						-- SPIDATA
					if RW = '0' then
						SPIData <= D(7);
					end if;
					SPIAccess <= '1';
				elsif AL = "11" and RW = '0' then	-- SPIMOSI & SPICS
					SPIData1 <= D(0);
					SPICS 	<= D(1);
				end if;
			else
				SPIAccess <= '0';
				PS2Read <= '0';
			end if;
		end if;

		if SPIAccess = '1' then
			PHI2L <= "00";
		elsif RES =	'0' then
			PHI2L <= "11";
		elsif falling_edge(PHI2) then
			if PHI2L < 3 then
				PHI2L <= PHI2L + 1;
				SCLK <= '1';
			else
				SCLK <= '0';
			end if;
		end if;
				
		MOSI <= SPIData or SPIData1;
		
	end process;
	
	process(PS2CLK, PS2DAT, PS2Data, PS2Read, PHI2, RES, PS2CLKIN, PS2EdgeL)
	begin		
		if PS2Read = '1' or RES = '0' then
			PS2CLKIN <= (others => '1');
		elsif falling_edge(PHI2) then
			PS2CLKIN <= PS2CLKIN(0) & PS2CLK;
		end if;
		
		PS2Edge <= not (PS2CLKIN(1) or PS2CLKIN(0));
		
		if PS2EdgeL = '1' and PS2CLKIN = "11" then
			PS2EdgeL <= '0';			
		elsif rising_edge(PS2Edge) then 
			PS2EdgeL <= '1';
		end if;
		
	end process;

	process (PS2DAT, PS2EdgeL, PS2Read, RES)
	begin
		if PS2Read = '1' or RES = '0' then
			PS2Data <= (others => '1');
		elsif rising_edge(PS2EdgeL) and PS2Data(8) = '1' then
			PS2Data <= PS2Data(7 downto 0) & PS2DAT;
		end if;
	end process;
	
end Behavioral;
