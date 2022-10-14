
#include <genpat.h>
#include <stdio.h>


char* tostr ( long l )
{
  char* s = (char*)mbkalloc( 32*sizeof(char) );
  snprintf( s, 32, "%ld", l );
  return s;
}


char* tohexa ( unsigned long l, int bits )
{
  static char  buffer[64];
  int   bytes = bits/4;
  char* s     = (char*)mbkalloc( (bytes+3)*sizeof(char) );
  snprintf( buffer, 64, "%0x", l );
//fprintf( stderr, "tohexa() -> \"%s\"\n", buffer );
  s[0] = '0';
  s[1] = 'x';
  s[bytes+2] = (char)0;
  for ( int byte=0 ; byte<bytes ; ++byte ) {
    s[ bytes+1-byte ] = buffer[ bytes-1-byte ];
  }
//fprintf( stderr, "tohexa(%d,%d %d) -> \"%s\"\n", l, bits, bytes, s );
  return s;
}


char* tobit ( char b )
{
  static char s[4] = "0bX"; s[2] = b; return s;
}


int  main ( int argc, char* argv[] )
{
/* Gate delays, in ps. Taken from the generic SxLib (.vbe) */
  long  inv_x1  =  700;
  long  na2_x1  =  900;
  long  na3_x1  = 1000;
  long  no2_x1  =  900;
  long  no3_x1  = 1000;
  long  o4_x2   = 1200;
  long  sff1_x4 = 1700;
  
  char* s = (char*)mbkalloc( 1024*sizeof(char) );
  
  DEF_GENPAT( "eth_spram_256x32" );
  SETTUNIT  ( "ns" );

  DECLAR( "clk" , ":1", "B", IN    , ""           , "" );
  DECLAR( "ce"  , ":0", "B", IN    , ""           , "" );
  DECLAR( "oe"  , ":0", "B", IN    , ""           , "" );
  DECLAR( "rst" , ":1", "B", IN    , ""           , "" );
  DECLAR( "we"  , ":1", "X", IN    ,  "3 downto 0", "" );
  DECLAR( "addr", ":1", "X", IN    ,  "7 downto 0", "" );
  DECLAR( "di"  , ":1", "X", IN    , "31 downto 0", "" );
  DECLAR( "dato", ":1", "X", OUT   , "31 downto 0", "" );
  DECLAR( "vdd" , ":0", "B", IN    , ""           , "" );
  DECLAR( "vss" , ":1", "B", IN    , ""           , "" );

  /* DECLAR( "imux_addr0000_b_q"  , ":0", "X", SIGNAL, "31 downto 0", "" ); */
  /* DECLAR( "imux_addr0000_b0_q" , ":1", "B", SIGNAL, "", "" ); */
  /* DECLAR( "decod_addr0001_we"  , ":1", "B", SIGNAL, "3 downto 0", "" ); */
  /* DECLAR( "bit_addr0001_b_q"   , ":1", "X", SIGNAL, "31 downto 0", "" ); */
  /* DECLAR( "omux_0_to_3_b_q"    , ":1", "X", SIGNAL, "31 donwto 0", "" ); */
  /* DECLAR( "omux_0_to_255_b_q"  , ":1", "X", SIGNAL, "31 donwto 0", "" ); */

  AFFECT( tostr(0), "ce"  , "0b1" );
  AFFECT( tostr(0), "oe"  , "0b1" );
  AFFECT( tostr(0), "rst" , "0b0" );
  AFFECT( tostr(0), "we"  , "0b1" );
  AFFECT( tostr(0), "vdd" , "0b1" );
  AFFECT( tostr(0), "vss" , "0b0" );
  AFFECT( tostr(0), "we"  , "0b1111");
  AFFECT( tostr(0), "di"  , tohexa( 0, 32 ));
  AFFECT( tostr(0), "addr", tohexa( 0, 8 ));

  for ( unsigned long addr=0 ; addr<256 ; ++addr ) {
    AFFECT( tostr(addr*30     ), "clk" , "0b0" );
    if (addr == 0)
      LABEL( "writeAllRegisters" );
    AFFECT( tostr(addr*30 + 10), "clk" , "0b1" );
    AFFECT( tostr(addr*30 + 20), "clk" , "0b0" );
    AFFECT( tostr(addr*30     ), "addr", tohexa( addr  ,  8 ));
    AFFECT( tostr(addr*30     ), "di"  , tohexa( addr+1, 32 ));
    AFFECT( tostr(addr*30 + 10), "dato", tohexa( addr+1, 32 ));
  }

  unsigned long start = 256*30;
  for ( unsigned long bit=0 ; bit<32 ; ++bit ) {
    AFFECT( tostr(start + bit*30     ), "clk" , "0b0" );
    if (bit == 0)
      LABEL( "writeAllValuesZero" );
    AFFECT( tostr(start + bit*30 + 10), "clk" , "0b1" );
    AFFECT( tostr(start + bit*30 + 20), "clk" , "0b0" );
    AFFECT( tostr(start + bit*30     ), "addr", tohexa(  0      ,  8 ));
    AFFECT( tostr(start + bit*30     ), "di"  , tohexa( (1<<bit), 32 ));
    AFFECT( tostr(start + bit*30 + 10), "dato", tohexa( (1<<bit), 32 ));
  }

  start = (256 + 32)*30;
  AFFECT( tostr(start), "rst" , "0b1" );
  AFFECT( tostr(start), "dato", tohexa(0, 32 ));
  for ( unsigned long addr=0 ; addr<16 ; ++addr ) {
    AFFECT( tostr(start + addr*30), "clk" , "0b0" );
    if (addr == 0)
      LABEL( "readWithReset" );
    AFFECT( tostr(start + addr*30 + 10), "clk" , "0b1" );
    AFFECT( tostr(start + addr*30 + 20), "clk" , "0b0" );
    AFFECT( tostr(start + addr*30     ), "addr", tohexa( addr  ,  8 ));
    AFFECT( tostr(start + addr*30     ), "di"  , tohexa( addr+1, 32 ));
  }

  SAV_GENPAT();
  
  return 0;
}
