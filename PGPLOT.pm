
package PGPLOT;

;# Package to allow calling of PGPLOT from Perl.

;# Includes perl interfaces to the PGPLOT array routines
;# which cannot be called directly.
;#
;# Karl Glazebrook [email: kgb@ast.cam.ac.uk]
;#
;# pgperl WWW info: http://www.ast.cam.ac.uk/~kgb/pgperl.html

require Exporter;
require DynaLoader;

@ISA = qw(Exporter DynaLoader);
@EXPORT = qw( pgarro pgask pgband pgbbuf pgbeg pgbegin pgbin pgbox
pgcirc pgconb pgconl pgcons pgcont pgconx pgctab pgcurs pgcurse pgdraw
pgebuf pgend pgenv pgeras pgerrb pgerrx pgerry pgetxt pgfunt pgfunx
pgfuny pggray pghi2d pghist pgiden pgimag pglab pglabel pglcur pgldev
pglen pgline pgmove pgmtxt pgmtext pgncur pgncurse pgnumb pgolin pgpage
pgadvance pgpanl pgpap pgpaper pgpixl pgpnts pgpoly pgpt pgpoint pgptxt
pgptext pgqah pgqcf pgqch pgqci pgqcir pgqcol pgqcr pgqcs pgqfs pgqhs
pgqinf pgqitf pgqls pgqlw pgqpos pgqtbg pgqtxt pgqvp pgqvsz pgqwin
pgrect pgrnd pgrnge pgsah pgsave pgunsa pgscf pgsch pgsci pgscir pgscr
pgscrn pgsfs pgshls pgshs pgsitf pgsls pgslw pgstbg pgsubp pgsvp
pgvport pgswin pgwindow pgtbox pgtext pgupdt pgvect pgvsiz pgvsize
pgvstd pgvstand pgwedg pgwnad pgerrb1 pgerrx1 pgerry1 pgpoint1
pgpt1 pgperlcv pgperlv );

bootstrap PGPLOT;

;# Array conversion routines

sub fap   { return pack1D($_[0],"f*") }
sub iap   { return pack1D($_[0],"i*") }
sub fap2D { return pack2D($_[0],"f*") }
sub iap2D { return pack2D($_[0],"i*") }

sub pack1D {                     # Pack 1D array or scalar according
    local($arg,$packtype)=@_;    # to type of passed argument.

    return pack($packtype, $arg)  if ref(\$arg) eq "SCALAR";
    return pack($packtype, @$arg) if ref(\$arg) eq "GLOB" ||
          (ref($arg) eq "ARRAY" && ref(\$$arg[0]) eq "SCALAR");
    die "Routine can only handle scalar values or refs to 1D arrays";
}

