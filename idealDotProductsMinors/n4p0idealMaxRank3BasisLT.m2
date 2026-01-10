-- Leading ideal data
--
-- field characteristic: 0
-- variable order:       z01, z02, z12, z03, z13, z23, x01, x02, x12, x03, x13, x23
-- monomial order:       graded reverse lexicographical
-- length of basis:      15 elements sorted by increasing leading monomials
--

R = QQ[z01, z02, z12, z03, z13, z23, x01, x02, x12, x03, x13, x23];

I = ideal(
x03, 
x12, 
x02, 
x01, 
z13, 
z03, 
z12, 
z02, 
z01, 
x23^2, 
x13*x23, 
z23*x23, 
x13^2, 
z23*x13, 
z23^2
);

gbTrace = 3;

forceGB gens I;

print dim I;
print degree I;


