--------------
-- Save ideal in text file with msolve format.
--
-- The saved file will need post processing to remove underscores.
-- In VSCodium this can be done searching for the regex: _\((\d),(\d)\) and replacing it with $1$2.
--
-- Two other things need to be removed from the saved file (manually):
-- -- the parenthesis { and } that hold the variables of the first line, and
-- -- the comma after the last generator.
--
-- 07/24 - 02/25 - MVD.
--------------
saveAsMsolve = (fileName, R, p, J) -> (
  f := fileName << ""; -- generate empty text file
  
  -- write ring variables to file
  f << toString gens R << endl;

  -- write p of Zp to file (p=0 for rationals)
  f << p << endl;

  -- write each generator to file
  m := numgens J; -- number of generators
  for i from 0 to m-1 do (
    f << toString J_i << "," << endl;
  );

  f << close; -- close the file

);