sub pack2D {                     # Pack 2D array according
    local($arg,$packtype)=@_;    # to type of passed argument.

    return $arg if ref(\$arg) eq "SCALAR"; # packed char string
    return pack($packtype, @$arg) if ref(\$arg) eq "GLOB" ||         # 1D
          (ref($arg) eq "ARRAY" && ref(\$$arg[0]) eq "SCALAR");
    return pack($packtype, map @{$$arg[$_]}, 0..$#{$arg} )           # 2D
       if ref($$arg[0]) eq "ARRAY" && ref(\$$arg[0][0]) eq "SCALAR"; 
    die "Routine can only handle scalar packed char values or refs to 1D or 2D arrays";
}

;# Declarations of array routines

sub pgbin {
    die 'Usage: pgbin($nbin,\@x,\@data,$center)' if (scalar(@_)!=4);
    local($nbin,$x,$data,$center) = @_;
    pgbin_r($nbin,fap($x),fap($data),$center);
}

sub pgconb {
    die 'Usage: pgconb(\@a,$idim,$jdim,$i1,$i2,$j1,$j2,\@c,$nc,\@tr,$blank)' if (scalar(@_)!=11);
    local($a,$idim,$jdim,$i1,$i2,$j1,$j2,$c,$nc,$tr,$blank) = @_;
    pgconb_r(fap2D($a),$idim,$jdim,$i1,$i2,$j1,$j2,fap($c),$nc,fap($tr),$blank);
}

sub pgcons {
    die 'Usage: pgcons(\@a,$idim,$jdim,$i1,$i2,$j1,$j2,\@c,$nc,\@tr)' if (scalar(@_)!=10);
    local($a,$idim,$jdim,$i1,$i2,$j1,$j2,$c,$nc,$tr) = @_;
    pgcons_r(fap2D($a),$idim,$jdim,$i1,$i2,$j1,$j2,fap($c),$nc,fap($tr));
}

sub pgcont {
    die 'Usage: pgcont(\@a,$idim,$jdim,$i1,$i2,$j1,$j2,\@c,$nc,\@tr)' if (scalar(@_)!=10);
    local($a,$idim,$jdim,$i1,$i2,$j1,$j2,$c,$nc,$tr) = @_;
    pgcont_r(fap2D($a),$idim,$jdim,$i1,$i2,$j1,$j2,fap($c),$nc,fap($tr));
}

sub pgconx {
    die 'Usage: pgconx(\@a,$idim,$jdim,$i1,$i2,$j1,$j2,\@c,$nc,$plot)' if (scalar(@_)!=10);
    local($a,$idim,$jdim,$i1,$i2,$j1,$j2,$c,$nc,$plot) = @_;
    $package = (caller)[0];
    $plot = $package."::".$plot unless $plot =~ /::/; # Right context
    pgconx_r(fap2D($a),$idim,$jdim,$i1,$i2,$j1,$j2,fap($c),$nc,$plot);
}

sub pgerrb {
    die 'Usage: pgerrb($dir,$n,\@x,\@y,\@e,$t)' if (scalar(@_)!=6);
    local($dir,$n,$x,$y,$e,$t) = @_;
    pgerrb_r($dir,$n,fap($x),fap($y),fap($e) ,$t);
}

sub pgerrx {
    die 'Usage: pgerrx($n,\@x1,\@x2,\@y,$t)' if (scalar(@_)!=5);
    local($n,$x1,$x2,$y,$t) = @_;
    pgerrx_r($n,fap($x1),fap($x2),fap($y),$t);
}

sub pgerry {
    die 'Usage: pgerry($n,\@x,\@y1,\@y2,$t)' if (scalar(@_)!=5);
    local($n,$x,$y1,$y2,$t) = @_;
    pgerry_r($n,fap($x),fap($y1),fap($y2),$t);
}

sub pggray {
    die 'Usage: pggray(\@a,$idim,$jdim,$i1,$i2,$j1,$j2,$fg,$bg,\@tr)' if (scalar(@_)!=10);
    local($a,$idim,$jdim,$i1,$i2,$j1,$j2,$fg,$bg,$tr) = @_;
    pggray_r(fap2D($a),$idim,$jdim,$i1,$i2,$j1,$j2,$fg,$bg,fap($tr));
}

sub pghi2d {
    die 'Usage: pghi2d(\@data,$nxv,$nyv,$ix1,$ix2,$iy1,$iy2,\@x,$ioff,$bias,$center,\@ylims)' if (scalar(@_)!=12);
    local($data,$nxv,$nyv,$ix1,$ix2,$iy1,$iy2,$x,$ioff,$bias,$center,$ylims) = @_;
    pghi2d_r(fap2D($data),$nxv,$nyv,$ix1,$ix2,$iy1,$iy2,fap($x),$ioff,$bias,$center,fap($ylims));
}

sub pghist {
    die 'Usage: pghist($n,\@data,$datamin,$datamax,$nbin,$pgflag)' if (scalar(@_)!=6);
    local($n,$data,$datamin,$datamax,$nbin,$pgflag) = @_;
    pghist_r($n,fap($data),$datamin,$datamax,$nbin,$pgflag);
}

sub pglcur {
    die 'Usage: pglcur($maxpt,$npt,\@x,\@y)' if (scalar(@_)!=4);
    local($maxpt,$npt,$x,$y) =@_;
    local($xstr,$ystr);
    for($i=$npt; $i<$maxpt; $i++) {  # Expand array
       $$x[$i]=0;
       $$y[$i]=0;
    }
    $xstr = fap($x);
    $ystr = fap($y);
    pglcur_r($maxpt,$npt,$xstr,$ystr);
    @$x = unpack("f*",$xstr);
    @$y = unpack("f*",$ystr);
    $_[1]=$npt; 
}

sub pgline {
    die 'Usage: pgline($n,\@xpts,\@ypts)' if (scalar(@_)!=3);
    local($n,$xpts,$ypts) = @_;
    pgline_r($n,fap($xpts),fap($ypts));
}

sub pgncur {
    die 'Usage: pgncur($maxpt,$npt,\@x,\@y,$symbol)' if (scalar(@_)!=5);
    local($maxpt,$npt,$x,$y,$symbol) =@_;
    local($xstr,$ystr);
    for($i=$npt; $i<$maxpt; $i++) {  # Expand array
       $$x[$i]=0;
       $$y[$i]=0;
    }
    $xstr = fap($x);
    $ystr = fap($y);
    pgncur_r($maxpt,$npt,$xstr,$ystr,$symbol);
    @$x = unpack("f*",$xstr);
    @$y = unpack("f*",$ystr);
    $_[1]=$npt; 
}

sub pgolin {
    die 'Usage: pgncur($maxpt,$npt,\@x,\@y,$symbol)' if (scalar(@_)!=5);
    local($maxpt,$npt,$x,$y,$symbol) =@_;
    local($xstr,$ystr);
    for($i=$npt; $i<$maxpt; $i++) {  # Expand array
       $$x[$i]=0;
       $$y[$i]=0;
    }
    $xstr = fap($x);
    $ystr = fap($y);
    pgolin_r($maxpt,$npt,$xstr,$ystr,$symbol);
    @$x = unpack("f*",$xstr);
    @$y = unpack("f*",$ystr);
    $_[1]=$npt; 
}

sub pgpixl {
    die 'Usage: pgpnts(\@ia,$idim,$jdim,$i1,$i2,$j1,$j2,$x1,$x2,$y1,$y2)' if (scalar(@_)!=11);
    local($ia,$idim,$jdim,$i1,$i2,$j1,$j2,$x1,$x2,$y1,$y2) = @_;
    pgpixl_r(iap2D($ia),$idim,$jdim,$i1,$i2,$j1,$j2,$x1,$x2,$y1,$y2);
}


sub pgpnts {
    die 'Usage: pgpnts($n,\@x,\@y,\@symbol,$ns)' if (scalar(@_)!=5);
    local($n,$x,$y,$symbol,$ns) = @_;
    pgpnts_r($n,fap($x),fap($y),iap($symbol),$ns);
}

sub pgpoint {pgpt(@_)}

sub pgpoly {
    die 'Usage: pgpoly($n,\@xpts,\@ypts)' if (scalar(@_)!=3);
    local($n,$xpts,$ypts) = @_;
    pgpoly_r($n,fap($xpts),fap($ypts));
}

sub pgpt {
    die 'Usage: pgpt($n,\@xpts,\@ypts,$symbol)' if (scalar(@_)!=4);
    local($n,$xpts,$ypts,$symbol) = @_;
    pgpt_r($n,fap($xpts),fap($ypts),$symbol);
}

sub pgvect {
    die 'Usage: pgvect(\@a,\@b,$idim,$jdim,$i1,$i2,$j1,$j2,$c,$nc,\@tr,$blank)' if (scalar(@_)!=12);
    local($a,$b,$idim,$jdim,$i1,$i2,$j1,$j2,$c,$nc,$tr,$blank) = @_;
    pgvect_r(fap2D($a),fap2D($b),$idim,$jdim,$i1,$i2,$j1,$j2,$c,$nc,fap($tr),$blank);
}


;# New pgplot 5.0 array routines

sub pgconl{
    die 'Usage: pgconl(\@a,$idim,$jdim,$i1,$i2,$j1,$j2,$c,\@tr,$label,$intval,$minint)' if (scalar(@_)!=12);
    local($a,$idim,$jdim,$i1,$i2,$j1,$j2,$c,$tr,$label,$intval,$minint) = @_;
    pgconl_r(fap2D($a),$idim,$jdim,$i1,$i2,$j1,$j2,$c,fap($tr),$label,$intval,$minint);
}

sub pgctab{
    die 'Usage: pgctab(\@l,\@r,\@g,\@b,$nc,$contra,$bright)' if (scalar(@_)!=7);
    local($l,$r,$g,$b,$nc,$contra,$bright) = @_;
    pgctab_r(fap($l),fap($r),fap($g),fap($b),$nc,$contra,$bright);
}

sub pgimag {
    die 'Usage: pgimag(\@a,$idim,$jdim,$i1,$i2,$j1,$j2,$a1,$a2,\@tr)' if (scalar(@_)!=10);
    local($a,$idim,$jdim,$i1,$i2,$j1,$j2,$a1,$a2,$tr) = @_;
    pgimag_r(fap2D($a),$idim,$jdim,$i1,$i2,$j1,$j2,$a1,$a2,fap($tr));
}

sub pgqtxt {
    die 'Usage: pgqtxt($x,$y,$angle,$fjust,$text,\@xbox,\@ybox)' if (scalar(@_)!=7);
    local($x,$y,$angle,$fjust,$text,$xbox,$ybox) = @_;
    local($i,$xstr,$ystr);
    for (0,1,2,3){  # Make sure array is big enough
        ($$xbox[$_],$$ybox[$_]) = (0,0);
    }
    $xstr = fap($xbox);  # Set blank strings of right size
    $ystr = fap($ybox);
    pgqtxt_r($x,$y,$angle,$fjust,$text,$xstr,$ystr);
    @$xbox = unpack("f*",$xstr);  # Return values
    @$ybox = unpack("f*",$ystr);
}

;# Single point routines provided for backwards compatability
;# with old perl4 version of pgperl - note array routines 
;# can now be used directly, e.g.: pgpt(1,$x,$y,$symbol) etc.

sub pgerrb1 {
    die 'Usage: &pgerrb1($dir,$x,$y,$e,$t)' if (scalar(@_)!=5);
    local($dir,$x,$y,$e,$t) = @_;
    pgerrb($dir,1,$x,$y,$e,$t);
}

sub pgerrx1 {
    die 'Usage: &pgerrx1($x1,$x2,$y,$t)' if (scalar(@_)!=4);
    local($x1,$x2,$y,$t) = @_;
    pgerrx(1,$x1,$x2,$y,$t);
}

sub pgerry1 {
    die 'Usage: &pgerry1($x,$y1,$y2,$t)' if (scalar(@_)!=4);
    local($x,$y1,$y2,$t) = @_;
    pgerry(1,$x,$y1,$y2,$t);
}

sub pgpoint1 {pgpt1(@_)}

sub pgpt1 {
    die 'Usage: &pgpt1($xpts,$ypts,$symbol)' if (scalar(@_)!=3);
    local($xpts,$ypts,$symbol) = @_;
    pgpt(1,$xpts,$ypts,$symbol);
}

;# Version info     

sub pgperlv {   
  print "-"x55,"\n"; 
  print "pgperl v1.0b - perl5 code for PGPLOT v5.0.2\n\n";
  pgperlcv(); print "\n";
  print "Comments to: kgb\@ast.cam.ac.uk\n";
  print "WWW info:    http://www.ast.cam.ac.uk/~kgb/pgperl.html\n";
  print "-"x55,"\n";
}

;# Exit with OK status

1;

