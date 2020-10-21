--Name Madhu Ameneni



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity fpga_start_stop_relay_final is

		port (
			rst :in  std_logic :='1';
			clk : in std_logic := '1' ;
			ena : in std_logic := '1' ;
			cin: in std_logic:= '1';
		    cout : out std_logic;
			pulse_in :in std_logic  ;
			debounce_out : inout std_logic;
			bounce_in : in std_logic;
			start_stop : out std_logic :='0'
		);
		end entity ;
	

	architecture behavior of fpga_start_stop_relay_final is
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
			
			component cascadable_counter is 
			port(
				rst :in  std_logic :='1';
				clk : in std_logic := '1' ;
				ena : in std_logic := '1' ;
				cin :in std_logic  ;
				cout : out std_logic 
			);
			
			end component cascadable_counter;
			
	signal temp_data:   std_logic;	
    signal ena_20ms : std_logic;
    signal ena_1s : std_logic;
	signal led : std_logic;
	constant make_level : std_logic := '0';
		
	begin 
	
	cas1:cascadable_counter1
		port map (
			 rst => rst,
			 clk => clk,
			 ena => ena,
			 cin => cin,

			cout => ena_20ms

		  );
		  
		  
	cas2:cascadable_counter2
		port map (
			 rst => rst,
			 clk => clk,
			 ena => ena,
			 cin => cin,

			cout => ena_1s

		  );	  
		  
	reply2:start_stop_relay1
		generic map (make_level => make_level)
	
		port map (
			 rst => rst,
			 clk => clk,
			 ena => ena,
			 start_stop => led,

			ena_1s => pulse_in
		  );
	
	deb:debounce
		port map (
			 rst => rst,
			 clk => clk,
			 ena_20ms => ena,
			 bounce_in => bounce_in,

			debounce_out => temp_data
		  );
		
	reply:start_stop_relay
		generic map (make_level => make_level)
	
		port map (
			 rst => rst,
			 clk => clk,
			 ena => ena,
			 start_stop => start_stop,
			temp_data => pulse_in					  
		  );
		  		 
			 end architecture;