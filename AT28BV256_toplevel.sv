//toplevel for emulated eeprom project
//maps data address and control signal from eeprom emulated into hardware pin
//targetting AT28BV256
//cmd to test reading "minipro -p AT28BV256 -r ./a.bin"
/*28-Lead PDIP/SOIC pinout
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

------
GPIO pin number directly correspond to IC pin, do NOT connected VCC pin
*/   
/* total 26 digital IO needed 3.3v logic level : can connect directly to Terasic DE10-Lite
   A0~A14 address input
   IO0~IO7 8 bit parallel data out
   /CE chip enale input active low
   /OE output enable input active low
   /WE write enable active low
  
   VCC power supply 3.3v 
   VSS ground 0v
*/ 

/* -------- optional extra features ---------
   software erase routine
      The entire device can be erased at one
      time by using a 6-byte software code.
      The software chip erase code consists of
      6- byte load commands to specific
      address locations with specific data pat-
      terns. Once the code has been entered,
      the device will set each byte to the high
      state (FFH). After the software chip
      erase has been initiated, the device will
      internally time the erase operation so
      that no external clocks are required. The
      maximum time required to erase the
      whole chip is t_EC (20 ms). The software
      data protection is still enabled even after
      the software chip erase is performed.
         * load 0xAA to address 0x5555
         * load 0x55 to address 0x2AAA
         * load 0x80 to address 0x5555
         * load 0xAA to address 0x5555
         * load 0x55 to address 0x2AAA
         * load 0x10 to address 0x5555
   support programming/writing
   software WP 
*/
module AT28BV256_toplevel (input logic [14:0]ADDR, 
                        input logic CE, OE, WE, 
								input logic SW[9:0], 
                        output logic [7:0] IO, 
								output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
    logic [7:0] chardata, data, memdata; 
	 logic [3:0] erasecounter; 
	 HexDriver addrhexdisp3 (ADDR[14:12], HEX3);
	 HexDriver addrhexdisp2 (ADDR[11:8], HEX2);
	 HexDriver addrhexdisp1 (ADDR[7:4], HEX1);
	 HexDriver addrhexdisp0 (ADDR[3:0], HEX0);
	 
	 HexDriver datahexdisp0 (IO[7:4], HEX4);
	 HexDriver datahexdisp1 (IO[3:0], HEX5);
    font_rom rom1(.addr(ADDR[10:0]), .data(chardata));     //use the character rom from text vga MP to test for cp1 
	 //memory_contents rom0(.addr(ADDR[10:0]), .data(data));     
	 assign data = 8'hff; 
	 always_comb begin : data_selection
		if(SW[0]) memdata <= chardata; 
		else memdata <= data; 
	 end
    always_comb begin : dataout
		if(OE | CE) IO <= 8'bzzzzzzzz; //activelow chip enable output enable
		else if(ADDR[14:11] & SW[0]) IO <= {ADDR[7:0]}; // test data for beyond font rom address
		else IO <= memdata; 
		//if(!WE & OE & !CE) //begin //write
//		if(erasecounter == 3'h6) begin
//			
//		end
    end
	 
   //  always_comb begin : datain
   //    if(!WE & OE & !CE)
   //  end
endmodule