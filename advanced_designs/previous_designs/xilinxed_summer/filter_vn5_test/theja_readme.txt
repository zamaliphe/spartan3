Log on 26th May 2009
	vn5 means version new 5
	the booth encoded serial multiplier is working as can visibly be seen on the DSO.
	I am freezing this design here. Will copy and start over as vn6
	there is an offset bug: when the muplitplier is 0.25 (rel mag), the DC offset on DSO is 2*Voffset when the rel magnitude is 0.5. i.e when multiplying with coeff2, the vavg is 1.4V whereas when multiplying with coeff1 the vavg is only 0.7V.

