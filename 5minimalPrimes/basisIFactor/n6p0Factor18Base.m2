-- Reduced Groebner basis data
--
-- field characteristic: 0
-- variable order:       z01, z02, z12, z03, z13, z23, z04, z14, z24, z34, z05, z15, z25, z35, z45, x01, x02, x12, x03, x13, x23, x04, x14, x24, x34, x05, x15, x25, x35, x45
-- monomial order:       graded reverse lexicographical
-- length of basis:      40 elements sorted by increasing leading monomials
--

R = QQ[z01, z02, z12, z03, z13, z23, z04, z14, z24, z34, z05, z15, z25, z35, z45, x01, x02, x12, x03, x13, x23, x04, x14, x24, x34, x05, x15, x25, x35, x45];

IFq = ideal(
5*x45+4, 
5*x05+5*x15+5*x25+5*x35+1, 
x34-1*x35, 
x24-1*x25, 
x14-1*x15, 
5*x04+5*x15+5*x25+5*x35+1, 
x03+x13+x23+2*x35+1, 
5*x12+5*x13+5*x23+10*x15+10*x25+10*x35+6, 
5*x02-5*x13-10*x15-10*x35-1, 
5*x01-5*x23-10*x25-10*x35-1, 
9*z45-5, 
54*z35-50*x35-55, 
54*z25-50*x25-55, 
54*z15-50*x15-55, 
54*z05+50*x15+50*x25+50*x35-45, 
54*z34-50*x35-55, 
54*z24-50*x25-55, 
54*z14-50*x15-55, 
54*z04+50*x15+50*x25+50*x35-45, 
54*z23-25*x23-50, 
54*z13-25*x13-50, 
54*z03+25*x13+25*x23+50*x35-25, 
54*z12+25*x13+25*x23+50*x15+50*x25+50*x35-20, 
54*z02-25*x13-50*x15-50*x35-55, 
54*z01-25*x23-50*x25-50*x35-55, 
50*x35^2+5*x35-1, 
100*x25*x35+15*x23+20*x25+20*x35+7, 
100*x15*x35+15*x13+20*x15+20*x35+7, 
50*x23*x35-5*x23+10*x35-1, 
50*x13*x35-5*x13+10*x35-1, 
50*x25^2+5*x25-1, 
100*x15*x25-15*x13-15*x23-10*x15-10*x25-30*x35-11, 
50*x23*x25-5*x23+10*x25-1, 
25*x13*x25+5*x13+5*x25+1, 
50*x15^2+5*x15-1, 
25*x23*x15+5*x23+5*x15+1, 
50*x13*x15-5*x13+10*x15-1, 
25*x23^2+25*x23+4, 
25*x13*x23+5*x13+5*x23+1, 
25*x13^2+25*x13+4
);

