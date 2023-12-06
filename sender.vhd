library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use work.all;

entity sender is
  port(
  -- input
    GCD_1 : in std_logic_vector(7 downto 0);
    GCD_2 : in std_logic_vector(7 downto 0);
    GCD_3 : in std_logic_vector(7 downto 0);
    LCM_1 : in std_logic_vector(7 downto 0);
    LCM_2 : in std_logic_vector(7 downto 0);
    LCM_3 : in std_logic_vector(7 downto 0);
    LCM_4 : in std_logic_vector(7 downto 0);
    LCM_5 : in std_logic_vector(7 downto 0);
    LCM_6 : in std_logic_vector(7 downto 0);
    LCM_7 : in std_logic_vector(7 downto 0);
    LCM_8 : in std_logic_vector(7 downto 0);
    LCM_9 : in std_logic_vector(7 downto 0);
    LCM_10 : in std_logic_vector(7 downto 0);



    -- DEBUGGING
    --STATEDB : OUT std_logic_vector(31 DOWNTO 0);
    DEBUG : out std_logic;

    rst : in std_logic;
    start_send : in std_logic;
    clk : in std_logic;
    tx_en : in std_logic;
    send : out std_logic;
    MODE : in std_logic_vector (1 downto 0);
    data_send : out std_logic_vector(7 downto 0)
  );
End entity;

architecture sender_arc of sender is
  signal state : INTEGER := 0;
  signal FIRSTDELAY : INTEGER := 0;
  signal SEND_SIGNAL : std_logic := 'Z';
  signal SEND_DATA : std_logic_vector(7 downto 0);

  signal testData : std_logic_vector(7 downto 0) := "00110011";
