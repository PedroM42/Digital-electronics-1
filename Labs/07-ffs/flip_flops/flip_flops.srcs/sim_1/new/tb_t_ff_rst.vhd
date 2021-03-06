----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/25/2021 07:58:39 PM
-- Design Name: 
-- Module Name: tb_t_ff_rst - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_t_ff_rst is
--  Port ( );
end tb_t_ff_rst;

architecture Behavioral of tb_t_ff_rst is
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
   
    signal s_clk : STD_LOGIC;
    signal s_t : STD_LOGIC;
    signal s_rst : STD_LOGIC;
    signal s_q : STD_LOGIC;
    signal s_q_bar : STD_LOGIC;
begin

    uut_d_ff_arst : entity work.t_ff_rst
    port map (
        clk     =>  s_clk,
        t       =>  s_t,
        rst     =>  s_rst,
        q       =>  s_q,
        q_bar   =>  s_q_bar
    );
    
    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 750 ns loop         -- 75 periods of 100MHz clock
            s_clk   <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk   <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    --------------------------------------------------------------------
    -- Reset generation process
    --------------------------------------------------------------------
    p_reset_gen : process
    begin
        s_rst   <= '0';
        wait for 10 ns;
        
        s_rst   <= '1';              
        wait for 10 ns;
        
        s_rst   <= '0';
        wait for 90 ns;
        
        s_rst   <= '1';
        wait for 30 ns;
        
        s_rst   <= '0';
        wait;
    end process p_reset_gen;

    
    p_stimulus : process
    begin

        report "Stimulus process started. " severity note;
        
        wait for 20 ns;
        s_t <=  '1';
        wait for 10ns;
        
        assert (s_q = '1' and s_q_bar = '0') 
        report "Tienes un problema(1)" severity error;
        s_t <=  '0';
        wait for 10ns;
        
        assert (s_q = '1' and s_q_bar = '0') 
        report "Tienes un problema(2)" severity error;
        
        s_t <=  '1';        
        wait for 10ns;
        
        assert (s_q = '0' and s_q_bar = '1') 
        report "Tienes un problema(3)" severity error; 
              
        s_t <=  '0';      
        wait for 10ns;     
        
        assert (s_q = '0' and s_q_bar = '1') 
        report "Tienes un problema(4)" severity error;
        
        s_t <=  '1';
        wait for 10ns;
        
        assert (s_q = '1' and s_q_bar = '0') 
        report "Tienes un problema(5)" severity error; 
        
        s_t <=  '0';
        wait for 10ns;
        
        assert (s_q = '1' and s_q_bar = '0') 
        report "Tienes un problema(6)" severity error;  
        
        s_t <=  '0';
        wait for 10ns;
        
        assert (s_q = '1' and s_q_bar = '0') 
        report "Tienes un problema(7)" severity error;
        
        s_t <=  '1';      
        wait for 10ns;       
        
        assert (s_q = '0' and s_q_bar = '1') 
        report "Tienes un problema(8)" severity error;  
                
        report "Stimulus process ended. " severity note;
        wait;
    end process p_stimulus;



end Behavioral;