// PrintChar(ch)::
//  do
//    st = read JTAGUART status register
//    st = st AND 0xFFFF0000 # we care about the top 16 bits. if there are no spots, we can't send a character
//  while (st is zero) # keep waiting until buffer clears 1 or more spots so there is a space to print a character (is there space?)
//    write ch to JTAGUART data register

void PrintChar(unsigned int ch)
{
  unsigned int st;
  
  do
  {
    st = *JTAG_UART_STATUS; // pointer dereference
    st = st & 0xFFFF0000; // masking operation to isolate the upper 16 bits
  } while(st == 0);
  
  *JTAG_UART_STATUS = ch;
}
