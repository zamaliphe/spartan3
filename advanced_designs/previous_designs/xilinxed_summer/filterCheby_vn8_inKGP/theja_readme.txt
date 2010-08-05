log by theja, theja@mit.edu

on 2nd June 2009

giving up temporarily.
IMP:connect both citi and systolic through a fifo (xilinx) and run simulations.... like the way we did with samuel.

burn the filter like module at IISc.


on 1st June
insertion of donext: a critical bug needs to be solved. doing away with timing propagation!
need xin delay line output from systolic wrapper... to output for display...along with our interpolated values.

on 29th May 2009
this is working at non-equispaced times, coded in hex which represent chebyshev interspersed with normal triggering.
a snap has been taken at this point.
the filter as usual is working.. without any timing violations.


on 27th May 2009: the Low pass filter is working.

The bit file is generated.
this is being handled in version ise 10.1
resource usage is like 15-20%.

just double click theja_batch in the xilinx folder with the spartan kit connected to dump the bit file onto the device.
keep the switch 0 in reset position for this filter to work.

also give input only in the range of 0-500hz (sampling at 1khz, thats why!)

follow the adc/dac examples on the xilinx website to edit the files!!!


on 26th May :

            neg_AD: XOR s6, FF                          ;complement [s7,s6] to make positive
                    XOR s7, FF
                    ADD s6, 01
                    ADDCY s7, 00

h
the output of the ADC is a 14 bit 2's complement value of the input-Vref(=1.65V). I only need to add this back (properly scaled to the 12 bit magnitude format...). And at all other times, ignore this.




Log on 26th May 2009
	vn5 means version new 5
	the booth encoded serial multiplier is working as can visibly be seen on the DSO.
	I am freezing this design here. Will copy and start over as vn6
	there is an offset bug: when the muplitplier is 0.25 (rel mag), the DC offset on DSO is 2*Voffset when the rel magnitude is 0.5. i.e when multiplying with coeff2, the vavg is 1.4V whereas when multiplying with coeff1 the vavg is only 0.7V.

