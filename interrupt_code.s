# assume in memory, FLAG, DATA_FROM_PORT (for 16 bits use movi, and for 32 bits use movia)

# interrupt code
check_for_input_port_interrupt:

  andi r3, r2, Ox2000 # assume ipending value is previously read into r2
  beq r3, r0

handle_input_port:
  ldwio r3, INPORT_DATA(r0)
  
