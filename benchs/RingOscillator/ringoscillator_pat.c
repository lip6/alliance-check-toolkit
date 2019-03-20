
#include <genpat.h>
#include <stdio.h>


char* tostr ( long l )
{
  char* s = (char*)mbkalloc( 32*sizeof(char) );
  snprintf( s, 32, "%ld", l );
  return s;
}


char* tobit ( char b )
{
  static char s[4] = "0BX"; s[2] = b; return s;
}


void  affects ( long date, const char* bits )
{
  AFFECT( tostr(date), "en"    , tobit(bits[0]) );
  AFFECT( tostr(date), "sel0_e", tobit(bits[1]) );
  AFFECT( tostr(date), "sel1_e", tobit(bits[2]) );
  AFFECT( tostr(date), "sel2_e", tobit(bits[3]) );
  AFFECT( tostr(date), "vdd"   , "0B1" );
  AFFECT( tostr(date), "vss"   , "0B0" );
}


void  edgeAffects ( long date, const char* beforeBits, const char* afterBits )
{
  if (date > 0) affects( date-1, beforeBits );
  affects( date, afterBits );
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
  
  char* s       = (char*)mbkalloc( 1024*sizeof(char) );
  
  DEF_GENPAT( "ringoscillator" );
  SETTUNIT  ( "ps" );

  DECLAR( "en"                    , ":0", "B", IN      , "", "" );
  DECLAR( "sel0_e"                , ":0", "B", IN      , "", "" );
  DECLAR( "sel1_e"                , ":0", "B", IN      , "", "" );
  DECLAR( "sel2_e"                , ":1", "B", IN      , "", "" );
  DECLAR( "osc_out"               , ":1", "B", OUT     , "", "" );
  DECLAR( "vdd"                   , ":0", "B", IN      , "", "" );
  DECLAR( "vss"                   , ":1", "B", IN      , "", "" );

  DECLAR( "sel0"                  , ":0", "B", SIGNAL  , "", "" );
  DECLAR( "osc_inv_x1_na3"        , ":0", "B", SIGNAL  , "", "" );
  DECLAR( "osc_inv_x1_0"          , ":0", "B", SIGNAL  , "", "" );
  DECLAR( "osc_inv_x1_99"         , ":0", "B", SIGNAL  , "", "" );
  DECLAR( "mux_o4"                , ":1", "B", SIGNAL  , "", "" );

  long  divider = 0;
  for ( ; divider < 14 ; ++divider ) {
  /*
   * snprintf( s, 1024, "divider_sff1_%d_i.sff_m", divider );
   * DECLAR( s, ":0", "B", REGISTER, "", "" );
   */

    snprintf( s, 1024, "divider_sff1_%d", divider );
    DECLAR( s, ":1", "B", SIGNAL  , "", "" );
  }

  long date = 0;
  INIT( tostr(0), "divider_sff1_0_i.sff_m", "0B0" );

  /* Decoder init. */
  affects( date, "0100" );
  date += no3_x1 + na3_x1;            edgeAffects( date, "0100", "0100" ); // decoder delay (not selected).
  date += inv_x1;                     edgeAffects( date, "0100", "0100" ); // first inv_x1 stage.
  date += inv_x1 * 99;                edgeAffects( date, "0100", "1000" ); // last inv_x1 stage + activate inv_x1 ring.
  date += no3_x1 + na3_x1 + inv_x1*2; edgeAffects( date, "1000", "1000" ); // decoder delay (for inv_x1 activate).
  date += inv_x1 * 100;               edgeAffects( date, "1000", "1000" ); // inv_x1 ring first loop.
  date += na2_x1 + o4_x2;             edgeAffects( date, "1000", "1000" ); // multiplexer delay.

  date += 1;
  affects( date, "1000" ); // We need a separating pattern.

  /* DFF divider init. Force the register to '0'. */
  for ( divider=0 ; divider < 14 ; ++divider ) {
    snprintf( s, 1024, "divider_sff1_%d_i.sff_m", divider );
    INIT( tostr(date), s, "0B0" );
    date += sff1_x4; edgeAffects( date, "1000", "1000" ); // DFF delay.
  }
  date -= sff1_x4 * 14;

  long i = 0;
  for ( ; i<32768 ; ++i ) {
    date += inv_x1*100 + na3_x1;
    affects( date, "1000" );
  }

  SAV_GENPAT();
  
  return 0;
}
