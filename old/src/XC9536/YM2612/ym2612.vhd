----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:26:30 02/17/2019 
-- Design Name: 
-- Module Name:    ym2612 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ym2612 is
	Port	(	A			: in STD_LOGIC_VECTOR(15 downto 4);
				CLK14M	: in STD_LOGIC;
				PHI2		: in STD_LOGIC;
				RW			: in STD_LOGIC;
				
				
				RD			: out STD_LOGIC;
				WR			: out STD_LOGIC;
				CS			: out STD_LOGIC;
				CLK3M6	: out STD_LOGIC	-- 14.7456 Mhz / 4 = 3,6864 Mhz
			);

end ym2612;

architecture Behavioral of ym2612 is
	signal BFBx			: STD_LOGIC;
	signal clk			: STD_LOGIC_VECTOR(1 downto 0);
begin

	BFBx	<=	'1' when A = "101111111011" else
				'0';

	CS		<= '0' when BFBx = '1' and PHI2 = '1' else
				'1';
				
	RD		<= not RW;
	WR		<=	RW;

	process (CLK14M)
	begin
		if falling_edge(CLK14M) then
			clk <= clk + 1;
			CLK3M6 <= clk(0);
		end if;
	end process;
	
end Behavioral;

