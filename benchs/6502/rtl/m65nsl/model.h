/* Address high bits mask */
/* m6502 value 0xff*/
/* m6505 value 0x0f*/
#define HIMASK 0xff
/* Eliminate decimal mode support */
#define NODEC 0b0
/* Eary issue nWT signal (latched nWT will be issued) */
#define EWRITE 0b0
/* Processor RDY input support 0b1 disable the RDY */
// #define RDY 0b1
#define RDY rdy

/* for synthesis set DNOP 0b0, DNOPCALL as null */
#define DNOP dnop
#define DNOPCALL dnop() ;
/*
#define DNOP 0b0
#define DNOPCALL ;
*/

/* if you need compatibility for 65C02 change JUMPWARP to 0b1 */
#define JUMPWRAP 0b0
 
