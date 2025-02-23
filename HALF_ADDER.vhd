library ieee;
use ieee.std_logic_1164.all;

entity HALF_ADDER is
	port(
	A,B : in std_logic;
	S,C : out std_logic
	);
end HALF_ADDER;


architecture BEHAV of HALF_ADDER is
begin
	S <= A XOR B;
	C <= A AND B;
end BEHAV;