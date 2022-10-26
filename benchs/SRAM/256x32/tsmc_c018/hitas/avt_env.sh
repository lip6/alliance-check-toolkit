
 guessOs ()
 {
   case "`uname -srm`" in
     Linux*FC2*)        osType="Linux.FC2";             AVERTEC_OS=Linux;;
     Linux*SLA*)        osType="Linux.SLA4x";           AVERTEC_OS=Linux;;
     Linux*EL*i686*)    osType="Linux.SLA4x";           AVERTEC_OS=Linux;;
     Linux*EL*x86_64*)  osType="Linux.SLA4x_64";        AVERTEC_OS=Linux;;
     Linux*2.6.16*FC5*) osType="Linux.SLA4x";           AVERTEC_OS=Linux;;
     Linux*el5*)        osType="Linux.SLSoC5x";         AVERTEC_OS=Linux;;
     Linux*SLSoC5*)     osType="Linux.SLSoC5x";         AVERTEC_OS=Linux;;
     Linux*el5*x86_64)  osType="Linux.SLSoC5x_64";      AVERTEC_OS=Linux;; 
     Linux*el6*x86_64)  osType="Linux.slsoc6x_64";      AVERTEC_OS=Linux;;
     Linux*slsoc6*)     osType="Linux.slsoc6x";         AVERTEC_OS=Linux;;
     Linux*el6*)        osType="Linux.slsoc6x";         AVERTEC_OS=Linux;;
     Linux*el7*)        osType="Linux.el7_64";          AVERTEC_OS=Linux;;
     Linux*i686*)       osType="Linux.i686";            AVERTEC_OS=Linux;;
     SunOS\ 5*)         osType="Solaris";               AVERTEC_OS=Solaris;;
     Darwin*)           osType="Darwin";                AVERTEC_OS=Darwin;;
     *)                 osType="`uname -s`.`uname -r`"; AVERTEC_OS=Linux;;
   esac
 }

 guessSite ()
 {
   case "`hostname`" in
     lepka*|shadock*|goulp*) homeDir="/dsk/l1/tasyag";;
     *)                      homeDir="/users/outil/tasyag";;
   esac
 }

 guessOs
 guessSite

 AVERTEC_TOP=${homeDir}/${osType}/install
 PATH=${AVERTEC_TOP}/bin/tcl:${PATH}
 PATH=${AVERTEC_TOP}/bin:${PATH}

 if [ -z "${MANPATH}" ]; then
   MANPATH=${AVERTEC_TOP}/man
 else
   MANPATH=${AVERTEC_TOP}/man:${MANPATH}
 fi
 
 export PATH MANPATH AVERTEC_TOP
 unset guessOs guessSite osType

