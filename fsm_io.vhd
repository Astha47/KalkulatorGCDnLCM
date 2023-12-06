library ieee;
use ieee.std_logic_1164.all;

entity fsm_io is
  port (
    Clk : in std_logic;
    Rst : in std_logic;
    Done_Receiver : in std_logic;
    Receive_Error : in std_logic;
    Done_ConverttoASCII : in std_logic;
    Done_Process : in std_logic;
    Start_Process : out std_logic;
    Start_Convert : out std_logic;
    READY : out std_logic;
    PROCESSING : out std_logic;
    Start_Send : out std_logic
  );
end entity fsm_io;

architecture behav of fsm_io is
  -- deklarasikan tipe data untuk state
  type t_state is (S0, S1, S2, S3, S3b, S4, S5, S6); -- contoh enumerasi
  -- deklarasikan sinyal untuk menyimpan state saat ini
  signal state : t_state;
  -- deklarasikan konstanta untuk durasi Start_Send
  constant send_duration : natural := 1; -- contoh 10 clock cycle
  -- deklarasikan sinyal untuk menghitung durasi Start_Send
  signal send_counter : natural range 0 to send_duration;
  -- signal start process counter
  signal start_process_count : integer;
  signal sender_delay_count : integer := 0;

  SIGNAL READYINT : STD_LOGIC := '0';
  SIGNAL PROCESSINGINT : STD_LOGIC := '1';

begin
  -- buat proses yang mengandung FSM
  process (Clk) is
  begin
    if rising_edge (Clk) then
      if Rst = '0' then
        state <= S0; -- state awal
        Start_Process <= '0';
        Start_Convert <= '0';
        Start_Send <= '0';
        send_counter <= 0;
        READYINT <= '0';
        PROCESSINGINT <= '1';

      else
        case state is
          when S0 => -- state standby

            -- semua output bernilai 0
            READYINT <= '0';
            PROCESSINGINT <= '1';
            Start_Process <= '0';
            Start_Convert <= '0';
            Start_Send <= '0';
            send_counter <= 0;
            if Done_Receiver = '0' then -- kondisi untuk berpindah state
              state <= S1; -- state berikutnya
            end if;
          when S1 => -- state menunggu Done_Receiver naik
            -- semua output bernilai 0
            Start_Process <= '0';
            Start_Convert <= '0';
            Start_Send <= '0';
            send_counter <= 0;
            if Receive_Error = '1' then -- kondisi untuk kembali ke state awal
              state <= S0;
            elsif Done_Receiver = '1' then -- kondisi untuk berpindah state
              state <= S2; -- state berikutnya
            end if;
          when S2 => -- state menyalakan Start_Process
            -- Start_Process bernilai 1, output lainnya 0
            READYINT <= '1';

            Start_Process <= '1';
            Start_Convert <= '0';
            Start_Send <= '0';
            send_counter <= 0;
            if Done_Process = '0' then -- kondisi untuk berpindah state
              state <= S3; -- state berikutnya
            end if;
          when S3 => -- state menunggu Done_Process naik
            -- Start_Process bernilai 1, output lainnya 0
            PROCESSINGINT <= '0';

            Start_Process <= '0';
            Start_Convert <= '0';
            Start_Send <= '0';
            send_counter <= 0;
            if Done_Process = '1' then -- kondisi untuk berpindah state
              start_process_count <= 0;
              state <= S3b; -- state berikutnya
            end if;
          when S3b => -- mengirim selama 5 clock
              start_process_count <= start_process_count + 1;
              if start_process_count = 5 then
                  start_process_count <= 0;
                  state <= S4;
              end if;
          when S4 => -- state menyalakan Start_Convert
            -- Start_Convert bernilai 1, output lainnya 0
            Start_Process <= '0';
            Start_Convert <= '1';
            Start_Send <= '0';
            send_counter <= 0;
            if Done_ConverttoASCII = '0' then -- kondisi untuk berpindah state
              state <= S5; -- state berikutnya
            end if;
          when S5 => -- state menunggu Done_ConverttoASCII naik
            -- Start_Convert bernilai 1, output lainnya 0

            READYINT <= '1';
            PROCESSINGINT <= '1';
            Start_Process <= '0';
            Start_Convert <= '1';
            Start_Send <= '0';
            send_counter <= 0;
            if Done_ConverttoASCII = '1' then -- kondisi untuk berpindah state
              state <= S6; -- state berikutnya
              -- Start_Send <= '1'; -- menyalakan Start_Send
              -- send_counter <= send_duration; -- mengatur durasi Start_Send
            end if;
          
            when S6 =>
                if sender_delay_count >= 0 then
                  state <= S0; -- state berikutnya
                  Start_Send <= '1'; -- menyalakan Start_Send
                  send_counter <= send_duration; -- mengatur durasi Start_Send
                else
                  sender_delay_count <= sender_delay_count + 1;
                  end if;

        end case;
        -- buat proses untuk mengatur durasi Start_Send
        if send_counter > 0 then
          send_counter <= send_counter - 1;
          if send_counter = 0 then
            Start_Send <= '0'; -- mematikan Start_Send
          end if;
        end if;
      end if;
    end if;
  end process;

  READY <= READYINT;
  PROCESSING <= PROCESSINGINT;
end architecture behav;
