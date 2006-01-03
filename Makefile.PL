
require 5.003;
use lib ".";
use ExtUtils::MakeMaker;

BEGIN {
eval 'use blib "../ExtUtils";' # For KGB development
if -e "../ExtUtils";
}

use ExtUtils::F77; # This should work most of the time

# Examples of how to explicitly override default automatic choice
# of OS and compiler (currently commented out):

#use ExtUtils::F77 qw(solaris); 
#use ExtUtils::F77 qw(generic g77); 


use Config;

# use command line KEY=VALUE to override defaults.  VALUES are comma
# separated lists

my %Arg = ( 
	   # X11 library directories
	   XDIR => '/usr/openwin/lib,/usr/X11/lib,/usr/X11R6/lib',

	   # X11 libraries
	   XLIB => 'X11',


	   # where cpgplot.h should be
	   IDIR  => $ENV{PGPLOT_DIR} || '/usr/include',

	   # where libpgplot.a should be
	   LDIR  => $ENV{PGPLOT_DIR} || '/usr/lib',

	   # extra libraries and directories
	   EXLIB => '',
	   EXDIR => '',
	  );


my @NARGV;
while( $_ = shift @ARGV )
{
  if ( /^([\S]+)=(.+)/ && exists $Arg{$1} )
  {
    $Arg{$1} = $2;
  }
  else
  {
    push @NARGV, $_;
  }
}
@ARGV = @NARGV;

$LIBDIRS = join(' ', map {  "-L$_" }
                       map { split( ',', $_ ) }
		         @Arg{qw/ XDIR LDIR EXDIR /}
	       );

$LIBS = join(' ', map { "-l$_" }
	            qw/ pgplot cpgplot /,
	            map { split( ',', $_ ) } @Arg{qw/ XLIB EXLIB /}
	     );


$IDIRS = join( ' ', map { "-I$_" } split( ',', $Arg{IDIR} ) );

my $dlext = $^O =~ /mswin32/i ? 'xs.dll' : $Config{so};

WriteMakefile(
    'NAME'	=> 'PGPLOT',
    'PREREQ_PM' => { 'ExtUtils::F77' => 1.13 },
    'VERSION_FROM'	=> 'PGPLOT.pm',
     ($^O eq 'VMS' ? ('LIBS' => 'pgplot_dir:cpgplot.olb') :
     (-d 'pgplot_tmp' ? 
        ('OBJECT' => '$(BASEEXT)$(OBJ_EXT) pgplot_tmp/libcpgplot.a '.
                    'pgplot_tmp/libpgplot.a',
	 'LIBS'	=> [ join( ' ', $LIBDIRS, $LIBS, ExtUtils::F77->runtime ) ]
	)
      :
      ('LIBS' => [ join( ' ', $LIBDIRS, $LIBS, ExtUtils::F77->runtime )])
     )),
    'DEFINE'	=>  ExtUtils::F77->trail_ ? "" : "-DNO_TRAILING_USCORE",
    ($^O eq 'VMS' ? ('INC' => 'pgplot_dir:') : (
    'INC'	=> $IDIRS
    )),
    'dist'      => { COMPRESS=>"gzip", SUFFIX=>"gz" },
    'DLEXT'     => $dlext,
    'depend'    => { '$(OBJECT)' => q[pgfun.c arrays.c PGPLOT.c]}
);

