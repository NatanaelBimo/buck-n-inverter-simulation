Version 4
SymbolType BLOCK
LINE Normal -64 -32 -96 -32
LINE Normal -64 0 -96 0
LINE Normal -64 32 -96 32
LINE Normal 96 32 64 32
LINE Normal 96 0 64 0
LINE Normal 96 -32 64 -32
LINE Normal 0 64 0 48
RECTANGLE Normal 64 48 -64 -48
TEXT 0 0 Center 2 Clarke
TEXT -59 -32 Left 0 a
TEXT -59 0 Left 0 b
TEXT -59 32 Left 0 c
TEXT 67 -28 Left 0 alpha
TEXT 67 4 Left 0 beta
TEXT 68 36 Left 0 gamma
SYMATTR Prefix X
SYMATTR SpiceModel ClarkeTrans
SYMATTR ModelFile pwr-ctrl.lib
PIN -96 -32 NONE 8
PINATTR PinName INA
PINATTR SpiceOrder 1
PIN -96 0 NONE 8
PINATTR PinName INB
PINATTR SpiceOrder 2
PIN -96 32 NONE 8
PINATTR PinName INC
PINATTR SpiceOrder 3
PIN 96 -32 NONE 8
PINATTR PinName alpha
PINATTR SpiceOrder 4
PIN 96 0 NONE 8
PINATTR PinName beta
PINATTR SpiceOrder 5
PIN 96 32 NONE 8
PINATTR PinName gamma
PINATTR SpiceOrder 6
PIN 0 64 NONE 8
PINATTR PinName N
PINATTR SpiceOrder 7
