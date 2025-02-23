LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY Evidencia_Reto1_SigmaBits IS
	PORT(
	NUM_1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0); --Primer número a comparar
	NUM_2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0); --Segundo número a comparar
	SWITCH_MODE : IN STD_LOGIC_VECTOR (1 DOWNTO 0);	--00 -> SUMA
																	--01 -> RESTA
																	--10 -> AND
																	--11 -> OR
	D_RESULTADO_SR1 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0); --Display 1 del resultado suma/resta unidades
	D_RESULTADO_SR2 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0); --Display 2 del resultado suma/resta decenas
	LED_RESULTADO : OUT STD_LOGIC_VECTOR (3 DOWNTO 0); --Encendido de LEDs para AND/OR
	LED_COUT_SIGN : OUT STD_LOGIC; --LED de overflow/signo en suma/resta
	
	D_UNIDADES_NUM2 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0); --Display numero2 unidades
	D_DECENAS_NUM2 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0); --Display numero2 decenas
	
	D_UNIDADES_NUM1 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0); --Display numero1 unidades
	D_DECENAS_NUM1 : OUT STD_LOGIC_VECTOR (6 DOWNTO 0); --Display numero1 decenas
	
	LEDS_FLOTANTES : OUT STD_LOGIC_VECTOR (4 DOWNTO 0)
	);
	
END Evidencia_Reto1_SigmaBits;


