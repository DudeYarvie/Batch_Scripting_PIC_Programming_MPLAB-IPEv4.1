::The purpose of this program is to provide a reference on how to script the programming of PIC targets using the 
::MPLAB IPE utility v4.1. This script can aid in situations where automated programming of firmware is desired.  
::This script can likely be used with previous or future versions of MPLAB IPE but v4.1 was used to develop
::and test this script.

 @echo off
                                                            :: 30. APR 20018, Jarvis Hill (hilljarvis@gmail.com)
      cd C:\Users\jhill\Desktop\mplab_ipe
                                                            :: Set CMD prompt window and text color
      color 1F
                                                            :: Reset software and programmer. Chose the cmd exe for programmer (PICKit3, ICD3, etc.)
      icd3cmd.exe -h1										
:start
							    :: Clears cmd prompt window
      cls													 
:loop 
							    :: Print statement to screen
      echo Connect Programmer to Target Device...			
:loop 
							    :: Read device ID, to file
      echo ID Device...wait 10 - 15 seconds...				                        
      icd3cmd.exe -p16F15345 -GI >0_DeviceID_out.txt
							    :: End script if erorr occurs
      if errorlevel 1 goto error							
                                                            :: Found 16F15345? output goes nowhere
      find /c "16F15345" 0_DeviceID_out.txt >nul
                                                            
      if errorlevel 1 goto error         
:erase 
      echo Erasing Device...
                                                            :: Erase Device
      icd3cmd.exe -p16F15345 -e >1_EraseDevice.txt
      if errorlevel 1 goto error
	  
:bcheck
	  echo Check if Device is Blank...	
							    :: Blank Check, to file::    
	  icd3cmd.exe -p16F15345 -c >2_BlankCheck_out.txt
      if errorlevel 1 goto error
                                                            :: PIC erased? 
	  find /c "device is blank" 2_BlankCheck_out.txt >nul
      if errorlevel 1 goto erase

:prg
      echo Programming Target...
                                                            :: Program program and eeprom
      icd3cmd.exe -p16F15345 -fPowerRelay.0.9-10-gbb853d5.hex -mpe >3_DeviceProgram.txt
      if errorlevel 1 goto error
            
      echo Verifying Target is Programmed Correctly...
                                                            :: Verify program and eeprom (usage: [programmer utility] -[PIC target] -f[.hex file] -yp >[output_file_name.txt] )
      icd3cmd.exe -p16F15345 -fPowerRelay.0.9-10-gbb853d5.hex -yp >4_ProgramCheck.txt
      if errorlevel 1 goto error  

      echo Writing Configuration...
                                                            :: Program config and verify
      icd3cmd.exe -p16F15345 -fPowerRelay.0.9-10-gbb853d5.hex -mc -yc >5_ProgramConfigVerify.txt
      if errorlevel 1 goto error
      echo Programming Complete and Successful!
      							    ::Jump straight to the end of the script 
      goto end
:tout
                                                            :: Check if target has been removed
      icd3cmd.exe -p16F15345 -GI >7_DeviceID_out2.txt
      if errorlevel 1 goto error
                                                            :: PIC taken out? Output goes nowhere
      find /c "0000" out.txt >nul
                                                            :: If still in, loop
      if errorlevel 1 goto tout
      goto start
      goto end
:nerased
      echo Device already programmed!
      echo Change Device and press a button
      pause >nul
      goto start
:error
      cls
							   ::Set text color to red
      color 0C
      echo A programming error occurred, device was not programmed!!!
      echo Error code : %errorlevel%
      echo.
      echo Press a button to quit.
      pause >nul
:end
      echo Disconnect Device...
      echo Press a button to quit.
      pause >nul
