Version 4
SymbolType BLOCK
LINE Normal -48 -32 -64 -32
LINE Normal -48 0 -64 0
LINE Normal -48 32 -64 32
LINE Normal 64 0 48 0
LINE Normal 64 -32 48 -32
LINE Normal 0 48 0 64
LINE Normal 64 32 48 32
RECTANGLE Normal 48 48 -48 -48
TEXT -27 -3 Left 2 Park
TEXT -44 -32 Left 0 a
TEXT -44 0 Left 0 b
TEXT -44 32 Left 0 c
TEXT 40 0 Left 0 q
TEXT 40 -32 Left 0 d
TEXT -13 40 Left 0 theta
TEXT 40 32 Left 0 0
SYMATTR SpiceModel ParkTrans
SYMATTR ModelFile pwr-ctrl.lib
SYMATTR Prefix X
PIN -64 -32 NONE 8
PINATTR PinName a
PINATTR SpiceOrder 1
PIN -64 0 NONE 8
PINATTR PinName b
PINATTR SpiceOrder 2
PIN -64 32 NONE 8
PINATTR PinName c
PINATTR SpiceOrder 3
PIN 0 64 NONE 8
PINATTR PinName theta
PINATTR SpiceOrder 4
PIN 64 -32 NONE 8
PINATTR PinName d
PINATTR SpiceOrder 5
PIN 64 0 NONE 8
PINATTR PinName q
PINATTR SpiceOrder 6
PIN 64 32 NONE 8
PINATTR PinName zero
PINATTR SpiceOrder 7
