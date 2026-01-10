-- Leading ideal data
--
-- field characteristic: 0
-- variable order:       z01, z02, z12, z03, z13, z23, w00, w01, w02, w10, w11, w12, w20, w21, t
-- monomial order:       graded reverse lexicographical
-- length of basis:      23 elements sorted by increasing leading monomials
--

R = QQ[z01, z02, z12, z03, z13, z23, w00, w01, w02, w10, w11, w12, w20, w21, t];

I = ideal(
w20, 
w02, 
w01, 
w00, 
z23, 
z13, 
z03, 
z12, 
z02, 
z01, 
t^2, 
w12*t, 
w11*t, 
w10*t, 
w21^2, 
w11*w21, 
w10*w21, 
w12^2, 
w11*w12, 
w10*w12, 
w11^2, 
w10*w11, 
w10^2
);

gbTrace = 3;

forceGB gens I;

print dim I;
print degree I;
