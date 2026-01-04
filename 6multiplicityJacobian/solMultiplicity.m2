------------
-- Given a generating set of and ideal I, and a point p=(zp,xp) of V(I):
-- -- calculate the rank of D(p); were D(z,x) is the Jaocbian matrix of the ideal generators.
--
-- Theorem: p has multiplicity 1 <=> D(p) has maximum rank.
--
-- Execute from command line using: M2 fileName.m2
--
-- 07/24 - 01/25 - MVD
------------

-- loads ring R and ideal I generators from text file.
load "n6p0ideal.m2"

-- available configurations
configs = {"equator", "141", "15", "33", "complex1"}

-- choose a configuration (index starts at 0)
conf = configs_4
<< "Chosen configuration: " << conf << endl


--------
-- Function that calculates the jacobian and its rank.
-- Input: ring R, ideal I, list zx with values of point p in V(I).
-- Output: rank of jacobian of ideal generators at p.
--------
jacRank = (R, I, zx) -> (
    m := numgens R; -- number of ring variables
    << "Number of ring variables: " << m << endl;

    k := numgens I; -- number of ideal generators
    << "Number of ideal generators: " << k << endl;

    --------
    -- jacobian matrix of ideal generators
    --------
    Dx := jacobian I; -- jacobian matrix of generators of the ideal. Dx is mxk.

    -- evaluate matrix entries at configuration values
    F := map(R, R, zx); -- map F:R->R that sends each variable to the corresponding configuration value.
    D := F(Dx); -- map matrix entries to configuration values

    << "Size of jacobian matrix D(p): " << numRows D << "x" << numColumns D << endl;

    << "Configuration verifies ideal equations?: " << F(I)==0 << endl;

    --------
    -- rank of jacobian matrix
    --------
    elapsedTime rankD := rank D; -- rank matrix D
    << "Rank of jacobian matrix of generators: " << rankD << endl;

)


------------
-- Equator
--
-- Chosen configuration: equator
-- Number of ring variables: 30
-- Number of ideal generators: 51
-- Size of jacobian matrix D(p): 30x51
-- Configuration verifies ideal equations?: true
 -- .00429236s elapsed
-- Rank of jacobian matrix of generators: 30
------------
if conf == "equator" then ( -- [z,x]
    ------------
    -- Coordinates of the configuration
    ------------
    -- x01, x02, x12, x03, x13, x23, x04, x14, x24, x34, x05, x15, x25, x35, x45.
    -- z01, z02, z12, z03, z13, z23, z04, z14, z24, z34, z05, z15, z25, z35, z45.
    --
    -- xij = [1/2, -1/2, 1/2, -1, -1/2, 1/2, -1/2, -1, -1/2, 1/2, 1/2, -1/2, -1, -1/2, 1/2]
    -- zij = 1/(1-xij) = [2, 2/3, 2, 1/2, 2/3, 2, 2/3, 1/2, 2/3, 2, 2, 2/3, 1/2, 2/3, 2]

    zx = {2, 2/3, 2, 1/2, 2/3, 2, 2/3, 1/2, 2/3, 2, 2, 2/3, 1/2, 2/3, 2, 1/2, -1/2, 1/2, -1, -1/2, 1/2, -1/2, -1, -1/2, 1/2, 1/2, -1/2, -1, -1/2, 1/2};

    jacRank(R, I, zx) -- calculate jacobian and its rank

);


------------
-- 1:4:1
--
-- Chosen configuration: 141
-- Number of ring variables: 30
-- Number of ideal generators: 51
-- Size of jacobian matrix D(p): 30x51
-- Configuration verifies ideal equations?: true
 -- .00263403s elapsed
-- Rank of jacobian matrix of generators: 30
------------
if conf == "141" then ( -- [z,x]
    ------------
    -- Coordinates of the configuration
    ------------
    -- x01, x02, x12, x03, x13, x23, x04, x14, x24, x34, x05, x15, x25, x35, x45.
    -- z01, z02, z12, z03, z13, z23, z04, z14, z24, z34, z05, z15, z25, z35, z45.
    --
    -- xij = [-1, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1]
    -- zij = 1/(1-xij) = [1/2, 1, 1, 1, 1, 1/2, 1, 1, 1, 1, 1, 1, 1, 1, 1/2]

    zx = {1/2, 1, 1, 1, 1, 1/2, 1, 1, 1, 1, 1, 1, 1, 1, 1/2, -1, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, 0, 0, 0, -1};

    jacRank(R, I, zx) -- calculate jacobian and its rank

);


------------
-- 1:5. Using coefficients satisfying t^2=5.
--
-- Chosen configuration: 15
-- Number of ring variables: 30
-- Number of ideal generators: 51
-- Size of jacobian matrix D(p): 30x51
-- Configuration verifies ideal equations?: true
 -- .0281067s elapsed
