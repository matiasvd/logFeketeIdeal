-------------------
-- Factorize the generator of Ix := I \cap Q[x].
-- Input is a generator p of the elimination ideal Ix.
--
-- Execute from command line using: M2 fileName.m2
--
-- MVD 02/25.
-------------------

basisFile = "n6p0baseElim.m2"

load basisFile -- loads ring and generator of elimination ideal

gbTrace = 3 -- verbosity

q = (gens Ix)_0_0; -- generator of elimination ideal

<< endl << "Generator q of elimination ideal:" << endl;
print toString q;

<< endl << "Factorization of q in Q:" << endl;
print toString factor(q);

------
-- n=5
-- Factorization of q in Q:
-- (x34)*(x34+1)*(2*x34+1)*(4*x34+1)*(8*x34+7)*(16*x34-1)*(4*x34^2+2*x34-1)
------

------
-- n=6
-- Factorization of q in Q:
-- (x45)*(x45+1)^2*(2*x45-1)*(2*x45+1)*(3*x45+1)*(5*x45-1)^2*...
-- (5*x45+1)*(5*x45+4)*(5*x45+7)^2*(10*x45-1)*(25*x45-1)*...
-- (25*x45+11)*(25*x45+23)*(5*x45^2+1)^2*(5*x45^2-22*x45+5)*...
-- (5*x45^2+2*x45-1)*(5*x45^2+14*x45-1)*(25*x45^2+28*x45+19)*...
-- (125*x45^2+50*x45-31)*(100*x45^4+95*x45^3-21*x45^2-22*x45+10)*...
-- (250*x45^4+110*x45^3-21*x45^2-19*x45+4)*...
-- (400*x45^4+488*x45^3-111*x45^2-196*x45+67)
------
