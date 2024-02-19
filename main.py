import time
import smbus2
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
from datetime import datetime

ADS1115_ADD = 0x48
CONFIG_REGISTER = 0x01
CONVERSION_REGISTER = 0x00
CONFIGURATION_SETTINGS = 0b1000000010000011
si7021_ADD = 0x40
si7021_READ_TEMPERATURE = 0xF3

cred = credentials.Certificate("firebase-sdk.json")

firebase_admin.initialize_app(cred, {
    "databaseURL": "https://es24-wastemanagement-default-rtdb.firebaseio.com"
})


bus = smbus2.SMBus(1)

cmd_meas_temp = smbus2.i2c_msg.write(si7021_ADD,[si7021_READ_TEMPERATURE])
read_temp = smbus2.i2c_msg.read(si7021_ADD,2)
bus.write_i2c_block_data(ADS1115_ADD, CONFIG_REGISTER, [(CONFIGURATION_SETTINGS >> 8) & 0xFF, CONFIGURATION_SETTINGS & 0xFF])


while True:
    read_dis = bus.read_i2c_block_data(ADS1115_ADD, CONVERSION_REGISTER, 2)
    time.sleep(0.1)
    voltage_reading = (read_dis[0] << 8) | read_dis[1]
    voltage = (voltage_reading * 0.1875 / 1000) -11.702
    distance = ((voltage)*1000/6.4*2.54)
    distancerounded = round(distance,1)
    print('Distance: ',distancerounded)

    time.sleep(1)

    bus.i2c_rdwr(cmd_meas_temp)
    time.sleep(0.1)
    bus.i2c_rdwr(read_temp)
    temperature = int.from_bytes(read_temp.buf[0]+read_temp.buf[1],'big')
    temperature = (temperature*175.72/65536) - 46.85
    temperaturerounded = round(temperature,1)
    print('Temperature: ', temperaturerounded)
    print()
    time.sleep(5)

    ref = db.reference('Raspi')
    raspi_ref = ref.child('03')
    num_current_ref = raspi_ref.child('current')
    num_history_ref = raspi_ref.child('history')
    local_time = datetime.now()

    num_current_ref.update({
      'distance': distancerounded,
      'temperature': temperaturerounded
    })
    num_history_ref.push({
      'distance': distancerounded,
      'temperature': temperaturerounded,
    })