
require 5.003;
use lib ".";
use ExtUtils::MakeMaker;

use ExtUtils::F77;
#use ExtUtils::F77 qw(generic g77); # Try this for GNU-77

use Config;

my $ldir = defined $ENV{PGPLOT_DIR} ? "-L$ENV{PGPLOT_DIR}" : "";

WriteMakefile(
    'NAME'	=> 'PGPLOT',
    'VERSION_FROM'	=> 'PGPLOT.pm',
    'PM'        => {'PGPLOT.pm' => '$(INST_LIBDIR)/PGPLOT.pm',
                    'ExtUtils/F77.pm' => '$(INST_LIBDIR)/ExtUtils/F77.pm'},
     ($^O eq 'VMS' ? ('LIBS' => 'pgplot_dir:cpgplot.olb') :
     (-d 'pgplot_tmp' ? 
        ('OBJECT' => '$(BASEEXT)$(OBJ_EXT) pgplot_tmp/libcpgplot.a '.
                    'pgplot_tmp/libpgplot.a',
        'LIBS'	=> ['-L/usr/openwin/lib -L/usr/X11/lib -L/usr/X11R6/lib -lX11 '.
                    ExtUtils::F77->runtime])
       :
         ('LIBS' => [$ldir.' -L/usr/local/pgplot -L/usr/local/lib -lcpgplot -lpgplot '.
                    '-L/usr/openwin/lib -L/usr/X11/lib -L/usr/X11R6/lib -lX11 '.
                    ExtUtils::F77->runtime])
     )),
    'DEFINE'	=>  ExtUtils::F77->trail_ ? "" : "-DNO_TRAILING_USCORE",
    ($^O eq 'VMS' ? ('INC' => 'pgplot_dir:') : (
    'INC'	=> '-I/home/aaossm/kgb/soft/pgplot/bld -I/usr/local/pgplot'  # where cpgplot.h should be
    )),
    'dist'      => { COMPRESS=>"gzip", SUFFIX=>"gz" },
    'depend'    => { '$(OBJECT)' => 'pgfun.c'}
);

