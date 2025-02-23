-- Uriel Crespo Rangel A01412388
-- secuencial utlizando case
library IEEE;
use IEEE.std_logic_1164.all;

entity BCD_CASE_A01412388 is
	port(
	A0, A1, A2, A3 : in std_logic;
	RBI, LT, BI_RBO : in std_logic; 
	a,b,c,d,e,f,g : out std_logic
	);
end BCD_CASE_A01412388;


architecture behav of BCD_CASE_A01412388 is
begin
	process (A0, A1, A2, A3, RBI, LT, BI_RBO)
		variable BCD : std_logic_vector (3 downto 0);
		variable segmentos : std_logic_vector (6 downto 0);
	begin
	if (RBI = '0' or BI_RBO = '0') then
		segmentos := "1111111";
		
	elsif (LT = '0') then
		segmentos := "0000000";
		
	else
		BCD := A0 & A1 & A2 & A3;
	
		case BCD is
			when "0000" =>
				segmentos := "0000001";
			when "0001" =>
				segmentos := "1001111";
			when "0010" =>
				segmentos := "0010010";
			when "0011" =>
				segmentos := "0000110";
			when "0100" =>
				segmentos := "1001100";
			when "0101" =>
				segmentos := "0100100";
			when "0110" =>
				segmentos := "0100000";
			when "0111" =>
				segmentos := "0001111";
			when "1000" =>
				segmentos := "0000000";
			when "1001" =>
				segmentos := "0000100";
			when others =>
				segmentos := "1111111";
		end case;
	end if;

	
	(a, b, c, d, e, f, g) <= segmentos;
		
		
	end process;
	
end behav;