begin

 
 
  -- FSM PROCESS
  process(clk)
    begin
    if rising_edge (clk) then
      if rst = '0' then
        state <= 0;
        SEND_SIGNAL <= '0';
        FIRSTDELAY <= 0;
      else
        case state is
          when 0 =>
            if start_send = '1' then
              if MODE = "01" OR MODE = "11" then
                -- state <= state + 1;
                state <= -4;
              else
                state <= 17;
              end if;
            else
              STATE <= 0;
            end if;
            SEND_SIGNAL <= '0';

          -- starting
          when -4 =>
              SEND_DATA <= "00111101";
              SEND_SIGNAL <= '1';
              state <= state + 1;
          when -3 =>
              SEND_SIGNAL <= '1';
              state <= state + 1;
          when -2 =>
              if tx_en = '1' then
                SEND_SIGNAL <= '0';
                state <= state + 1;
              end if;
          when -1 =>
            if tx_en = '0' then
              -- state <= state + 1;
              state <= 1;
            end if;

          -- GCD1
          when 1 =>
              SEND_DATA <= GCD_1;
              SEND_SIGNAL <= '1';
              state <= state + 1;
          when 2 =>
              SEND_SIGNAL <= '1';
              state <= state + 1;
          when 3 =>
              if tx_en = '1' then
                SEND_SIGNAL <= '0';
                state <= state + 1;
              end if;
          when 4 =>
            if tx_en = '0' then
              state <= state + 1;
            end if;
          -- GCD2
          when 5 =>
              SEND_DATA <= GCD_2;
              state <= state + 1;
          when 6 =>
              SEND_SIGNAL <= '1';
              state <= state + 1;
          when 7 =>
              if tx_en = '1' then
                SEND_SIGNAL <= '0';
                state <= state + 1;
              end if;
          when 8 =>
            if tx_en = '0' then
              state <= state + 1;
            end if;
          --GCD3
          when 9 =>
              SEND_DATA <= GCD_3;
              state <= state + 1;
          when 10 =>
              SEND_SIGNAL <= '1';
              state <= state + 1;
          when 11 =>
              if tx_en = '1' then
                SEND_SIGNAL <= '0';
                state <= state + 1;
              end if;
          when 12 =>
            if tx_en = '0' then
              if MODE = "10" OR MODE = "11" then
                state <= state + 1;
              else
                state <= 57;
              end if;
            end if;
          --SPACE
          when 13 =>
              SEND_DATA <= "00100000";
              state <= state + 1;
          when 14 =>
              SEND_SIGNAL <= '1';
              state <= state + 1;
          when 15 =>
              if tx_en = '1' then
                SEND_SIGNAL <= '0';
                state <= state + 1;
              end if;
          when 16 =>
            if tx_en = '0' then
              state <= state + 1;
            end if;
          --LCM1
          when 17 =>
              SEND_DATA <= LCM_1;
              state <= state + 1;
          when 18 =>
              SEND_SIGNAL <= '1';
              state <= state + 1;
          when 19 =>
              if tx_en = '1' then
                SEND_SIGNAL <= '0';
                state <= state + 1;
              end if;
          when 20 =>
            if tx_en = '0' then
              state <= state + 1;
            end if;
          --LCM2
          when 21 =>
              SEND_DATA <= LCM_2;
              state <= state + 1;
          when 22 =>
              SEND_SIGNAL <= '1';
              state <= state + 1;
          when 23 =>
              if tx_en = '1' then
                SEND_SIGNAL <= '0';
                state <= state + 1;
              end if;
          when 24 =>
            if tx_en = '0' then
              state <= state + 1;
            end if;
          --LCM3
          when 25 =>
              SEND_DATA <= LCM_3;
              state <= state + 1;
          when 26 =>
              SEND_SIGNAL <= '1';
              state <= state + 1;
          when 27 =>
              if tx_en = '1' then
                SEND_SIGNAL <= '0';
                state <= state + 1;
              end if;
          when 28 =>
            if tx_en = '0' then
              state <= state + 1;
            end if;
          --LCM4
          when 29 =>
              SEND_DATA <= LCM_4;
              state <= state + 1;
          when 30 =>
              SEND_SIGNAL <= '1';
              state <= state + 1;
          when 31 =>
              if tx_en = '1' then
                SEND_SIGNAL <= '0';
                state <= state + 1;
              end if;
          when 32 =>
            if tx_en = '0' then
              state <= state + 1;
            end if;
          --LCM5
          when 33 =>
              SEND_DATA <= LCM_5;
              state <= state + 1;
          when 34 =>
              SEND_SIGNAL <= '1';
              state <= state + 1;
          when 35 =>
              if tx_en = '1' then
                SEND_SIGNAL <= '0';
                state <= state + 1;
              end if;
          when 36 =>
            if tx_en = '0' then
              state <= state + 1;
            end if;
          --LCM6
          when 37 =>
              SEND_DATA <= LCM_6;
              state <= state + 1;
          when 38 =>
              SEND_SIGNAL <= '1';
              state <= state + 1;
          when 39 =>
              if tx_en = '1' then
                SEND_SIGNAL <= '0';
                state <= state + 1;
              end if;
          when 40 =>
            if tx_en = '0' then
              state <= state + 1;
            end if;
          --LCM7
          when 41 =>
              SEND_DATA <= LCM_7;
              state <= state + 1;
          when 42 =>
              SEND_SIGNAL <= '1';
              state <= state + 1;
          when 43 =>
              if tx_en = '1' then
                SEND_SIGNAL <= '0';
                state <= state + 1;
              end if;
          when 44 =>
            if tx_en = '0' then
              state <= state + 1;
            end if;
          --LCM8
          when 45 =>
              SEND_DATA <= LCM_8;
              state <= state + 1;
          when 46 =>
              SEND_SIGNAL <= '1';
              state <= state + 1;
          when 47 =>
              if tx_en = '1' then
                SEND_SIGNAL <= '0';
                state <= state + 1;
              end if;
          when 48 =>
            if tx_en = '0' then
              state <= state + 1;
            end if;
          --LCM9
          when 49 =>
              SEND_DATA <= LCM_9;
              state <= state + 1;
          when 50 =>
              SEND_SIGNAL <= '1';
              state <= state + 1;
          when 51 =>
              if tx_en = '1' then
                SEND_SIGNAL <= '0';
                state <= state + 1;
              end if;
          when 52 =>
            if tx_en = '0' then
              state <= state + 1;
            end if;
          --LCM10
          when 53 =>
              SEND_DATA <= LCM_10;
              state <= state + 1;
          when 54 =>
              SEND_SIGNAL <= '1';
              state <= state + 1;
          when 56 =>
              if tx_en = '1' then
                SEND_SIGNAL <= '0';
                state <= state + 1;
              end if;
          WHEN 57 =>
            state <= 0;
            
          when others =>
            state <= 0;
        end case;
      end if;
    end if;
  end process;

  process(GCD_1)
  begin
    if GCD_1 = "00110001" then
      DEBUG <= '0';
    else
      DEBUG <= '1';
    end if;
  end process;

  send <= NOT SEND_SIGNAL;
  data_send <= SEND_DATA;
  -- STATEDB <= std_logic_vector(to_unsigned(state, STATEDB'length));


end sender_arc;