ARCHITECTURE BEHAVIOR OF Evidencia_Reto1_SigmaBits IS

	-- Componente SUMADOR_RESTADOR
	COMPONENT SUMADOR_RESTADOR 
		PORT(
			NUM1, NUM2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			MODO : IN STD_LOGIC;
			NUMR : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			COUT : OUT STD_LOGIC
		);
	END COMPONENT;
	
	-- Componente AND_OR_UNIT
	COMPONENT AND_OR_UNIT
		PORT(
			NUM_1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			NUM_2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			MODO : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
			OUTPUTS : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
		);
	END COMPONENT;
	
	-- Componente bin2bcd
	COMPONENT bin2bcd
		port(
			inputs : in std_logic_vector(13 downto 0);
			bcd3, bcd2, bcd1, bcd0 : out std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	-- Componente BCD_CASE_A01412388
	COMPONENT BCD_CASE_A01412388
	port(
	A0, A1, A2, A3 : in std_logic;
	RBI, LT, BI_RBO : in std_logic; 
	a,b,c,d,e,f,g : out std_logic
	);
	END COMPONENT;
	
	-- Señales (cables)
	SIGNAL SR_A_BIN2BCD : STD_LOGIC_VECTOR (3 DOWNTO 0); -- cable entre sumador restador y bin2bcd
	
	SIGNAL BIN2BCD_A_74LS47U : STD_LOGIC_VECTOR (3 DOWNTO 0); -- cable entre bin2bcd y 74ls47 unidades
	SIGNAL BIN2BCD_A_74LS47D : STD_LOGIC_VECTOR (3 DOWNTO 0); -- cable entre bin2bcd y 74ls47 decenas
	
	SIGNAL NUM2BIN2BCD_A_74LS47U :STD_LOGIC_VECTOR (3 DOWNTO 0); --cable para NUM2 entre bin2bcd y 74ls47 unidades
	SIGNAL NUM2BIN2BCD_A_74LS47D :STD_LOGIC_VECTOR (3 DOWNTO 0); --cable para NUM2 entre bin2bcd y 74ls47 decenas
	
	SIGNAL NUM1BIN2BCD_A_74LS47U :STD_LOGIC_VECTOR (3 DOWNTO 0); --cable para NUM1 entre bin2bcd y 74ls47 unidades
	SIGNAL NUM1BIN2BCD_A_74LS47D :STD_LOGIC_VECTOR (3 DOWNTO 0); --cable para NUM1 entre bin2bcd y 74ls47 decenas


	
	
BEGIN
	-- sumador restador
	U0 : SUMADOR_RESTADOR port map (NUM_1, NUM_2, SWITCH_MODE(0), SR_A_BIN2BCD, LED_COUT_SIGN);
	
	-- AND_OR_UNIT
	U1 : AND_OR_UNIT port map (NUM_1, NUM_2, SWITCH_MODE, LED_RESULTADO);
	
	-- BIN2BCD
	U2 : bin2bcd port map ("0000000000" & SR_A_BIN2BCD, OPEN, OPEN, BIN2BCD_A_74LS47D, BIN2BCD_A_74LS47U);
	-- OPEN es igual a usar "0000", intente usar "0000" pero no pudes asignar constantes a outputs
	
	-- 74LS47U unidades
	U3 : BCD_CASE_A01412388 port map(BIN2BCD_A_74LS47U(3), BIN2BCD_A_74LS47U(2), BIN2BCD_A_74LS47U(1), BIN2BCD_A_74LS47U(0),
												'1', '1', '1',
												D_RESULTADO_SR1(0), D_RESULTADO_SR1(1), D_RESULTADO_SR1(2), D_RESULTADO_SR1(3), D_RESULTADO_SR1(4), D_RESULTADO_SR1(5), D_RESULTADO_SR1(6)
												);
	-- 74LS47U decenas
	U4 : BCD_CASE_A01412388 port map(BIN2BCD_A_74LS47D(3), BIN2BCD_A_74LS47D(2), BIN2BCD_A_74LS47D(1), BIN2BCD_A_74LS47D(0),
												'1', '1', '1',
												D_RESULTADO_SR2(0), D_RESULTADO_SR2(1), D_RESULTADO_SR2(2), D_RESULTADO_SR2(3), D_RESULTADO_SR2(4), D_RESULTADO_SR2(5), D_RESULTADO_SR2(6)
												);
	
	-- BIN2BCD NUM2
	U5 : bin2bcd port map ("0000000000" & NUM_2, OPEN, OPEN,NUM2BIN2BCD_A_74LS47D, NUM2BIN2BCD_A_74LS47U);
	
	-- BIN2BCD NUM1
	U6 : bin2bcd port map ("0000000000" & NUM_1, OPEN, OPEN,NUM1BIN2BCD_A_74LS47D, NUM1BIN2BCD_A_74LS47U);
	
	-- NUUM 2 74LS47U unidades
	U7 : BCD_CASE_A01412388 port map(NUM2BIN2BCD_A_74LS47U(3), NUM2BIN2BCD_A_74LS47U(2), NUM2BIN2BCD_A_74LS47U(1), NUM2BIN2BCD_A_74LS47U(0),
												'1', '1', '1',
												D_UNIDADES_NUM2(0), D_UNIDADES_NUM2(1), D_UNIDADES_NUM2(2), D_UNIDADES_NUM2(3), D_UNIDADES_NUM2(4), D_UNIDADES_NUM2(5), D_UNIDADES_NUM2(6)
												);
												
	-- NUUM 2 74LS47D decenas
	U8 : BCD_CASE_A01412388 port map(NUM2BIN2BCD_A_74LS47D(3), NUM2BIN2BCD_A_74LS47D(2), NUM2BIN2BCD_A_74LS47D(1), NUM2BIN2BCD_A_74LS47D(0),
												'1', '1', '1',
												D_DECENAS_NUM2(0), D_DECENAS_NUM2(1), D_DECENAS_NUM2(2), D_DECENAS_NUM2(3), D_DECENAS_NUM2(4), D_DECENAS_NUM2(5), D_DECENAS_NUM2(6)
												);
												
	-- NUUM 1 74LS47U unidades
	U9 : BCD_CASE_A01412388 port map(NUM1BIN2BCD_A_74LS47U(3), NUM1BIN2BCD_A_74LS47U(2), NUM1BIN2BCD_A_74LS47U(1), NUM1BIN2BCD_A_74LS47U(0),
												'1', '1', '1',
												D_UNIDADES_NUM1(0), D_UNIDADES_NUM1(1), D_UNIDADES_NUM1(2), D_UNIDADES_NUM1(3), D_UNIDADES_NUM1(4), D_UNIDADES_NUM1(5), D_UNIDADES_NUM1(6)
												);
												
	-- NUUM 1 74LS47D decenas
	U10 : BCD_CASE_A01412388 port map(NUM1BIN2BCD_A_74LS47D(3), NUM1BIN2BCD_A_74LS47D(2), NUM1BIN2BCD_A_74LS47D(1), NUM1BIN2BCD_A_74LS47D(0),
												'1', '1', '1',
												D_DECENAS_NUM1(0), D_DECENAS_NUM1(1), D_DECENAS_NUM1(2), D_DECENAS_NUM1(3), D_DECENAS_NUM1(4), D_DECENAS_NUM1(5), D_DECENAS_NUM1(6)
												);
												
												
	-- LEDS FLOTANTES
	LEDS_FLOTANTES <= "00000";

END BEHAVIOR;