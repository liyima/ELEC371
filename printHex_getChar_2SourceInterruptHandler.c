//  PrintHex(n) ::
//    if (n > 9) then
//      PrintChar(n - 10 + 'A') result of this is the proper code value for A, B, C, D...
//    else PrintChar(n + '0')
//    end if

void PrintHex(int n) {
  if (n > 9)
    PrintChar(n - 10 + 'A');
  else
    PrintChar(n + 0);
}

//  GetChar() ::
//    do
//      info = read JTAG UART daa register
//      st = info AND 0x8000
//    while (st is zero)
//      return info AND 0xFF

//  interrupt_handler() for 2 sources
//  HandlePortA(), HandlePortB()
//  retrieve contents of ipending register

void interrupt_handler(void)
{
  unsigned int ipending;
  
  ipending = NIOS_READ_IPENDING(); // macro that may have parameters therefore needs parentheses
  if (ipending & 0x20000) // trying to produce either ALL 0 or non-zero
     HandlePortA();
  if (ipending & ox400)
     HandlePortB();
}

//  initialization of IENABLE
NIOS2_WRITE_IENABLE(0x20000 | 0x400);

