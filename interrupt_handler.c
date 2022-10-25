void interrupt_handler(void) {
  unsigned int ipending;
  ipending = NIOS2_READ_IPENDING();
  
  if (ipending & 0x1) { // 1 ampersand for bitwise AND
    *TIMER_STATUS = 0;
  }
}
