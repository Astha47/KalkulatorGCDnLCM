
# Mengimpor modul serial untuk berkomunikasi dengan port serial
import serial

# Membuat objek serial dengan nama ser
ser = serial.Serial()

# Mengatur port serial yang digunakan, dalam hal ini COM14
ser.port = 'COM14'

# Mengatur baud rate yang digunakan, dalam hal ini 9600
ser.baudrate = 9600

# Membuka port serial
ser.open()

# Membuat loop tak terbatas untuk membaca data dari port serial
while True:
    # Membaca satu byte dari port serial
    data = ser.read(1)

    # Mengubah data dari string menjadi integer
    data_int = int(data, 2)

    # Menampilkan data dalam bentuk biner dengan 8 bit
    print(format(data_int, '08b'))