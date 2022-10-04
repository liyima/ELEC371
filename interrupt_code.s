# assume in memory, FLAG, DATA_FROM_PORT (for 16 bits use movi, and for 32 bits use movia)

# interrupt code
check_for_input_port_interrupt:

  andi  r3, r2, Ox2000 # assume ipending value is previously read into r2, bit 13 from last question
  beq   r3, r0, next

handle_input_port:

  ldwio r3, INPORT_DATA(r0)
  stw   r3, DATA_FROM_PORT(r0)
  movi  r3, 1
  stw   r3, FLAG(r0) # enable interrupt

next:

# main code -> checks for software flags at various times
# at some point within the infinite loop
flag_if:
  ldw   r5, FLAG(r0)
  beq   r5, r0, flag_if_end
  
flag_then: # the flag is 1 therefore there is some sort of enable interrupt
  ldw   r5, DATA_FROM_PORT(r0)
  stw   r5, DATA_FROM_COMPUTATION(r0)
  stw   r0, FLAG(r0) # clear the flag, doesn't allow inputs from the same ports or external ports to come in, like a wait signal
  # computation code
  # ...
  
flag_if_end:
