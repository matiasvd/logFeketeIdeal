----------------
-- Defines the polynomial ideal of critical configurations.
--
-- The ideal is generated by polynomials with variables xij, zij, i<j.
-- The generators are the polynomials corresponding to the following equations:
-- -- Definition of auxiliary variables zij that gurantee xij != 1.
-- -- Null center of mass.
-- -- Null gradient of the problem lagrangian.
--
-- Execute from command line using: M2 fileName.m2
--
-- 07/24 - 02/25 - MVD.
----------------

n = 4 -- number of points (n>=3)
<< "Number of points: " << n << endl

--------------------------------
-- Polynomial coefficients.
--------------------------------
p = 0; -- p=0 => rationals, p>0 => Zp, p prime.
if ( p == 0 ) then (
	kk = QQ; -- rational coefficients
) else ( -- p>0, p prime
	kk = ZZ/p; -- integers modulo p
)

<< "Coefficients in Zp, with p=" << p << endl

--------------------------------
-- Create variables of polynomial ring.
--
-- flatten converts matrix to row vector, concatenating columns.
--------------------------------

-- X_ij, for 0 <= i < j <= n-1
-- i=0,...,j-1, j=0,...,n-1
Xvars = flatten apply(n, j -> flatten apply( j, i -> x_(i,j) ) )

-- Z_ij, for 0 <= i < j <= n-1
-- i=0,...,j-1, j=0,...,n-1
Zvars = flatten apply(n, j -> flatten apply( j, i -> z_(i,j) ) )

--------------------------------
-- Create polynomial ring.
--
-- Polynomial ring with coefficients in kk and variables X and Z.
--------------------------------
R = kk[Zvars, Xvars, MonomialOrder => GRevLex];

-- describe R


----------------------
-- Equations that define the auxiliary variables zij.
-- zij * (1-xij) - 1 = 0, for 0 <= i < j <= n-1.
-- Implies xij != 1
----------------------
I1 = ideal(R); -- null ideal
for j from 0 to n-1 do (
  for i from 0 to j-1 do ( -- i<j
    eqAux = z_(i,j) * ( 1 - x_(i,j) ) - 1;

    I1 = I1 + ideal(eqAux); -- add equation to ideal
  );
);

-- << endl << "Auxiliary variables zij: " << endl << describe I1


------------------------------
-- Matrix nxn symmetric with variables X_ij and ones on its diagonal.
-- Simplifies the definition of the rest of the equations.
------------------------------
X = mutableMatrix id_(R^n) -- mutable identity matrix nxn

for j from 0 to n-1 do (
  for i from 0 to j-1 do (
    X_(i,j) = x_(i,j);
    X_(j,i) = x_(i,j); -- symmetric
  )
)

X = matrix X -- stops being mutable (modifiable)

------------------------------
-- Equations of null center of mass.
-- For each i=0,...,n-1:
-- -- ( sum x(j,i), j=0,...,i-1 ) + 1 + ( sum x(i,j), j=i+1,...,n-1 ).
--
-- Equivalently: each row of matrix X must sum to 0.
------------------------------
I2 = ideal(R); -- null ideal
for i from 0 to n-1 do ( -- each row of matrix X
  eqAux = sum apply(n, j -> X_(i,j) ); -- sum row values

  I2 = I2 + ideal(eqAux); -- add equation to ideal
);

-- << endl << "Null center of mass: " << endl << describe I2


------------------------------
-- Matrix nxn symmetric with variables Z_ij and zeros on its diagonal.
-- Simplifies the definition of the rest of the equations.
------------------------------
Z = mutableMatrix id_(R^n) -- mutable identity matrix nxn

for j from 0 to n-1 do (
  Z_(j,j) = 0; -- null diagonal

  for i from 0 to j-1 do (
    Z_(i,j) = z_(i,j);
    Z_(j,i) = z_(i,j); -- symmetric
  )
)

Z = matrix Z -- stops being mutable (modifiable)

------------------------------
-- Equations of null gradient of Lagrangian
------------------------------
I3 = ideal(R); -- null ideal
for k from 0 to n-1 do (
  for i from 0 to n-1 do (
    if i != k then (
      eqAux = -(n-1) * X_(i,k);

      -- sum in j!=k ( as Z_(k,k)=0 by definition of matrix Z )
      eqAux += sum apply( n, j -> ( X_(i,k) - X_(i,j) ) * Z_(k,j) );

      I3 = I3 + ideal(eqAux); -- add equation to ideal
    );

  );
);


--------------------
-- Sum of ideals.
--------------------
J = I1 + I2 + I3 -- all the equations


--------------
-- Save ideal generators as a text file with msolve format.
--
-- The saved file will need post processing to remove underscores.
-- In VSCodium this can be done searching for the regex: _\((\d),(\d)\) and replacing it with $1$2.
--
-- Two other things need to be removed from the saved file (manually):
-- -- the parenthesis { and } that hold the variables of the first line, and
-- -- the comma after the last generator.
--------------
load "saveAsMsolve.m2"; -- load auxiliary function that does the saving

-- name is of the form: n4p0ideal.ms
fileName = concatenate( "n", toString(n), "p", toString(p), "ideal.ms" );

saveAsMsolve(fileName, R, p, J);


