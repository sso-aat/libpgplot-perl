
package ExtUtils::F77;

use Config;

=head1 NAME

ExtUtils::F77 - Simple interface to F77 libs

=head1 DESCRIPTION

Simple interface to F77 libs based on 'rule-of-thumb' knowledge of
various flavours of UNIX systems.

Includes a simple self-documenting Perl database of knowledge/code
for figuring out how to link for various combinations of OS and
compiler. Please help save the world by sending database entries for
your system to kgb@aaoepp.aao.gov.au

=cut

$VERSION = "1.01";

# Database starts here. Basically we have a large hash specifying
# entries for each os/compiler combination. Entries can be code refs
# in which case they are executed and the returned value used. This
# allows us to be quite smart.

# Hash key convention is uppercase first letter of
# hash keys. First key is usually the name of the architecture as
# returned by Config (modulo ucfirst()).

%F77config=();

### SunOS (use this as a template for new entries) ###

# Code to figure out and return link-string for this architecture
# Returns false if it can't find anything sensible.

$F77config{Sunos}{F77}{Link} = sub {  
       $dir = find_highest_SC("/usr/lang/SC*");
       return "" unless $dir; # Failure
       print "$Pkg: Found Fortran latest version lib dir $dir\n";
       return "-L$dir -lF77 -lm";
};

# Whether symbols (subroutine names etc.) have trailing underscores 
# (true/false)

$F77config{Sunos}{F77}{Trail_} = 1; 

# Name of default compiler - corresponds to one of the above keys

$F77config{Sunos}{DEFAULT} = 'F77'; 

############ Rest of database is here ############ 

### Solaris ###

$F77config{Solaris}{F77}{Link} = sub {  
       $dir = find_highest_SC("/opt/SUNWspro/SC*/lib");
       return "" unless $dir; # Failure
       print "$Pkg: Found Fortran latest version lib dir $dir\n";
       return "-L$dir -lF77 -lM77 -lsunmath -lm";
};
$F77config{Solaris}{F77}{Trail_} = 1;
$F77config{Solaris}{DEFAULT} = 'F77';

### Generic GNU-77 or F2C system ###

$F77config{Generic}{G77}{Link} = '-L/usr/lib -lf2c -lm';
$F77config{Generic}{G77}{Trail_} = 1;
$F77config{Generic}{DEFAULT} = 'G77';
$F77config{Generic}{F2c}     = $F77config{Generic}{G77};

### Linux ###

$F77config{Linux}{G77}     = $F77config{Generic}{G77};
$F77config{Linux}{F2c}     = $F77config{Generic}{G77};
$F77config{Linux}{DEFAULT} = 'G77';

### DEC OSF/1 ###

$F77config{Dec_osf}{F77}{Link}   = "-L/usr/lib -lUfor -lfor -lFutil -lm -lots -lc";
$F77config{Dec_osf}{F77}{Trail_} = 1;
$F77config{Dec_osf}{DEFAULT}     = 'F77';

### HP/UX ###

$F77config{Hpux}{F77}{Link}   = "-L/usr/lib -lcl -lm";
$F77config{Hpux}{F77}{Trail_} = 0;
$F77config{Hpux}{DEFAULT}     = 'F77';

### IRIX ###

$F77config{Irix}{F77}{Link}   = "-L/usr/lib -lF77 -lI77 -lU77 -lisam -lm";
$F77config{Irix}{F77}{Trail_} = 1;
$F77config{Irix}{DEFAULT}     = 'F77';

### AIX ###

$F77config{Aix}{F77}{Link}   = "-L/usr/lib -lxlf -lc -lm";
$F77config{Aix}{F77}{Trail_} = 0;
$F77config{Aix}{DEFAULT}     = 'F77';

############ End of database is here ############ 

=head1 SYNOPSIS

  use ExtUtils::F77;               # Automatic guess 
  use ExtUtils::F77 qw(sunos);     # Specify system
  use ExtUtils::F77 qw(linux g77); # Specify system and compiler

=cut

# Package variables

$Runtime = "-LSNAFU -lwontwork";
$Trail_  = 1;
$Pkg   = "";

