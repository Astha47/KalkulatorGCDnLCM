library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity receiver is
    Port (
        RST     : in  STD_LOGIC;
        RECEIVE   : in  STD_LOGIC;
		RECEIVE_FEEDBACK   : OUT  STD_LOGIC;
        RECEIVE_DATA : in  STD_LOGIC_VECTOR (7 downto 0);
        CLK     : in  STD_LOGIC;
        DONE    : out STD_LOGIC;
        ERROR    : out STD_LOGIC;
        BILANGAN1  : out UNSIGNED (7 downto 0);
        BILANGAN2  : out UNSIGNED (7 downto 0);
        BILANGAN3  : out UNSIGNED (7 downto 0);
        BILANGAN4  : out UNSIGNED (7 downto 0);
        
        
        
        -- DEBUGGING PORT
        COUNTERP : out INTEGER;
        WAITINGP : out INTEGER;
        
        BILANGAN1internalAP  : OUT STD_LOGIC_VECTOR (7 downto 0);
		BILANGAN1internalBP  : OUT STD_LOGIC_VECTOR (7 downto 0);
		BILANGAN1internalCP  : OUT STD_LOGIC_VECTOR (7 downto 0);
		
		BILANGAN2internalAP  : OUT STD_LOGIC_VECTOR (7 downto 0);
		BILANGAN2internalBP  : OUT STD_LOGIC_VECTOR (7 downto 0);
		BILANGAN2internalCP  : OUT STD_LOGIC_VECTOR (7 downto 0);
		
		BILANGAN3internalAP  : OUT STD_LOGIC_VECTOR (7 downto 0);
		BILANGAN3internalBP  : OUT STD_LOGIC_VECTOR (7 downto 0);
		BILANGAN3internalCP  : OUT STD_LOGIC_VECTOR (7 downto 0);
		
		BILANGAN4internalAP  : OUT STD_LOGIC_VECTOR (7 downto 0);
		BILANGAN4internalBP  : OUT STD_LOGIC_VECTOR (7 downto 0);
		BILANGAN4internalCP  : OUT STD_LOGIC_VECTOR (7 downto 0);
		
		
        MODE  : out STD_LOGIC_VECTOR (1 downto 0);
        JUMLAH  : out STD_LOGIC_VECTOR (1 downto 0)
        
    );
end receiver;

architecture ArsitekturReceiver of receiver is
    
    constant MAX_WAIT : integer :=		5300;
    SIGNAL COUNTER : INTEGER := 0;
    SIGNAL WAITING : INTEGER := 0;
	
    -- KAMUS COUNTER
    -- 0 WAIT ARRIVING DATA OF MODE
    -- 1 WAITING RECIEVING DATA OF MODE DONE
    -- 2 WAITING ARRIVING DATA OF JUMLAH
    -- 3 WAITING RECIEVING DATA OF JUMLAH DONE
    -- 4 WAITING ARRIVING DATA OF BILANGAN
    -- 5 WAITING RECIEVING DATA OF JUMLAH DONE
    
    -- Error
    SIGNAL ERRORinput : STD_LOGIC := '0';
    
    -- SIGNAL RECEIVER     
    SIGNAL BILANGAN1internalA  : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL BILANGAN1internalB  : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL BILANGAN1internalC  : STD_LOGIC_VECTOR (7 downto 0);
    
    SIGNAL BILANGAN2internalA  : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL BILANGAN2internalB  : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL BILANGAN2internalC  : STD_LOGIC_VECTOR (7 downto 0);
    
    SIGNAL BILANGAN3internalA  : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL BILANGAN3internalB  : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL BILANGAN3internalC  : STD_LOGIC_VECTOR (7 downto 0);
    
    SIGNAL BILANGAN4internalA  : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL BILANGAN4internalB  : STD_LOGIC_VECTOR (7 downto 0);
    SIGNAL BILANGAN4internalC  : STD_LOGIC_VECTOR (7 downto 0);
    
    -- SIGNAL TRANSLASI
    
    SIGNAL MODEtemp : UNSIGNED (1 downto 0);
    
    SIGNAL JUMLAHtemp : UNSIGNED (1 downto 0);
    
    SIGNAL BILANGAN1temp  : UNSIGNED (7 downto 0);
    SIGNAL BILANGAN2temp  : UNSIGNED (7 downto 0);
    SIGNAL BILANGAN3temp  : UNSIGNED (7 downto 0);
	SIGNAL BILANGAN4temp  : UNSIGNED (7 downto 0);

	--SIGNAL BILANGAN1tempC  : UNSIGNED (15 downto 0);
    --SIGNAL BILANGAN2tempC  : UNSIGNED (15 downto 0);
    --SIGNAL BILANGAN3tempC  : UNSIGNED (15 downto 0);
	--SIGNAL BILANGAN4tempC  : UNSIGNED (15 downto 0);
    
    
