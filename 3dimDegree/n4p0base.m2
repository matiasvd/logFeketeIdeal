-- Reduced Groebner basis data
--
-- field characteristic: 0
-- variable order:       z01, z02, z12, z03, z13, z23, x01, x02, x12, x03, x13, x23
-- monomial order:       graded reverse lexicographical
-- length of basis:      15 elements sorted by increasing leading monomials
--

R = QQ[z01, z02, z12, z03, z13, z23, x01, x02, x12, x03, x13, x23];

I = ideal(
    x03+x13+x23+1, 
    x12+x13+x23+1, 
    x02-1*x13, 
    x01-1*x23, 
    2*z13-2*z23-1*x13+x23, 
    2*z03-2*z23+x13+2*x23+1, 
    2*z12-2*z23+x13+2*x23+1, 
    2*z02-2*z23-1*x13+x23, 
    z01-1*z23, 
    3*x23^2-8*z23+7*x23+8, 
    3*x13*x23+4*z23-2*x23-4, 
    z23*x23-1*z23+1, 
    3*x13^2-8*z23+3*x13+4*x23+8, 
    2*z23*x13+2*z23-2*x13-1*x23-2, 
    8*z23^2-18*z23+3*x23+10
);

