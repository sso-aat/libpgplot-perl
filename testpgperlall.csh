#!/bin/csh -f

# Run all the tests (perl5 pgperl version)
#
# Note: files must be installed in all the right
# places (see BUILDING) for this to work.
#

foreach t (testpgperl[0-9].pg testpgperl1[0-1].pg)
   echo Running test $t...
   time perl $t
end

