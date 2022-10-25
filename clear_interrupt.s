interrupt_handler:
  subi  sp, sp, 4                                   1 inst.
  stw   r12, 0(sp) # randomly choosing r12          1 inst.
  
  movia r12, TIMER_STATUS                           2 inst.
  stwio r0, 0(r12) # cleared the timmer interrupt   1 inst.
  
  # recover the number that was saved
  ldw   r12, 0(sp)                                  1 inst.
  addi   sp, sp, 4                                  1 inst.
  
  ret # normal subroutine since it's a normal call (not an interrupt), 1 inst.
  
  # 1 + 1 + 2 + 1 + 1 + 1 + 1 = 8 inst.
