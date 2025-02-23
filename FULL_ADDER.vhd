library ieee;
use ieee.std_logic_1164.all;

entity FULL_ADDER is
	port(A, B, Ci : in std_logic;
	Co, S : out std_logic
	);
end FULL_ADDER;

architecture STRUCTURAL of FULL_ADDER is
COMPONENT HALF_ADDER
	port
	(A,B : in std_logic;
	S,C : out std_logic
	);
END COMPONENT;

signal B0, B1, B2 : std_logic;

begin

U0 : HALF_ADDER port map(A,B,B1,B0);
U1 : HALF_ADDER port map(B1, Ci, S, B2);
Co <= B2 OR B0;

end STRUCTURAL;