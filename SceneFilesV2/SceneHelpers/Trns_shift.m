function M = Trns_shift( u )

M = [
  1 0 0 u(1)
  0 1 0 u(2)
  0 0 1 u(3)
  0 0 0 1 ];

return;