-- Rank of jacobian matrix of generators: 30
------------
if conf == "15" then ( -- [z,x]
    -- we want t=sqrt(5), but this is not rational.
    -- instead we work with rational coefficients modulo t^2-5
    K = QQ[t] / (t^2-5); -- quotient ring that satisfies t^2=5
    S = K[gens R]; -- original ideal with coefficients in K
    use S;

    -- solution parameters
    A = ( -5 + 6*t ) / 25; -- dot product of contiguous points
    B = ( -5 - 6*t ) / 25; -- dot product of non contiguous points
    
    -- Az = 25 / ( 30 - 6*t ); -- zij associated to A
    Az = 25 * ( 30 + 6*t ) / 720; -- zij associated to A

    -- Bz = 25 / ( 30 + 6*t ); -- zij associated to B
    Bz = 25 * ( 30 - 6*t ) / 720; -- zij associated to B

    ------------
    -- Coordinates of the configuration
    ------------
    -- x01, x02, x12, x03, x13, x23, x04, x14, x24, x34, x05, x15, x25, x35, x45.
    -- z01, z02, z12, z03, z13, z23, z04, z14, z24, z34, z05, z15, z25, z35, z45.
    --
    -- xij = [-1/5, -1/5, A, -1/5, B, A, -1/5, B, B, A, -1/5, A, B, B, A]
    -- zij = 1/(1-xij) = [5/6, 5/6, Az, 5/6, Bz, Az, 5/6, Bz, Bz, Az, 5/6, Az, Bz, Bz, Az]
    zx = {5/6, 5/6, Az, 5/6, Bz, Az, 5/6, Bz, Bz, Az, 5/6, Az, Bz, Bz, Az, -1/5, -1/5, A, -1/5, B, A, -1/5, B, B, A, -1/5, A, B, B, A};

    mapId = map(S, R); -- define identity map id:R->S
    J = mapId(I); -- maps ideal I from ring R to ring S

    jacRank(S, J, zx) -- calculate jacobian and its rank

);


------------
-- 3:3 with phase 0. Using coefficients satisfying t^2=6.
--
-- Chosen configuration: 33
-- Number of ring variables: 30
-- Number of ideal generators: 51
-- Size of jacobian matrix D(p): 30x51
-- Configuration verifies ideal equations?: true
 -- .0253194s elapsed
-- Rank of jacobian matrix of generators: 30
------------
if conf == "33" then ( -- [z,x]

    -- we want t=sqrt(6), but this is not rational.
    -- instead we work with rational coefficients modulo t^2-6

    K = QQ[t] / (t^2-6); -- coefficient ring with t^2=6.
    S = K[gens R]; -- original ring with coefficients in K.
    use S;

    -- parameters
    A = ( -7 + 3*t ) / 5; -- dot product x01
    B = ( 11 - 4*t ) / 5; -- x03
    C = ( -1 - t ) / 5; -- x04

    Az = ( 4 + t ) / 6; -- zij associated to A
    Bz = ( 3 + 2*t ) / 6; -- zij associated to B
    Cz = ( 6 - t ) / 6; -- zij associated to C

    ------------
    -- Coordinates of the configuration
    ------------
    -- x01, x02, x12, x03, x13, x23, x04, x14, x24, x34, x05, x15, x25, x35, x45.
    -- z01, z02, z12, z03, z13, z23, z04, z14, z24, z34, z05, z15, z25, z35, z45.
    --
    -- xij = [A, A, A, B, C, C, C, B, C, A, C, C, B, A, A]
    -- zij = 1/(1-xij) = [Az, Az, Az, Bz, Cz, Cz, Cz, Bz, Cz, Az, Cz, Cz, Bz, Az, Az]
    zx = {Az, Az, Az, Bz, Cz, Cz, Cz, Bz, Cz, Az, Cz, Cz, Bz, Az, Az, A, A, A, B, C, C, C, B, C, A, C, C, B, A, A};

    mapId = map(S, R); -- define identity map id:R->S
    J = mapId(I); -- maps ideal I from ring R to ring S

    jacRank(S, J, zx) -- calculate jacobian and its rank

)


------------
-- Complex 1. Using coefficients satisfying 5*x03^2+1 = 0.
--
-- Chosen configuration: complex1
-- Number of ring variables: 30
-- Number of ideal generators: 51
-- Size of jacobian matrix D(p): 30x51
-- Configuration verifies ideal equations?: true
 -- .026831s elapsed
-- Rank of jacobian matrix of generators: 29
--
------------
if conf == "complex1" then ( -- [z,x]

    -- coefficient ring: rationals modulo 5*t^2 + 1
    K = QQ[t] / ( 5*t^2 + 1 ); -- quotient ring (5*t^2 + 1 = 0)

    S = K[gens R]; -- original ring but with coefficients in K, satisfying: 5*t^2+1=0
    use S;

    -- solution parameters
    A = t; -- dot product x03
    B = 1/5; -- x23
    C = -7/5; -- x25
    D = -t; -- x02

    -- associated zij
    Az = (1+t)*(5/6); -- 1/(1-t) = (1+t)/(1-t^2) = (1+t)/(1+1/5) = (1+t)*(5/6)
    Bz = 5/4; -- zij asociado a B
    Cz = 5/12; -- zij asociado a C
    Dz = (1-t)*(5/6); -- 1/(1+t) = (1-t)/(1-t^2) = (1-t)/(1+1/5) = (1-t)*(5/6)

    ------------
    -- Coordinates of the configuration
    ------------
    -- x01, x02, x12, x03, x13, x23, x04, x14, x24, x34, x05, x15, x25, x35, x45.
    -- z01, z02, z12, z03, z13, z23, z04, z14, z24, z34, z05, z15, z25, z35, z45.
    --
    -- xij = [-1, D, A, A, D, B, A, D, B, C, D, A, C, B, B]
    -- zij = 1/(1-xij) = [1/2, Dz, Az, Az, Dz, Bz, Az, Dz, Bz, Cz, Dz, Az, Cz, Bz, Bz]

    zx = {1/2, Dz, Az, Az, Dz, Bz, Az, Dz, Bz, Cz, Dz, Az, Cz, Bz, Bz, -1, D, A, A, D, B, A, D, B, C, D, A, C, B, B};

    mapId = map(S, R); -- define identity map id:R->S
    J = mapId(I); -- maps ideal I from ring R to ring S

    jacRank(S, J, zx) -- calculate jacobian and its rank

)

