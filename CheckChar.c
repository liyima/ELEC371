// main program checks for JTAGUART char and echoes it

unsigned int CheckChar(void) { // no polling loop
  unsigned int info, result;
  info = *JTAG_UART_DATA;
  
  // status is in bit 15
  if (info & 0x8000) { // if this is true, we have a character
    result = info & 0xFF; // get bottom 8 bits
  } else result = 0;
  return result;
}

// timer interrupts every 0.5 seconds
// toggle hex displays but controlled by upper 4 switches

// main::
//   Init()
//     loop
//       MainEcho()
//       MainLEDs()
//     end loop
    
// MainEcho()::
//   ch = CheckChar()
//     if (ch is not zero) then
//       PrintChar(ch)
//     end if
      
// MainLEDs()::
//   pattern = GetSwitches()
//   pattern = pattern AND 0x3F
//   UpdateSixLEDs(pattern)
