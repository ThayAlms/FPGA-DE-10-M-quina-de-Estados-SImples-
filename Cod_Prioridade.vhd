LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity Cod_Prioridade IS 			  			
	port 
	(	A,B, C : IN STD_LOGIC; 	
		X, Y  : OUT STD_LOGIC); 	
end Cod_Prioridade;

ARCHITECTURE FLUXO_DE_DADOS OF Cod_Prioridade IS      	
begin
	X <= A OR B;
	Y <= A OR (NOT(B) AND C);
end FLUXO_DE_DADOS;