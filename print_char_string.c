// PrintChar(ch)::
//  do
//    st = read JTAGUART status register
//    st = st AND 0xFFFF0000 # we care about the top 16 bits. if there are no spots, we can't send a character
//  while (st is zero) # keep waiting until buffer clears 1 or more spots so there is a space to print a character (is there space?)
//    write ch to JTAGUART data register

#define JTAG_UART_DATA(volatile unsigned int *) 0x10001000 // forces the compiler to always read from the location of interest
#define JTAG_UART_STATUS(volatile unsigned int *) 0x10001004

void PrintChar(unsigned int ch)
{
  unsigned int st; // define local variable
  
  do
  {
    st = *JTAG_UART_STATUS; // pointer dereference
    st = st & 0xFFFF0000; // masking operation to isolate the upper 16 bits
  } while(st == 0);
  
  *JTAG_UART_DATA = ch;
}

void PrintString(char *s) // pointed to beginning of the string (just a pointer)
{
  char ch;
  
  while(1)
  {
    ch = *s
    if(ch == '\0') // ASCII null character
       break;
    else
    {
      PrintChar((unsigned in)ch);
      s++; // also the same as move forward by 4 bytes (since it's a char)
    }
  }  
}
