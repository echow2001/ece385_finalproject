# ece385_finalproject
final project for ece 385 at UIUC. using altera max10 fpga emulate parallel eeprom 

targetting AT28BV256 3.3v parallel EEPROM. 

cmd to test reading with TL866ii EEPROM reader
``` 
minipro -p AT28BV256 -r ./a.bin" 
```

28-Lead PDIP/SOIC pinout

``` 
     __________
A14 -|1*    28|- VCC
A12 -|2     27|- WE
A7  -|3     26|- A13
A6  -|4     25|- A8
A5  -|5     24|- A9
A4  -|6     23|- A11
A3  -|7     22|- OE
A2  -|8     21|- A10
A1  -|9     20|- CE
A0  -|10    19|- IO7
IO0 -|11    18|- IO6
IO1 -|12    17|- IO5
IO2 -|13    16|- IO4
GND -|14____15|- IO3

```

GPIO pin number directly correspond to IC pin, do NOT connected VCC pin to FPGA 
devboard, host system should not supply power to FPGA, supply power through USB


