library ieee; 
use ieee.std_logic_1164.all;

entity MSS is
      port (clk, resetn, start, Fin_k, GAP_0, i_n, condicion: in std_logic;
		      En_Reg0,Ld_0,En_k,Ld_k,RW,En_i,Ld_i: out std_logic;
				En_buffer,En_inGAP,S0,En_R,Ld_R,done,En_Comp: out std_logic;
				sel:	out std_logic_vector(1 downto 0);
				estados: out std_logic_vector(7 downto 0)); 
end MSS;

 architecture solv of MSS is
 type estado is (A,B,C,D,E,F,G,H,I,J,J1,K,L,M,N,O,P,P0,Q,R,S,T,U);
 signal y: estado; 
 
 begin 
		 
		 process(clk, resetn)
		 begin
		     
			  if resetn = '0' then y <= A; 
			  elsif (clk' event and clk = '1') then
			       case y is
					      
							when A => if start = '1' then y <= B; else y <= A; end if;
							
							when B => y <= c;
							
							when c => if GAP_0 = '1' then y <= D; else y <= R; end if;
							
							when D => y <= E; 
							
							when E => y <= F;

							when F => y <= G; 
					
							when G => y <= H;
							
							when H => y <= I;
							
							when I => y <= J;
							
							when J => y<=J1;
							
							when J1 => if condicion = '1' then y <= K; else y <= N; end if;
																						
							when K => y <= L;
							
							when L => y <= M;
						
							when M => y <= H;
							
							when N => y <= O;
							
							when O => y <= P;
							
							when P => y <= P0;
							
							when P0 => if i_n = '1' then y <= E; else y <= Q; end if;
							
							when Q => y <= C;
							
							when R => y <= S; 
							
							when S => if Fin_k = '1' then y <= U; else y <= T; end if;
							
							when T => y <= S;
							
							when U => if start = '1' then y <= A; else y <= U; end if;
												
					  end case;
			   end if; 
			end process; 	
			
process(y)
begin 
		 En_Reg0 <= '0'; Ld_0 <= '0'; En_k <= '0'; Ld_k <= '0';      En_i<='0';
		 Ld_i <= '0';    En_R <= '0'; Ld_R <= '0'; En_buffer <= '0'; En_inGAP <= '0'; 
		 sel(0)<= '0';	  sel(1)<='0'; S0 <= '0';      RW <= '0';        done <= '0';
		 En_Comp <= '0';
		 
	  case y is
		    when A => En_Reg0 <= '1'; Ld_0 <= '1'; En_k <= '1'; Ld_k <= '1'; estados <= "01000001";
			 
			 when B => En_Reg0 <= '1'; estados <= "01000010";
			 
			 when C => estados <= "01000011";
			 
			 when D => En_i <= '1'; Ld_i <= '1'; estados <= "01000100";
			 
			 when E => En_R <= '1'; Ld_R <= '1'; estados <= "01000101";
			 			 
			 when F => estados <= "01000110";
			 
			 when G => En_buffer <= '1'; estados <= "01000111";
			 
			 when H => sel(1) <= '1';estados <= "01001000";
			 
			 when I => sel(1) <= '1';  estados <= "01001001";
			 
			 when J => En_inGAP <= '1'; estados <= "01001010";
			 
			 when J1 => En_Comp <='1'; estados <= "01010111";
			 
			 when K => sel(0) <= '1'; S0<='1';   estados <= "01001011";
			 
			 when L => S0 <= '1'; sel(0)<= '1'; RW <= '1'; estados <= "01001100";
			 
			 when M => En_R <= '1'; estados <= "01001101";
			 
			 when N => sel(0) <= '1'; estados <= "01001110";
			 
			 when O => sel(0)<= '1'; RW <='1'; estados <= "01001111";
			 
			 when P => En_i <= '1'; estados <= "01010000";
			 
			 when P0 => estados <= "01011000";
			 
			 when Q => En_Reg0 <= '1'; estados <= "01010001";
			 
			 when R => done <= '1'; estados <= "01010010";
			 
			 when S => sel(0)<= '1'; sel(1)<= '1'; estados <= "01010011";
			 
			 when T => sel(0)<= '1'; sel(1)<= '1'; En_k <= '1';  estados <= "01010100";
			 
			 when U => estados <= "01010101";
			
	   end case; 
end process; 
end solv; 