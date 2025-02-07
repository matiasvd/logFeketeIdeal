-------------------
-- Calculate dimension and degree of an ideal I.
-- Input is a Grobner basis of the ideal.
--
-- Execute from command line using: M2 fileName.m2
-- MVD 02/25.
-------------------

-- basisFile = "n4p0base.m2"
-- dim I = 0; degree I = 4

basisFile = "n5p0base.m2"
-- dim I = 0; degree I = 38

-- basisFile = "n6p0base.m2"
-- dim I = 0; degree I = 938 (takes some minutes and more than 10GB of RAM)

load basisFile -- loads ring and Grobner basis of ideal

gbTrace = 3 -- verbosity

forceGB gens I -- tells M2 that this is a Grobner basis

dimI = dim I;
<< endl << "Ideal dimension: " << dimI << endl;

degI = degree I;
<< endl << "Ideal degree: " << degI << endl;

