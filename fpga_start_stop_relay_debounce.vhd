--Name Madhu Ameneni



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity fpga_start_stop_relay_debounce is

	   --generic
		--(
		--make_level : std_logic := '0'
		--);
		port (
			rst :in  std_logic :='1';
			clk : in std_logic := '1' ;
			ena : in std_logic := '1' ;
			pulse_in :in std_logic  ;
			debounce_out : inout std_logic;
			bounce_in : in std_logic;
			start_stop : out std_logic :='0'
		);
		end entity ;
	

	architecture behavior of fpga_start_stop_relay_debounce is
		component start_stop_relay is 
			generic (		  
				make_level :std_logic
	);
		

			port(
				rst :in  std_logic :='1';
				clk : in std_logic := '1' ;
				ena : in std_logic := '1' ;
				pulse_in :in std_logic  ;
				
				
				start_stop : out std_logic 
			);
			
			end component start_stop_relay;
			
			component debounce is 
			port(
				rst :in  std_logic :='1';
				clk : in std_logic := '1' ;
				ena : in std_logic := '1' ;
				bounce_in :in std_logic  ;
				
				
				debounce_out : out std_logic 
			);
			
			end component debounce;
			
	signal temp_data:   std_logic;	

	constant make_level : std_logic := '0';
		
	begin 
dut:start_stop_relay
		generic map (make_level => make_level)
	
		port map (
			 rst => rst,
			 clk => clk,
			 ena => ena,
			 start_stop => start_stop,

			temp_data => pulse_in
			
		  

		  );
		  
		  dut1:debounce
		port map (
			 rst => rst,
			 clk => clk,
			 ena => ena,
			 bounce_in => bounce_in,

			debounce_out => temp_data

		  );
			 
			 
			 end architecture;