sub get; # See below

# All the figuring out occurs during import - this is because
# a lot of the answers depend on a lot of the guesswork.

sub import {
   $Pkg    = shift;
   my $system   = ucfirst(shift);  # Set package variables
   my $compiler = ucfirst(shift);

   # Guesses if system/compiler not specified.

   $system   = ucfirst $Config{'osname'} unless $system;
   $compiler = get $F77config{$system}{DEFAULT} unless $compiler;

   print "$Pkg: Using system=$system compiler=$compiler\n";

   # Try this combination

   if (defined( $F77config{$system} )){
      $Runtime = get $F77config{$system}{$compiler}{Link};  
      $ok = validate_libs($Runtime) if $Runtime;
   }else {
      $Runtime = $ok = "";
   }

   # If it doesn't work try Generic + GNU77

   unless ($Runtime && $ok) {
      print <<"EOD";
$Pkg: Unable to guess and/or validate system/compiler configuration
$Pkg: Will try system=Generic Compiler=G77
EOD
      $system   = "Generic";
      $compiler = "G77";
      $Runtime = get $F77config{$system}{$compiler}{Link};  
      $ok = validate_libs($Runtime) if $Runtime;
      print "$Pkg: Well that didn't appear to validate. Well I will try it anyway.\n"
           unless $Runtime && $ok;
    }

   # Now get the misc info for the methods.
      
   if (defined( $F77config{$system}{$compiler}{Trail_} )){
      $Trail_  = get $F77config{$system}{$compiler}{Trail_};  
   }
   else{ 
      print << "EOD";
$Pkg: There does not appear to be any configuration info about
$Pkg: names with trailing underscores for system $system. Will assume
$Pkg: F77 names have trailing underscores.
EOD
      $Trail_ = 1;
   }
   
} # End of import ()

=head2 METHODS

runtime() - Returns list of *checked* F77 runtime libraries
trail_()  - Returns true if F77 names have trailing underscores

[probably more to come.]

=cut

sub runtime { return $Runtime; }
sub trail_  { return $Trail_; }


### Minor internal utility routines ###

# Get hash entry, evaluating code references

sub get { ref($_[0]) eq "CODE" ? &{$_[0]} : $_[0] };

# Test if any files exist matching glob

sub any_exists {
    my @glob = glob(shift);
    return scalar(@glob);
}

# Find highest version number of SCN.N(.N) directories
# (Nasty SunOS/Solaris naming scheme for F77 libs]

sub find_highest_SC {
    print "$Pkg: Scanning for $_[0]\n";
    my @glob = glob(shift);
    my %n=();
    for (@glob) {
      #print "Found $_\n";
       if ( m|/SC(\d)\.(\d)/?.*$| ) {
           $n{$_} = $1 *100 + $2 * 10;
       }
       if ( m|/SC(\d)\.(\d)\.(\d)/?.*$| ) {
           $n{$_} = $1 *100 + $2 * 10 + $3;
       }
    }
    my @sorted_dirs = sort {$n{$a} <=> $n{$b}} @glob;
    return pop @sorted_dirs; # Highest N
}
     
# Validate a string of form "-Ldir -lfoo -lbar"

sub validate_libs {
   print "$Pkg: Validating $_[0]   ";
   my @args = split(' ',shift());
   my $pat;
   my $ret = 1;

   # Create list of directories to search (with common defaults)

   my @path = ();     
   for (@args, "/usr/lib", "/lib") { 
      push @path, $1 if /^-L(.+)$/ && -d $1;
   }

   # Search directories

   for (@args) {      
      next if /^-L/;
      next if $_ eq "-lm"; # Ignore this common guy
      if (/^-l(.+)$/) {
         $pat = join(" ", map {$_."/lib".$1.".*"} @path); # Join dirs + file
         #print "Checking for $pat\n";
         unless (any_exists($pat)) {
            print "\n$Pkg:    Unable to find library $_" ;
            $ret = 0;
         }
       }
   }
   print $ret ? "[ok]\n" : "\n";
   return $ret;
}

1; # Return true
