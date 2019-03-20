#!/bin/sh


 case "`uname -sr`" in
   Linux*)
      CDS_ARCH="Linux"
     ;;
   *)
     echo ""
     echo "[EDI1324.sh ERROR]:"
     echo ""
     echo "  Cadence is only avalaible under Scientific Linux 5/6 platform."
     echo "  (you are currently under a `uname -rs` platform)"
     echo ""
     ;;
 esac

 if [ -z "$LM_LICENSE_FILE" ]; then
   LM_LICENSE_FILE="30000@licences.cnfm.fr"
 else
   LM_LICENSE_FILE="30000@licences.cnfm.fr:${LM_LICENSE_FILE}"
 fi

 CDSDIR="/users/soft/opus/${CDS_ARCH}/EDI-13.24.026"
 
 PATH="${CDSDIR}/tools/bin:${PATH}"
 PATH="${CDSDIR}/tools/dfII/bin:${PATH}"
 
 export LM_LICENSE_FILE CDSDIR PATH 
 hash -r
 
 echo "EDI1324.sh: Setting up Cadence Environment for EDI 13.24 (024,OpenAccess)."
