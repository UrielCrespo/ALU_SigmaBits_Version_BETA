library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity bin2bcd is
	port(
		inputs : in std_logic_vector(13 downto 0);
		bcd3, bcd2, bcd1, bcd0 : out std_logic_vector(3 downto 0)
	);

end bin2bcd;


architecture behav of bin2bcd is
begin
	process(inputs)
		variable num : integer;
	begin
		num := to_integer(unsigned(inputs));
		
		if (num < 1000) then
			bcd3 <= "0000"; -- es 0
		elsif (num < 2000) then
			bcd3 <= "0001"; -- es 1
			num := num - 1000;
		elsif (num < 3000) then
			bcd3 <= "0010"; -- es 2
			num := num - 2000;
		elsif (num < 4000) then
			bcd3 <= "0011"; -- es 3
			num := num - 3000;
		elsif (num < 5000) then
			bcd3 <= "0100"; -- es 4
			num := num - 4000;
		elsif (num < 6000) then
			bcd3 <= "0101"; -- es 5
			num := num - 5000;
		elsif (num < 7000) then
			bcd3 <= "0110"; -- es 6
			num := num - 6000;
		elsif (num < 8000) then
			bcd3 <= "0111"; -- es 7
			num := num - 7000;
		elsif (num < 9000) then
			bcd3 <= "1000"; -- es 8
			num := num - 8000;
		else
			bcd3 <= "1001"; -- es 9
			num := num - 9000;
		end if;
		
			-- Centenas
		 if (num < 100) then
			  bcd2 <= "0000"; -- 0
		 elsif (num < 200) then
			  bcd2 <= "0001"; -- 1
			  num := num - 100;
		 elsif (num < 300) then
			  bcd2 <= "0010"; -- 2
			  num := num - 200;
		 elsif (num < 400) then
			  bcd2 <= "0011"; -- 3
			  num := num - 300;
		 elsif (num < 500) then
			  bcd2 <= "0100"; -- 4
			  num := num - 400;
		 elsif (num < 600) then
			  bcd2 <= "0101"; -- 5
			  num := num - 500;
		 elsif (num < 700) then
			  bcd2 <= "0110"; -- 6
			  num := num - 600;
		 elsif (num < 800) then
			  bcd2 <= "0111"; -- 7
			  num := num - 700;
		 elsif (num < 900) then
			  bcd2 <= "1000"; -- 8
			  num := num - 800;
		 else
			  bcd2 <= "1001"; -- 9
			  num := num - 900;
		 end if;
		
		-- Decenas
		 if (num < 10) then
			  bcd1 <= "0000"; -- 0
		 elsif (num < 20) then
			  bcd1 <= "0001"; -- 1
			  num := num - 10;
		 elsif (num < 30) then
			  bcd1 <= "0010"; -- 2
			  num := num - 20;
		 elsif (num < 40) then
			  bcd1 <= "0011"; -- 3
			  num := num - 30;
		 elsif (num < 50) then
			  bcd1 <= "0100"; -- 4
			  num := num - 40;
		 elsif (num < 60) then
			  bcd1 <= "0101"; -- 5
			  num := num - 50;
		 elsif (num < 70) then
			  bcd1 <= "0110"; -- 6
			  num := num - 60;
		 elsif (num < 80) then
			  bcd1 <= "0111"; -- 7
			  num := num - 70;
		 elsif (num < 90) then
			  bcd1 <= "1000"; -- 8
			  num := num - 80;
		 else
			  bcd1 <= "1001"; -- 9
			  num := num - 90;
		 end if;
		
		
		--sigo con unidades
		
		bcd0 <= 	std_logic_vector(to_unsigned(num, 4));	
	end process;
end behav;