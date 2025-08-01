import serial
ser = serial.Serial("COM4", 115200)
ser.write(b"231078\n")