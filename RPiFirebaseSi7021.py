
"""
Tutorial: Send Data to Firebase Using Raspberry Pi
Hardware:
- Raspberry Pi Zero Model W
- Si7021
References:
- https://circuitpython.readthedocs.io/projects/si7021/en/latest/
- https://github.com/thisbejim/Pyrebase
"""

import time
import board
import busio as io
import adafruit_si7021
import pyrebase

i2c = io.I2C(board.SCL, board.SDA, frequency=100000)
sensor = adafruit_si7021.SI7021(i2c)

config = {
  "apiKey": "QH7cC5mb1VOWUAvbwyReQqePL89yHMXoO7Qxiym2",
  "authDomain": "rpi-si7021-2.firebaseapp.com",
  "databaseURL": "https://rpi-si7021-2-default-rtdb.firebaseio.com",
  "storageBucket": "rpi-si7021-2.appspot.com"
}

firebase = pyrebase.initialize_app(config)
db = firebase.database()

print("Send Data to Firebase Using Raspberry Pi")
print("----------------------------------------")
print()

while True:
  TempString = "{:.2f}".format(sensor.temperature)
  HumidityString = "{:.2f}".format(sensor.relative_humidity)

  TempCelsius = float(TempString)
  Humidity = float(HumidityString)

  print("Ambient Temp: {} °C".format(TempString))
  print("Humidity: {}".format(HumidityString))
  print()

  data = {
    "temp": TempCelsius,
    "humidity": Humidity,
  }
  db.child("si7021").child("1-set").set(data)
  db.child("si7021").child("2-push").push(data)

  time.sleep(2)