begin
	PROCESS(CLK)
	BEGIN
		IF RISING_EDGE(CLK) THEN
			IF (RST = '0') THEN
				DONE <= '1';
				
			ELSE
				IF ERRORinput = '0' THEN
					IF COUNTER = 0 THEN
						IF RECEIVE = '1'  THEN
							COUNTER <= 1;
							DONE <= '0';
						END IF;
						
					ELSIF COUNTER = 1 THEN
						IF RECEIVE = '0' THEN
							
							-- MODE TRANSLATION
							case RECEIVE_DATA is
								when "01000001" =>
									MODEtemp <= "11"; -- All
									COUNTER <= 2;
								when "01000111" =>
									MODEtemp <= "01"; -- GCD
									COUNTER <= 2;
								when "01001100" =>
									MODEtemp <= "10"; -- LCM
									COUNTER <= 2;
								when others =>
									-- Penanganan Error
									ERRORinput <= '1';
								WAITING <= 0;
							END CASE;
						END IF;

					ELSIF COUNTER = 2 THEN
						IF WAITING < MAX_WAIT THEN
							IF RECEIVE = '1' THEN
								COUNTER <= 3;
								WAITING <= 0;
							ELSE 
								WAITING <= WAITING + 1;
							END IF;
						ELSE
							ERRORinput <= '1';
						END IF;							
							
					ELSIF COUNTER = 3 THEN
						IF RECEIVE = '0' THEN
							IF RECEIVE_DATA = "00100000" THEN
								COUNTER <= 4;
							ELSE
								ERRORinput <= '1';
							END IF;
						END IF;
					
					ELSIF COUNTER = 4 THEN
						IF WAITING < MAX_WAIT THEN
							IF RECEIVE = '1' THEN
								COUNTER <= 5;
								WAITING <= 0;
							ELSE
								WAITING <= WAITING + 1;
							END IF;							
						ELSE
							ERRORinput <= '1';
						END IF;
					ELSIF COUNTER = 5 THEN
						IF RECEIVE = '0' THEN
							-- MODE TRANSLATION
							case RECEIVE_DATA is
							when "00110010" =>
								JUMLAHtemp <= "01"; -- 2
								COUNTER <= 6;
							when "00110011" =>
								JUMLAHtemp <= "10"; -- 3
								COUNTER <= 6;
							when "00110100" =>
								JUMLAHtemp <= "11"; -- 4
								COUNTER <= 6;
							when others =>
								-- Penanganan Error
								ERRORinput <= '1';
							
							END CASE;
						END IF;
					ELSIF COUNTER = 6 then
						IF WAITING < MAX_WAIT THEN
							IF RECEIVE = '1' THEN
								COUNTER <= 7;
								WAITING <= 0;
							ELSE 
								WAITING <= WAITING + 1;
							END IF;
						ELSE
							ERRORinput <= '1';
						END IF;	
					ELSIF COUNTER = 7 then
						IF RECEIVE = '0' THEN
							IF RECEIVE_DATA = "00100000" THEN
								COUNTER <= 8;
							ELSE
								ERRORinput <= '1';
							END IF;
						END IF;
					ELSIF COUNTER = 8 then
						IF WAITING < MAX_WAIT THEN
							IF RECEIVE = '1' THEN
								COUNTER <= 9;
								WAITING <= 0;
							ELSE
								WAITING <= WAITING + 1;
							END IF;							
						ELSE
							ERRORinput <= '1';
						END IF;

					-- BILANGAN PERTAMA
					ELSIF COUNTER = 9 then
						IF RECEIVE = '0' THEN
							-- MODE TRANSLATION
							case RECEIVE_DATA is
							when "00110000" =>
								BILANGAN1internalA <= "00000000"; -- 0
								COUNTER <= 10;
							when "00110001" =>
								BILANGAN1internalA <= "00000001"; -- 1
								COUNTER <= 10;
							when "00110010" =>
								BILANGAN1internalA <= "00000010"; -- 2
								COUNTER <= 10;
							when "00110011" =>
								BILANGAN1internalA <= "00000011"; -- 3
								COUNTER <= 10;
							when "00110100" =>
								BILANGAN1internalA <= "00000100"; -- 4
								COUNTER <= 10;
							when "00110101" =>
								BILANGAN1internalA <= "00000101"; -- 5
								COUNTER <= 10;
							when "00110110" =>
								BILANGAN1internalA <= "00000110"; -- 6
								COUNTER <= 10;
							when "00110111" =>
								BILANGAN1internalA <= "00000111"; -- 7
								COUNTER <= 10;
							when "00111000" =>
								BILANGAN1internalA <= "00001000"; -- 8
								COUNTER <= 10;
							when "00111001" =>
								BILANGAN1internalA <= "00001001"; -- 9
								COUNTER <= 10;
							when others =>
								-- Penanganan Error
								ERRORinput <= '1';
							
							END CASE;
						END IF;
					ELSIF COUNTER = 10 then
						IF WAITING < MAX_WAIT THEN
							IF RECEIVE = '1' THEN
								COUNTER <= 11;
								WAITING <= 0;
							ELSE
								WAITING <= WAITING + 1;
							END IF;							
						ELSE
							ERRORinput <= '1';
						END IF;
					ELSIF COUNTER = 11 then
						IF RECEIVE = '0' THEN
							-- MODE TRANSLATION
							case RECEIVE_DATA is
							when "00110000" =>
								BILANGAN1internalB <= "00000000"; -- 0
								COUNTER <= 12;
							when "00110001" =>
								BILANGAN1internalB <= "00000001"; -- 1
								COUNTER <= 12;
							when "00110010" =>
								BILANGAN1internalB <= "00000010"; -- 2
								COUNTER <= 12;
							when "00110011" =>
								BILANGAN1internalB <= "00000011"; -- 3
								COUNTER <= 12;
							when "00110100" =>
								BILANGAN1internalB <= "00000100"; -- 4
								COUNTER <= 12;
							when "00110101" =>
								BILANGAN1internalB <= "00000101"; -- 5
								COUNTER <= 12;
							when "00110110" =>
								BILANGAN1internalB <= "00000110"; -- 6
								COUNTER <= 12;
							when "00110111" =>
								BILANGAN1internalB <= "00000111"; -- 7
								COUNTER <= 12;
							when "00111000" =>
								BILANGAN1internalB <= "00001000"; -- 8
								COUNTER <= 12;
							when "00111001" =>
								BILANGAN1internalB <= "00001001"; -- 9
								COUNTER <= 12;
							when others =>
								-- Penanganan Error
								ERRORinput <= '1';
							
							END CASE;
						END IF;
					ELSIF COUNTER = 12 then
						IF WAITING < MAX_WAIT THEN
							IF RECEIVE = '1' THEN
								COUNTER <= 13;
								WAITING <= 0;
							ELSE
								WAITING <= WAITING + 1;
							END IF;							
						ELSE
							ERRORinput <= '1';
						END IF;
					ELSIF COUNTER = 13 then
						IF RECEIVE = '0' THEN
							-- MODE TRANSLATION
							case RECEIVE_DATA is
							when "00110000" =>
								BILANGAN1internalC <= "00000000"; -- 0
								COUNTER <= 14;
							when "00110001" =>
								BILANGAN1internalC <= "00000001"; -- 1
								COUNTER <= 14;
							when "00110010" =>
								BILANGAN1internalC <= "00000010"; -- 2
								COUNTER <= 14;
							when "00110011" =>
								BILANGAN1internalC <= "00000011"; -- 3
								COUNTER <= 14;
							when "00110100" =>
								BILANGAN1internalC <= "00000100"; -- 4
								COUNTER <= 14;
							when "00110101" =>
								BILANGAN1internalC <= "00000101"; -- 5
								COUNTER <= 14;
							when "00110110" =>
								BILANGAN1internalC <= "00000110"; -- 6
								COUNTER <= 14;
							when "00110111" =>
								BILANGAN1internalC <= "00000111"; -- 7
								COUNTER <= 14;
							when "00111000" =>
								BILANGAN1internalC <= "00001000"; -- 8
								COUNTER <= 14;
							when "00111001" =>
								BILANGAN1internalC <= "00001001"; -- 9
								COUNTER <= 14;
							when others =>
								-- Penanganan Error
								ERRORinput <= '1';
							
							END CASE;
						END IF;
					ELSIF COUNTER = 14 then
						IF WAITING < MAX_WAIT THEN
							IF RECEIVE = '1' THEN
								COUNTER <= 15;
								WAITING <= 0;
							ELSE
								WAITING <= WAITING + 1;
							END IF;							
						ELSE
							ERRORinput <= '1';
						END IF;
					ELSIF COUNTER = 15 THEN
						IF RECEIVE = '0' THEN
							IF RECEIVE_DATA = "00100000" THEN
								COUNTER <= 16;
							ELSE
								ERRORinput <= '1';
							END IF;
						END IF;
					ELSIF COUNTER = 16 then
						IF WAITING < MAX_WAIT THEN
							IF RECEIVE = '1' THEN
								COUNTER <= 17;
								WAITING <= 0;
							ELSE
								WAITING <= WAITING + 1;
							END IF;							
						ELSE
							ERRORinput <= '1';
						END IF;
					
					-- BILANGAN KEDUA
					ELSIF COUNTER = 17 then
						IF RECEIVE = '0' THEN
							-- MODE TRANSLATION
							case RECEIVE_DATA is
							when "00110000" =>
								BILANGAN2internalA <= "00000000"; -- 0
								COUNTER <= 18;
							when "00110001" =>
								BILANGAN2internalA <= "00000001"; -- 1
								COUNTER <= 18;
							when "00110010" =>
								BILANGAN2internalA <= "00000010"; -- 2
								COUNTER <= 18;
							when "00110011" =>
								BILANGAN2internalA <= "00000011"; -- 3
								COUNTER <= 18;
							when "00110100" =>
								BILANGAN2internalA <= "00000100"; -- 4
								COUNTER <= 18;
							when "00110101" =>
								BILANGAN2internalA <= "00000101"; -- 5
								COUNTER <= 18;
							when "00110110" =>
								BILANGAN2internalA <= "00000110"; -- 6
								COUNTER <= 18;
							when "00110111" =>
								BILANGAN2internalA <= "00000111"; -- 7
								COUNTER <= 18;
							when "00111000" =>
								BILANGAN2internalA <= "00001000"; -- 8
								COUNTER <= 18;
							when "00111001" =>
								BILANGAN2internalA <= "00001001"; -- 9
								COUNTER <= 18;
							when others =>
								-- Penanganan Error
								ERRORinput <= '1';
							
							END CASE;
						END IF;
					ELSIF COUNTER = 18 then
						IF WAITING < MAX_WAIT THEN
							IF RECEIVE = '1' THEN
								COUNTER <= 19;
								WAITING <= 0;
							ELSE
								WAITING <= WAITING + 1;
							END IF;							
						ELSE
							ERRORinput <= '1';
						END IF;
					ELSIF COUNTER = 19 then
						IF RECEIVE = '0' THEN
							-- MODE TRANSLATION
							case RECEIVE_DATA is
							when "00110000" =>
								BILANGAN2internalB <= "00000000"; -- 0
								COUNTER <= 20;
							when "00110001" =>
								BILANGAN2internalB <= "00000001"; -- 1
								COUNTER <= 20;
							when "00110010" =>
								BILANGAN2internalB <= "00000010"; -- 2
								COUNTER <= 20;
							when "00110011" =>
								BILANGAN2internalB <= "00000011"; -- 3
								COUNTER <= 20;
							when "00110100" =>
								BILANGAN2internalB <= "00000100"; -- 4
								COUNTER <= 20;
							when "00110101" =>
								BILANGAN2internalB <= "00000101"; -- 5
								COUNTER <= 20;
							when "00110110" =>
								BILANGAN2internalB <= "00000110"; -- 6
								COUNTER <= 20;
							when "00110111" =>
								BILANGAN2internalB <= "00000111"; -- 7
								COUNTER <= 20;
							when "00111000" =>
								BILANGAN2internalB <= "00001000"; -- 8
								COUNTER <= 20;
							when "00111001" =>
								BILANGAN2internalB <= "00001001"; -- 9
								COUNTER <= 20;
							when others =>
								-- Penanganan Error
								ERRORinput <= '1';
							
							END CASE;
						END IF;
					ELSIF COUNTER = 20 then
						IF WAITING < MAX_WAIT THEN
							IF RECEIVE = '1' THEN
								COUNTER <= 21;
								WAITING <= 0;
							ELSE
								WAITING <= WAITING + 1;
							END IF;							
						ELSE
							ERRORinput <= '1';
						END IF;
					ELSIF COUNTER = 21 then
						IF RECEIVE = '0' THEN
							-- MODE TRANSLATION
							case RECEIVE_DATA is
							when "00110000" =>
								BILANGAN2internalC <= "00000000"; -- 0
								COUNTER <= 22;
							when "00110001" =>
								BILANGAN2internalC <= "00000001"; -- 1
								COUNTER <= 22;
							when "00110010" =>
								BILANGAN2internalC <= "00000010"; -- 2
								COUNTER <= 22;
							when "00110011" =>
								BILANGAN2internalC <= "00000011"; -- 3
								COUNTER <= 22;
							when "00110100" =>
								BILANGAN2internalC <= "00000100"; -- 4
								COUNTER <= 22;
							when "00110101" =>
								BILANGAN2internalC <= "00000101"; -- 5
								COUNTER <= 22;
							when "00110110" =>
								BILANGAN2internalC <= "00000110"; -- 6
								COUNTER <= 22;
							when "00110111" =>
								BILANGAN2internalC <= "00000111"; -- 7
								COUNTER <= 22;
							when "00111000" =>
								BILANGAN2internalC <= "00001000"; -- 8
								COUNTER <= 22;
							when "00111001" =>
								BILANGAN2internalC <= "00001001"; -- 9
								COUNTER <= 22;
							when others =>
								-- Penanganan Error
								ERRORinput <= '1';
							
							END CASE;
						END IF;
					ELSIF COUNTER = 22 then
						IF ((JUMLAHtemp = "10") OR (JUMLAHtemp = "11")) THEN
							IF WAITING < MAX_WAIT THEN
								IF RECEIVE = '1' THEN
									COUNTER <= 23;
									WAITING <= 0;
								ELSE
									WAITING <= WAITING + 1;
								END IF;							
							ELSE
								ERRORinput <= '1';
							END IF;
						else
							COUNTER <= 38;
						END IF;
					ELSIF COUNTER = 23 THEN
						IF RECEIVE = '0' THEN
							IF RECEIVE_DATA = "00100000" THEN
								COUNTER <= 24;
							ELSE
								ERRORinput <= '1';
							END IF;
						END IF;
					ELSIF COUNTER = 24 then
						IF WAITING < MAX_WAIT THEN
							IF RECEIVE = '1' THEN
								COUNTER <= 25;
								WAITING <= 0;
							ELSE
								WAITING <= WAITING + 1;
							END IF;							
						ELSE
							ERRORinput <= '1';
						END IF;
					
					-- BILANGAN KETIGA
					ELSIF COUNTER = 25 then
						IF RECEIVE = '0' THEN
							-- MODE TRANSLATION
							case RECEIVE_DATA is
							when "00110000" =>
								BILANGAN3internalA <= "00000000"; -- 0
								COUNTER <= 26;
							when "00110001" =>
								BILANGAN3internalA <= "00000001"; -- 1
								COUNTER <= 26;
							when "00110010" =>
								BILANGAN3internalA <= "00000010"; -- 2
								COUNTER <= 26;
							when "00110011" =>
								BILANGAN3internalA <= "00000011"; -- 3
								COUNTER <= 26;
							when "00110100" =>
								BILANGAN3internalA <= "00000100"; -- 4
								COUNTER <= 26;
							when "00110101" =>
								BILANGAN3internalA <= "00000101"; -- 5
								COUNTER <= 26;
							when "00110110" =>
								BILANGAN3internalA <= "00000110"; -- 6
								COUNTER <= 26;
							when "00110111" =>
								BILANGAN3internalA <= "00000111"; -- 7
								COUNTER <= 26;
							when "00111000" =>
								BILANGAN3internalA <= "00001000"; -- 8
								COUNTER <= 26;
							when "00111001" =>
								BILANGAN3internalA <= "00001001"; -- 9
								COUNTER <= 26;
							when others =>
								-- Penanganan Error
								ERRORinput <= '1';
							
							END CASE;
						END IF;
					ELSIF COUNTER = 26 then
						IF WAITING < MAX_WAIT THEN
							IF RECEIVE = '1' THEN
								COUNTER <= 27;
								WAITING <= 0;
							ELSE
								WAITING <= WAITING + 1;
							END IF;							
						ELSE
							ERRORinput <= '1';
						END IF;
					ELSIF COUNTER = 27 then
						IF RECEIVE = '0' THEN
							-- MODE TRANSLATION
							case RECEIVE_DATA is
							when "00110000" =>
								BILANGAN3internalB <= "00000000"; -- 0
								COUNTER <= 28;
							when "00110001" =>
								BILANGAN3internalB <= "00000001"; -- 1
								COUNTER <= 28;
							when "00110010" =>
								BILANGAN3internalB <= "00000010"; -- 2
								COUNTER <= 28;
							when "00110011" =>
								BILANGAN3internalB <= "00000011"; -- 3
								COUNTER <= 28;
							when "00110100" =>
								BILANGAN3internalB <= "00000100"; -- 4
								COUNTER <= 28;
							when "00110101" =>
								BILANGAN3internalB <= "00000101"; -- 5
								COUNTER <= 28;
							when "00110110" =>
								BILANGAN3internalB <= "00000110"; -- 6
								COUNTER <= 28;
							when "00110111" =>
								BILANGAN3internalB <= "00000111"; -- 7
								COUNTER <= 28;
							when "00111000" =>
								BILANGAN3internalB <= "00001000"; -- 8
								COUNTER <= 28;
							when "00111001" =>
								BILANGAN3internalB <= "00001001"; -- 9
								COUNTER <= 28;
							when others =>
								-- Penanganan Error
								ERRORinput <= '1';
							
							END CASE;
						END IF;
					ELSIF COUNTER = 28 then
						IF WAITING < MAX_WAIT THEN
							IF RECEIVE = '1' THEN
								COUNTER <= 29;
								WAITING <= 0;
							ELSE
								WAITING <= WAITING + 1;
							END IF;							
						ELSE
							ERRORinput <= '1';
						END IF;
					ELSIF COUNTER = 29 then
						IF RECEIVE = '0' THEN
							-- MODE TRANSLATION
							case RECEIVE_DATA is
							when "00110000" =>
								BILANGAN3internalC <= "00000000"; -- 0
								COUNTER <= 30;
							when "00110001" =>
								BILANGAN3internalC <= "00000001"; -- 1
								COUNTER <= 30;
							when "00110010" =>
								BILANGAN3internalC <= "00000010"; -- 2
								COUNTER <= 30;
							when "00110011" =>
								BILANGAN3internalC <= "00000011"; -- 3
								COUNTER <= 30;
							when "00110100" =>
								BILANGAN3internalC <= "00000100"; -- 4
								COUNTER <= 30;
							when "00110101" =>
								BILANGAN3internalC <= "00000101"; -- 5
								COUNTER <= 30;
							when "00110110" =>
								BILANGAN3internalC <= "00000110"; -- 6
								COUNTER <= 30;
							when "00110111" =>
								BILANGAN3internalC <= "00000111"; -- 7
								COUNTER <= 30;
							when "00111000" =>
								BILANGAN3internalC <= "00001000"; -- 8
								COUNTER <= 30;
							when "00111001" =>
								BILANGAN3internalC <= "00001001"; -- 9
								COUNTER <= 30;
							when others =>
								-- Penanganan Error
								ERRORinput <= '1';
							
							END CASE;
						END IF;

					ELSIF COUNTER = 30 then
						IF (JUMLAHtemp = "11")THEN
							IF WAITING < MAX_WAIT THEN
								IF RECEIVE = '1' THEN
									COUNTER <= 31;
									WAITING <= 0;
								ELSE
									WAITING <= WAITING + 1;
								END IF;							
							ELSE
								ERRORinput <= '1';
							END IF;
						else
							COUNTER <= 38;
						END IF;
					ELSIF COUNTER = 31 THEN
						IF RECEIVE = '0' THEN
							IF RECEIVE_DATA = "00100000" THEN
								COUNTER <= 32;
							ELSE
								ERRORinput <= '1';
							END IF;
						END IF;
					ELSIF COUNTER = 32 then
						IF WAITING < MAX_WAIT THEN
							IF RECEIVE = '1' THEN
								COUNTER <= 33;
								WAITING <= 0;
							ELSE
								WAITING <= WAITING + 1;
							END IF;							
						ELSE
							ERRORinput <= '1';
						END IF;		

					ELSIF COUNTER = 33 then
						IF RECEIVE = '0' THEN
							-- MODE TRANSLATION
							case RECEIVE_DATA is
							when "00110000" =>
								BILANGAN4internalA <= "00000000"; -- 0
								COUNTER <= 34;
							when "00110001" =>
								BILANGAN4internalA <= "00000001"; -- 1
								COUNTER <= 34;
							when "00110010" =>
								BILANGAN4internalA <= "00000010"; -- 2
								COUNTER <= 34;
							when "00110011" =>
								BILANGAN4internalA <= "00000011"; -- 3
								COUNTER <= 34;
							when "00110100" =>
								BILANGAN4internalA <= "00000100"; -- 4
								COUNTER <= 34;
							when "00110101" =>
								BILANGAN4internalA <= "00000101"; -- 5
								COUNTER <= 34;
							when "00110110" =>
								BILANGAN4internalA <= "00000110"; -- 6
								COUNTER <= 34;
							when "00110111" =>
								BILANGAN4internalA <= "00000111"; -- 7
								COUNTER <= 34;
							when "00111000" =>
								BILANGAN4internalA <= "00001000"; -- 8
								COUNTER <= 34;
							when "00111001" =>
								BILANGAN4internalA <= "00001001"; -- 9
								COUNTER <= 34;
							when others =>
								-- Penanganan Error
								ERRORinput <= '1';
							
							END CASE;
						END IF;
					ELSIF COUNTER = 34 then
						IF WAITING < MAX_WAIT THEN
							IF RECEIVE = '1' THEN
								COUNTER <= 35;
								WAITING <= 0;
							ELSE
								WAITING <= WAITING + 1;
							END IF;							
						ELSE
							ERRORinput <= '1';
						END IF;
					ELSIF COUNTER = 35 then
						IF RECEIVE = '0' THEN
							-- MODE TRANSLATION
							case RECEIVE_DATA is
							when "00110000" =>
								BILANGAN4internalB <= "00000000"; -- 0
								COUNTER <= 36;
							when "00110001" =>
								BILANGAN4internalB <= "00000001"; -- 1
								COUNTER <= 36;
							when "00110010" =>
								BILANGAN4internalB <= "00000010"; -- 2
								COUNTER <= 36;
							when "00110011" =>
								BILANGAN4internalB <= "00000011"; -- 3
								COUNTER <= 36;
							when "00110100" =>
								BILANGAN4internalB <= "00000100"; -- 4
								COUNTER <= 36;
							when "00110101" =>
								BILANGAN4internalB <= "00000101"; -- 5
								COUNTER <= 36;
							when "00110110" =>
								BILANGAN4internalB <= "00000110"; -- 6
								COUNTER <= 36;
							when "00110111" =>
								BILANGAN4internalB <= "00000111"; -- 7
								COUNTER <= 36;
							when "00111000" =>
								BILANGAN4internalB <= "00001000"; -- 8
								COUNTER <= 36;
							when "00111001" =>
								BILANGAN4internalB <= "00001001"; -- 9
								COUNTER <= 36;
							when others =>
								-- Penanganan Error
								ERRORinput <= '1';
							
							END CASE;
						END IF;
					ELSIF COUNTER = 36 then
						IF WAITING < MAX_WAIT THEN
							IF RECEIVE = '1' THEN
								COUNTER <= 37;
								WAITING <= 0;
							ELSE
								WAITING <= WAITING + 1;
							END IF;							
						ELSE
							ERRORinput <= '1';
						END IF;
					ELSIF COUNTER = 37 then
						IF RECEIVE = '0' THEN
							-- MODE TRANSLATION
							case RECEIVE_DATA is
							when "00110000" =>
								BILANGAN4internalC <= "00000000"; -- 0
								COUNTER <= 38;
							when "00110001" =>
								BILANGAN4internalC <= "00000001"; -- 1
								COUNTER <= 38;
							when "00110010" =>
								BILANGAN4internalC <= "00000010"; -- 2
								COUNTER <= 38;
							when "00110011" =>
								BILANGAN4internalC <= "00000011"; -- 3
								COUNTER <= 38;
							when "00110100" =>
								BILANGAN4internalC <= "00000100"; -- 4
								COUNTER <= 38;
							when "00110101" =>
								BILANGAN4internalC <= "00000101"; -- 5
								COUNTER <= 38;
							when "00110110" =>
								BILANGAN4internalC <= "00000110"; -- 6
								COUNTER <= 38;
							when "00110111" =>
								BILANGAN4internalC <= "00000111"; -- 7
								COUNTER <= 38;
							when "00111000" =>
								BILANGAN4internalC <= "00001000"; -- 8
								COUNTER <= 38;
							when "00111001" =>
								BILANGAN4internalC <= "00001001"; -- 9
								COUNTER <= 38;
							when others =>
								-- Penanganan Error
								ERRORinput <= '1';
							
							END CASE;
						END IF;
					ELSIF COUNTER = 38 then
						-- PENGONVERSIAN BILANGAN

						BILANGAN1temp <= UNSIGNED(UNSIGNED(BILANGAN1internalA) * 100 + UNSIGNED(BILANGAN1internalB) * 10 + UNSIGNED(BILANGAN1internalC))(7 downto 0);
						BILANGAN2temp <= UNSIGNED(UNSIGNED(BILANGAN2internalA) * 100 + UNSIGNED(BILANGAN2internalB) * 10 + UNSIGNED(BILANGAN2internalC))(7 downto 0);
						if JUMLAHtemp = "10" OR JUMLAHtemp = "11" then
							BILANGAN3temp <= UNSIGNED(UNSIGNED(BILANGAN3internalA) * 100 + UNSIGNED(BILANGAN3internalB) * 10 + UNSIGNED(BILANGAN3internalC))(7 downto 0);
							IF JUMLAHtemp = "11" then
								BILANGAN4temp <= UNSIGNED(UNSIGNED(BILANGAN4internalA) * 100 + UNSIGNED(BILANGAN4internalB) * 10 + UNSIGNED(BILANGAN4internalC))(7 downto 0);
							END IF;
						END IF;

						COUNTER <= 39;
					
					ELSIF COUNTER = 39 then
						DONE <= '1';
						COUNTER <= 0;
					END IF;

				ELSE 
					-- PENANGANAN ERROR
					COUNTER <= 0;
					DONE <= '1';
					ERRORinput <= '0';
				END IF;
			END IF;
		END IF;
    END PROCESS;
    
    MODE <= STD_LOGIC_VECTOR(MODEtemp) (1 downto 0);
    JUMLAH <= STD_LOGIC_VECTOR(JUMLAHtemp) (1 downto 0);
    ERROR <= ERRORinput;

	BILANGAN1 <= BILANGAN1temp;
	BILANGAN2 <= BILANGAN2temp;
	BILANGAN3 <= BILANGAN3temp;
	BILANGAN4 <= BILANGAN4temp;
	
	-- DEBUGGING PORT
		COUNTERP <= COUNTER;
		WAITINGP <= WAITING;
		RECEIVE_FEEDBACK <= RECEIVE;
		
        BILANGAN1internalAP <= BILANGAN1internalA;  
		BILANGAN1internalBP <= BILANGAN1internalB;  
		BILANGAN1internalCP <= BILANGAN1internalC;  
		
		BILANGAN2internalAP <= BILANGAN2internalA;  
		BILANGAN2internalBP <= BILANGAN2internalB;  
		BILANGAN2internalCP <= BILANGAN2internalC;  
		
		BILANGAN3internalAP <= BILANGAN3internalA; 
		BILANGAN3internalBP <= BILANGAN3internalB; 
		BILANGAN3internalCP <= BILANGAN3internalC; 
		
		BILANGAN4internalAP <= BILANGAN4internalA; 
		BILANGAN4internalBP <= BILANGAN4internalB; 
		BILANGAN4internalCP <= BILANGAN4internalC;
    
end ArsitekturReceiver;
