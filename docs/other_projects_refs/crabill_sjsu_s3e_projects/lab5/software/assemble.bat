kcpsm3 software.psm
copy software.v ..\software.v

if exist .\hex2svf.cnf goto one
  echo "You must first set-up the JTAG chain."
  pause
  .\hex2svfsetup.exe
  echo "JTAG chain set-up completed."
  pause
:one

hex2svf software.hex software.svf
svf2xsvf -d -i software.svf -o software.xsvf
pause