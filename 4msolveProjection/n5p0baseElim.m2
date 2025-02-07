-- Reduced Groebner basis data
--
-- field characteristic: 0
-- variable order:       x34
-- monomial order:       graded reverse lexicographical
-- length of basis:      1 element
--

R = QQ[x34]; -- ring

-- elimination ideal
Ix = ideal(
    4096*x34^8+12544*x34^7+13408*x34^6+5000*x34^5-560*x34^4-676*x34^3-69*x34^2+7*x34
);

