----------------------------------------------------------------------------------
-- Company: NUS
-- Engineer: Rajesh Panicker
-- 
-- Create Date:   21:06:18 14/10/2014
-- Design Name: 	ControlUnit
-- Target Devices: Nexys 4 (Artix 7 100T)
-- Tool versions: ISE 14.7
-- Description: Control Unit for the basic MIPS processor
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: The interface (entity) as well as implementation (architecture) can be modified
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity ControlUnit is
    Port ( 	opcode 		: in  STD_LOGIC_VECTOR (5 downto 0);
				ALUOp 		: out  STD_LOGIC_VECTOR (1 downto 0);
				Branch 		: out  STD_LOGIC;		
				Jump	 		: out  STD_LOGIC;	
				MemRead 		: out  STD_LOGIC;	
				MemtoReg 	: out  STD_LOGIC;	
				InstrtoReg	: out STD_LOGIC;
				MemWrite		: out  STD_LOGIC;	
				ALUSrc 		: out  STD_LOGIC;	
				SignExtend 	: out  STD_LOGIC;
				RegWrite		: out  STD_LOGIC;	
				RegDst		: out  STD_LOGIC);
end ControlUnit;


architecture arch_ControlUnit of ControlUnit is  
begin   

process(opcode) is
begin
	
	case opcode is

		when "000000" => --R type instruction--
			RegDst <= '1';
			ALUSrc <= '0';
			MemtoReg <= '0';
			RegWrite <= '1';
			MemRead <= '0';
			MemWrite <= '0';
			Branch <= '0';
			Jump <= '0';
			ALUOp <= "10";
			SignExtend <= '1';
			InstrtoReg <= '0';

		when "100011" => --lw
			RegDst <= '0';
			ALUSrc <= '1';
			MemtoReg <= '1';
			RegWrite <= '1';
			MemRead <= '1';
			MemWrite <= '0';
			Branch <= '0';
			Jump <= '0';
			ALUOp <= "00";
			SignExtend <= '1';
			InstrtoReg <= '0';

		when "101011" => --sw
			RegDst <= '-';
			ALUSrc <= '1';
			MemtoReg <= '-';
			RegWrite <= '0';
			MemRead <= '0';
			MemWrite <= '1';
			Branch <= '0';
			Jump <= '0';
			ALUOp <= "00";
			SignExtend <= '1';
			InstrtoReg <= '0';

		when "000100" => --beq
			RegDst <= '-';
			ALUSrc <= '0';
			RegWrite <= '0';
			MemtoReg <= '-';
			MemRead <= '0';
			MemWrite <= '0';
			Branch <= '1';
			Jump <= '0';
			ALUOp <= "01";
			SignExtend <= '1';
			InstrtoReg <= '0';

		-- jump
		when "000010" =>
			RegDst <= '0';
			ALUSrc <= '0';
			RegWrite <= '0';
			MemtoReg <= '-';
			MemRead <= '0';
			MemWrite <= '0';
			Branch <= '0';
			Jump <= '1';
			ALUOp <= "01";
			SignExtend <= '1';
			InstrtoReg <= '0';
			
		-- ori, addi
		when "001101"=> 
			RegDst <= '0';
			ALUSrc <= '1';
			MemtoReg <= '0';
			RegWrite <= '1';
			MemRead <= '0';
			MemWrite <= '0';
			Branch <= '0';
			Jump <= '0';
			ALUOp <= "11";
			SignExtend <= '0';
			InstrtoReg <= '0';
		
		-- lui	
		when "001111" =>
			RegDst <= '0';
			ALUSrc <= '1';
			MemtoReg <= '0';
			RegWrite <= '1';
			MemRead <= '0';
			MemWrite <= '0';
			Branch <= '0';
			Jump <= '0';
			ALUOp <= "00";
			SignExtend <= '1';
			InstrtoReg <= '1';	
			
		when others => null;
		
	end case;
end process;

end arch_ControlUnit;

