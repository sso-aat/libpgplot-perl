
use lib ".";
use ExtUtils::MakeMaker;
use ExtUtils::F77;
use Config;

WriteMakefile(
    'NAME'	=> 'PGPLOT',
    'VERSION_FROM'	=> 'PGPLOT.pm',
    'PM'        => {'PGPLOT.pm' => '$(INST_LIBDIR)/PGPLOT.pm',
                    'ExtUtils/F77.pm' => '$(INST_LIBDIR)/ExtUtils/F77.pm'},
    'LIBS'	=> ['-L/usr/local/lib -L/usr/local/pgplot -lcpgplot -lpgplot '.
                    '-L/usr/openwin/lib -L/usr/X11/lib -L/usr/X11R6/lib -lX11 '.
                    ExtUtils::F77->runtime],
    'DEFINE'	=>  ExtUtils::F77->trail_ ? "" : "-DNO_TRAILING_USCORE",
    'INC'	=> '-I/usr/local/pgplot',  # where cpgplot.h should be
    'dist'      => { COMPRESS=>"gzip", SUFFIX=>"gz" }
);

