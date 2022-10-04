# assume in memory, FLAG, DATA_FROM_PORT (16 bits use movi, and 32 bits use movia)

# interrupt code
check_for_input_port_interrupt:
  andi r3, r2, Ox2000 # assume ipending value is previously read into rz
