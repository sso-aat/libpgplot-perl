
require 5.003;
use lib ".";
use ExtUtils::MakeMaker;

use ExtUtils::F77;
#use ExtUtils::F77 qw(generic g77); # Try this for GNU-77

use Config;

WriteMakefile(
    'NAME'	=> 'PGPLOT',
    'VERSION_FROM'	=> 'PGPLOT.pm',
    'PM'        => {'PGPLOT.pm' => '$(INST_LIBDIR)/PGPLOT.pm',
                    'ExtUtils/F77.pm' => '$(INST_LIBDIR)/ExtUtils/F77.pm'},
     (-d 'pgplot_tmp' ? 
        ('OBJECT' => '$(BASEEXT)$(OBJ_EXT) pgplot_tmp/libcpgplot.a '.
                    'pgplot_tmp/libpgplot.a',
        'LIBS'	=> ['-L/usr/openwin/lib -L/usr/X11/lib -L/usr/X11R6/lib -lX11 '.
                    ExtUtils::F77->runtime])
       :
         ('LIBS' => ['-L/usr/local/lib -L/usr/local/pgplot -lcpgplot -lpgplot '.
                    '-L/usr/openwin/lib -L/usr/X11/lib -L/usr/X11R6/lib -lX11 '.
                    ExtUtils::F77->runtime])
     ),
    'DEFINE'	=>  ExtUtils::F77->trail_ ? "" : "-DNO_TRAILING_USCORE",
    'INC'	=> '-I/usr/local/pgplot',  # where cpgplot.h should be
    'dist'      => { COMPRESS=>"gzip", SUFFIX=>"gz" }
);

