# Batch_Scripting_PIC_Programming_MPLAB-IPEv4.1
Automated programming of PIC MCUs using batch script and MPLAB IDE v4.1 utilities  

## File Descriptions
.bat file provides reference for getting started with scripting the programming of PIC MCUs
.num is a reference for programming a PIC EEPROM. This file was written specifically to write all 256 bytes of the PIC16F1823 EEPROM at once.  

## Usage
1. Navigate to the MPLAB IPE directory on your workstation (ex. C:\Program Files\Microchip\MPLABX\vX.XX\mplab_ipe) using the OS command-line interpreter (Windows = CMD prompt)
2. List the files in this directory and ensure the programming utility for your PIC programmer is listed (ICD3 programming utility uses the 'icd3cmd.exe', PICKit3 uses 'pk3cmd.exe')
3. Program the EEPROM by issuing the following in CMD prompt of by adding it in your script,
*>icd3cmd.exe -p16F1823 -fSwitch.X.production.hex -sSwitch_SQTP_EEPROM_Entire_IMG.num -mc -me -mp
4.From what I've witnessed .hex and .num need to be programmed at the same time in order for the EEPROM memory to be written.
