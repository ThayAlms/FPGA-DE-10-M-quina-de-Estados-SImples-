--*****************************************************************************
-- CENTRO UNIVERSITARIO FEI
-- Sistemas Digitais II  -  Projeto 1  - 2o Semestre de 2024
-- Prof. Dr. Valter F. Avelino - 07/2024
-- Componente VHDL: Divisor de frequencia 2 Hz /50 MHz => ENABLE_2HZ.vhd
-- Rev. 0
-- Especificações: Entradas: CLK, INI
-- 				    Saidas:   EN_2HZ (pulso de 20ns a cada 500ms)
-- Esse codigo eh um exemplo de descricao VHDL de um circuito divisor de 
-- frequencia cuja entrada eh um sinal de clock de 50 MZ e gera na saida
-- pulsos com duracao de 20 ns na frequencia de 2 Hz. Este projeto foi 
-- desenvolvido em VHDL na disciplina do Laboratorio de Sistemas Digitais II 
-- do Centro Universitario FEI.
--****************************************************************************
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY ENABLE_2HZ IS
    PORT (CLK, INI: IN STD_LOGIC; 			-- declaracao dos sinais de entrada
		  EN_2HZ: OUT STD_LOGIC );		    	-- declaracao dos sinais de saída
END ENABLE_2HZ;

ARCHITECTURE BEHAVIOR OF ENABLE_2HZ IS
	TYPE TIPO_MODO IS (INICIO, A, B);	
    SIGNAL E: TIPO_MODO;					-- variavel de Estado     
    SIGNAL CNT: INTEGER RANGE 0 TO 25000000;-- contador (0 a 25.0000.000)
BEGIN
    PROCESS (CLK,INI)						-- lista da sensibilidade do processo
    BEGIN
        IF (INI= '0') THEN E<= INICIO; CNT<= 0; EN_2HZ<= '0';
        ELSIF (CLK'event and CLK='1') THEN  -- deteccao de borda de subida do CLK
            CASE E IS
                WHEN INICIO => E<= A; CNT<= 0; EN_2HZ<= '0';
                WHEN A =>
                    IF CNT= 24999998 THEN E<= B; CNT<= 0; EN_2HZ<= '1';
                    ELSE CNT<= CNT+1; EN_2HZ<= '0';
                    END IF;
                WHEN B => E<= A; EN_2HZ<= '0';
		END CASE;
        END IF;
    END PROCESS;
END BEHAVIOR;
