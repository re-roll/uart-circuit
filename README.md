# UART_RX

## Final version: April 2023

### Description

Circuit for receiving data words after asynchronous serial lin

### Architecture of the designed circuit at the RTL level

> **_NOTE:_**  There are no CLK and RST inputs at scheme

![Scheme picture](/assets/uart.png)

### Finite State Machine

Legend:
+ States: IDLE, WAIT_FISRT, DATA, STOP
+ Inputs: DIN, CNT [4:0], CNT [3:0]
+ Outputs (Moore): DOUT_VLD, CNT_CE, DATA_CE

![Scheme picture](/assets/fsm.png)