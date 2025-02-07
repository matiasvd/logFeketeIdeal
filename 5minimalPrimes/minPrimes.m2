----------
-- Minimal primes of an ideal.
--
-- Input: Grobner basis of I + (factor of q);
-- with q a generator of I \cap Q[x].
--
-- MVD 02/25.
----------

n = 6 -- number of points

m = 12 -- factor to use (starting at 1)
-- for n=6 we use m = 1, 5, 12, 17, 18, 20.

-------
-- Load ring R and Grobner basis of ideal IFq = I + (factor of q)
-------

-- of the form: n6p0Factor3Base.m2
fileName = concatenate("n", toString(n), "p0Factor", toString(m), "Base.m2");
load( concatenate("./basisIFactor/", fileName) )

-------
-- List of factors of the generator of I \cap Q[x]
-- Obtained using factorsGen.m2.
-------

-----
-- n=5 factors of q:
-----
-- x34, x34+1, 2*x34+1, 4*x34+1, 8*x34+7, 16*x34-1, 4*x34**2 + 2*x34-1

-----
-- n=6 factors of q:
-----
-- x45, x45+1, 2*x45-1, 2*x45+1, 5*x45-1, 5*x45+1, 5*x45+7,
-- 5*x45^2+1, 5*x45^2-22*x45+5, 5*x45^2+2*x45-1, 5*x45^2+14*x45-1,
-- 25*x45^2+28*x45+19, 125*x45^2+50*x45-31,
-- 100*x45^4+95*x45^3-21*x45^2-22*x45+10,
-- 250*x45^4+110*x45^3-21*x45^2-19*x45+4,
-- 400*x45^4+488*x45^3-111*x45^2-196*x45+67,
-- 3*x45+1, 5*x45+4, 10*x45-1, 25*x45-1, 25*x45+11, 25*x45+23

--------------------
-- Minimal prime ideals of I + (factor of q).
--------------------

gbTrace = 3 -- verbosity

Imp = minimalPrimes IFq; -- minimal prime factorization

<< endl << "Generating sets of the minimal primes:" << endl;

print toString Imp -- generating set of each minimal prime

<< endl << "Number of points: " << toString(n) << endl;

<< endl << "Selected factor number: " << toString(m) << endl;

<< endl << "Number of minimal primes of I+(q): " << #Imp << endl;
