
/* 
   PGPLOT.xs   v1.0a

   This file contains the routines provide the glue which 
   allow perl5 to call C and hence f77/pgplot via the CPGPLOT
   library. See the file INSTALLATION.perl5 for pgperl building 
   instructions and README for copyright/licensing information.

   Karl Glazebrook [email: kgb@ast.cam.ac.uk]

   Built Tue Jun 13 15:07:32 BST 1995 for PGPLOT v5.0.1

   pgperl WWW info: http://www.ast.cam.ac.uk/~kgb/pgperl.html

*/

#include "EXTERN.h"   /* std perl include */
#include "perl.h"     /* std perl include */
#include "XSUB.h"     /* XSUB include */
#include "cpgplot.h"  /* CPGPLOT prototypes */
#include "pgperl.h"   /* Routines for function passing */

/* Buffer for routines that return a string - fortunately
   there are no routines that return 2 strings!            */
   
static char strbuff[256]; 
#define SIZEOF(X) sizeof(strbuff)


MODULE = PGPLOT     PACKAGE = PGPLOT 


void
pgarro(x1,y1,x2,y2)
  float	x1
  float	y1
  float	x2
  float	y2
  CODE:
    cpgarro(x1,y1,x2,y2);


void
pgask(flag)
  Logical	flag
  CODE:
    cpgask(flag);


int
pgband(mode,posn,xref,yref,x,y,ch)
  int	mode
  int	posn
  float	xref
  float	yref
  float	x
  float	y
  char	ch = NO_INIT
  CODE:
    RETVAL = cpgband(mode,posn,xref,yref,&x,&y,&ch);
  OUTPUT:
  x
  y
  ch
  RETVAL


void
pgbbuf()
  CODE:
    cpgbbuf();


int
pgbeg(unit,file,nxsub,nysub)
  int	unit
  char *	file
  int	nxsub
  int	nysub
  CODE:
    RETVAL = cpgbeg(unit,file,nxsub,nysub);
  OUTPUT:
  RETVAL


int
pgbegin(unit,file,nxsub,nysub)
  int	unit
  char *	file
  int	nxsub
  int	nysub
  CODE:
    RETVAL = cpgbeg(unit,file,nxsub,nysub);
  OUTPUT:
  RETVAL


void
pgbin_r(nbin,x,data,center)
  int	nbin
  float *	x
  float *	data
  Logical	center
  CODE:
    cpgbin(nbin,x,data,center);


void
pgbox(xopt,xtick,nxsub,yopt,ytick,nysub)
  char *	xopt
  float	xtick
  int	nxsub
  char *	yopt
  float	ytick
  int	nysub
  CODE:
    cpgbox(xopt,xtick,nxsub,yopt,ytick,nysub);


void
pgcirc(xcent,ycent,radius)
  float	xcent
  float	ycent
  float	radius
  CODE:
    cpgcirc(xcent,ycent,radius);


void
pgconb_r(a,idim,jdim,i1,i2,j1,j2,c,nc,tr,blank)
  float *	a
  int	idim
  int	jdim
  int	i1
  int	i2
  int	j1
  int	j2
  float *	c
  int	nc
  float *	tr
  float	blank
  CODE:
    cpgconb(a,idim,jdim,i1,i2,j1,j2,c,nc,tr,blank);


void
pgconl_r(a,idim,jdim,i1,i2,j1,j2,c,tr,label,intval,minint)
  float *	a
  int	idim
  int	jdim
  int	i1
  int	i2
  int	j1
  int	j2
  float	c
  float *	tr
  char *	label
  int	intval
  int	minint
  CODE:
    cpgconl(a,idim,jdim,i1,i2,j1,j2,c,tr,label,intval,minint);


void
pgcons_r(a,idim,jdim,i1,i2,j1,j2,c,nc,tr)
  float *	a
  int	idim
  int	jdim
  int	i1
  int	i2
  int	j1
  int	j2
  float *	c
  int	nc
  float *	tr
  CODE:
    cpgcons(a,idim,jdim,i1,i2,j1,j2,c,nc,tr);


void
pgcont_r(a,idim,jdim,i1,i2,j1,j2,c,nc,tr)
  float *	a
  int	idim
  int	jdim
  int	i1
  int	i2
  int	j1
  int	j2
  float *	c
  int	nc
  float *	tr
  CODE:
    cpgcont(a,idim,jdim,i1,i2,j1,j2,c,nc,tr);


void
pgconx_r(a,idim,jdim,i1,i2,j1,j2,c,nc,plot)
  float *	a
  int	idim
  int	jdim
  int	i1
  int	i2
  int	j1
  int	j2
  float *	c
  int	nc
  char *	plot
  CODE:
    pgfunname[0] = plot;
    cpgconx(a,idim,jdim,i1,i2,j1,j2,c,nc,pgfunplot);


void
pgctab_r(l,r,g,b,nc,contra,bright)
  float *	l
  float *	r
  float *	g
  float *	b
  int	nc
  float	contra
  float	bright
  CODE:
    cpgctab(l,r,g,b,nc,contra,bright);


int
pgcurs(x,y,ch)
  float	x
  float	y
  char	ch = NO_INIT
  CODE:
    RETVAL = cpgcurs(&x,&y,&ch);
  OUTPUT:
  x
  y
  ch
  RETVAL


int
pgcurse(x,y,ch)
  float	x
  float	y
  char	ch = NO_INIT
  CODE:
    RETVAL = cpgcurs(&x,&y,&ch);
  OUTPUT:
  x
  y
  ch
  RETVAL


void
pgdraw(x,y)
  float	x
  float	y
  CODE:
    cpgdraw(x,y);


void
pgebuf()
  CODE:
    cpgebuf();


void
pgend()
  CODE:
    cpgend();


void
pgenv(xmin,xmax,ymin,ymax,just,axis)
  float	xmin
  float	xmax
  float	ymin
  float	ymax
  int	just
  int	axis
  CODE:
    cpgenv(xmin,xmax,ymin,ymax,just,axis);


void
pgeras()
  CODE:
    cpgeras();


void
pgerrb_r(dir,n,x,y,e,t)
  int	dir
  int	n
  float *	x
  float *	y
  float *	e
  float	t
  CODE:
    cpgerrb(dir,n,x,y,e,t);


void
pgerrx_r(n,x1,x2,y,t)
  int	n
  float *	x1
  float *	x2
  float *	y
  float	t
  CODE:
    cpgerrx(n,x1,x2,y,t);


void
pgerry_r(n,x,y1,y2,t)
  int	n
  float *	x
  float *	y1
  float *	y2
  float	t
  CODE:
    cpgerry(n,x,y1,y2,t);


void
pgetxt()
  CODE:
    cpgetxt();


void
pgfunt(fx,fy,n,tmin,tmax,pgflag)
  char *	fx
  char *	fy
  int	n
  float	tmin
  float	tmax
  int	pgflag
  CODE:
    pgfunname[0] = fx;
    pgfunname[1] = fy;
    cpgfunt(pgfun1,pgfun2,n,tmin,tmax,pgflag);


void
pgfunx(fy,n,xmin,xmax,pgflag)
  char *	fy
  int	n
  float	xmin
  float	xmax
  int	pgflag
  CODE:
    pgfunname[0] = fy;
    cpgfunx(pgfun1,n,xmin,xmax,pgflag);


void
pgfuny(fx,n,ymin,ymax,pgflag)
  char *	fx
  int	n
  float	ymin
  float	ymax
  int	pgflag
  CODE:
    pgfunname[0] = fx;
    cpgfuny(pgfun1,n,ymin,ymax,pgflag);


void
pggray_r(a,idim,jdim,i1,i2,j1,j2,fg,bg,tr)
  float *	a
  int	idim
  int	jdim
  int	i1
  int	i2
  int	j1
  int	j2
  float	fg
  float	bg
  float *	tr
  CODE:
    cpggray(a,idim,jdim,i1,i2,j1,j2,fg,bg,tr);


void
pghi2d_r(data,nxv,nyv,ix1,ix2,iy1,iy2,x,ioff,bias,center,ylims)
  float *	data
  int	nxv
  int	nyv
  int	ix1
  int	ix2
  int	iy1
  int	iy2
  float *	x
  int	ioff
  float	bias
  Logical	center
  float *	ylims
  CODE:
    cpghi2d(data,nxv,nyv,ix1,ix2,iy1,iy2,x,ioff,bias,center,ylims);


void
pghist_r(n,data,datmin,datmax,nbin,pgflag)
  int	n
  float *	data
  float	datmin
  float	datmax
  int	nbin
  int	pgflag
  CODE:
    cpghist(n,data,datmin,datmax,nbin,pgflag);


void
pgiden()
  CODE:
    cpgiden();


void
pgimag_r(a,idim,jdim,i1,i2,j1,j2,a1,a2,tr)
  float *	a
  int	idim
  int	jdim
  int	i1
  int	i2
  int	j1
  int	j2
  float	a1
  float	a2
  float *	tr
  CODE:
    cpgimag(a,idim,jdim,i1,i2,j1,j2,a1,a2,tr);


void
pglab(xlbl,ylbl,toplbl)
  char *	xlbl
  char *	ylbl
  char *	toplbl
  CODE:
    cpglab(xlbl,ylbl,toplbl);


void
pglabel(xlbl,ylbl,toplbl)
  char *	xlbl
  char *	ylbl
  char *	toplbl
  CODE:
    cpglab(xlbl,ylbl,toplbl);


void
pglcur_r(maxpt,npt,x,y)
  int	maxpt
  int	npt
  float *	x
  float *	y
  CODE:
    cpglcur(maxpt,&npt,x,y);
  OUTPUT:
  npt
  x
  y


void
pgldev()
  CODE:
    cpgldev();


void
pglen(units,string,xl,yl)
  int	units
  char *	string
  float	xl = NO_INIT
  float	yl = NO_INIT
  CODE:
    cpglen(units,string,&xl,&yl);
  OUTPUT:
  xl
  yl


void
pgline_r(n,xpts,ypts)
  int	n
  float *	xpts
  float *	ypts
  CODE:
    cpgline(n,xpts,ypts);


void
pgmove(x,y)
  float	x
  float	y
  CODE:
    cpgmove(x,y);


void
pgmtxt(side,disp,coord,fjust,text)
  char *	side
  float	disp
  float	coord
  float	fjust
  char *	text
  CODE:
    cpgmtxt(side,disp,coord,fjust,text);


void
pgmtext(side,disp,coord,fjust,text)
  char *	side
  float	disp
  float	coord
  float	fjust
  char *	text
  CODE:
    cpgmtxt(side,disp,coord,fjust,text);


void
pgncur_r(maxpt,npt,x,y,symbol)
  int	maxpt
  int	npt
  float *	x
  float *	y
  int	symbol
  CODE:
    cpgncur(maxpt,&npt,x,y,symbol);
  OUTPUT:
  npt
  x
  y


void
pgncurse(maxpt,npt,x,y,symbol)
  int	maxpt
  int	npt
  float *	x
  float *	y
  int	symbol
  CODE:
    cpgncur(maxpt,&npt,x,y,symbol);
  OUTPUT:
  npt
  x
  y


void
pgnumb(mm,pp,form,string,nc)
  int	mm
  int	pp
  int	form
  char *	string = NO_INIT
  int	nc = NO_INIT
  CODE:
    string = strbuff;
           nc     = SIZEOF(string); 
    cpgnumb(mm,pp,form,string,&nc);
  OUTPUT:
  string
  nc


void
pgolin_r(maxpt,npt,x,y,symbol)
  int	maxpt
  int	npt
  float *	x
  float *	y
  int	symbol
  CODE:
    cpgolin(maxpt,&npt,x,y,symbol);
  OUTPUT:
  npt
  x
  y


void
pgpage()
  CODE:
    cpgpage();


void
pgadvance()
  CODE:
    cpgpage();


void
pgpanl(ix,iy)
  int	ix
  int	iy
  CODE:
    cpgpanl(ix,iy);


void
pgpap(width,aspect)
  float	width
  float	aspect
  CODE:
    cpgpap(width,aspect);


void
pgpaper(width,aspect)
  float	width
  float	aspect
  CODE:
    cpgpap(width,aspect);


void
pgpixl_r(ia,idim,jdim,i1,i2,j1,j2,x1,x2,y1,y2)
  int *	ia
  int	idim
  int	jdim
  int	i1
  int	i2
  int	j1
  int	j2
  float	x1
  float	x2
  float	y1
  float	y2
  CODE:
    cpgpixl(ia,idim,jdim,i1,i2,j1,j2,x1,x2,y1,y2);


void
pgpnts_r(n,x,y,symbol,ns)
  int	n
  float *	x
  float *	y
  int *	symbol
  int	ns
  CODE:
    cpgpnts(n,x,y,symbol,ns);


void
pgpoly_r(n,xpts,ypts)
  int	n
  float *	xpts
  float *	ypts
  CODE:
    cpgpoly(n,xpts,ypts);


void
pgpt_r(n,xpts,ypts,symbol)
  int	n
  float *	xpts
  float *	ypts
  int	symbol
  CODE:
    cpgpt(n,xpts,ypts,symbol);


void
pgpoint_r(n,xpts,ypts,symbol)
  int	n
  float *	xpts
  float *	ypts
  int	symbol
  CODE:
    cpgpt(n,xpts,ypts,symbol);


void
pgptxt(x,y,angle,fjust,text)
  float	x
  float	y
  float	angle
  float	fjust
  char *	text
  CODE:
    cpgptxt(x,y,angle,fjust,text);


void
pgptext(x,y,angle,fjust,text)
  float	x
  float	y
  float	angle
  float	fjust
  char *	text
  CODE:
    cpgptxt(x,y,angle,fjust,text);


void
pgqah(fs,angle,vent)
  int	fs = NO_INIT
  float	angle = NO_INIT
  float	vent = NO_INIT
  CODE:
    cpgqah(&fs,&angle,&vent);
  OUTPUT:
  fs
  angle
  vent


void
pgqcf(font)
  int	font = NO_INIT
  CODE:
    cpgqcf(&font);
  OUTPUT:
  font


void
pgqch(size)
  float	size = NO_INIT
  CODE:
    cpgqch(&size);
  OUTPUT:
  size


void
pgqci(ci)
  int	ci = NO_INIT
  CODE:
    cpgqci(&ci);
  OUTPUT:
  ci


void
pgqcir(icilo,icihi)
  int	icilo = NO_INIT
  int	icihi = NO_INIT
  CODE:
    cpgqcir(&icilo,&icihi);
  OUTPUT:
  icilo
  icihi


void
pgqcol(ci1,ci2)
  int	ci1 = NO_INIT
  int	ci2 = NO_INIT
  CODE:
    cpgqcol(&ci1,&ci2);
  OUTPUT:
  ci1
  ci2


void
pgqcr(ci,cr,cg,cb)
  int	ci
  float	cr = NO_INIT
  float	cg = NO_INIT
  float	cb = NO_INIT
  CODE:
    cpgqcr(ci,&cr,&cg,&cb);
  OUTPUT:
  cr
  cg
  cb


void
pgqcs(units,xch,ych)
  int	units
  float	xch = NO_INIT
  float	ych = NO_INIT
  CODE:
    cpgqcs(units,&xch,&ych);
  OUTPUT:
  xch
  ych


void
pgqfs(fs)
  int	fs = NO_INIT
  CODE:
    cpgqfs(&fs);
  OUTPUT:
  fs


void
pgqinf(item,value,length)
  char *	item
  char *	value = NO_INIT
  int	length = NO_INIT
  CODE:
    value = strbuff;
           length = SIZEOF(value);  
    cpgqinf(item,value,&length);
  OUTPUT:
  value
  length


void
pgqitf(itf)
  int	itf = NO_INIT
  CODE:
    cpgqitf(&itf);
  OUTPUT:
  itf


void
pgqls(ls)
  int	ls = NO_INIT
  CODE:
    cpgqls(&ls);
  OUTPUT:
  ls


void
pgqlw(lw)
  int	lw = NO_INIT
  CODE:
    cpgqlw(&lw);
  OUTPUT:
  lw


void
pgqpos(x,y)
  float	x = NO_INIT
  float	y = NO_INIT
  CODE:
    cpgqpos(&x,&y);
  OUTPUT:
  x
  y


void
pgqtbg(tbci)
  int	tbci = NO_INIT
  CODE:
    cpgqtbg(&tbci);
  OUTPUT:
  tbci


void
pgqtxt_r(x,y,angle,fjust,text,xbox,ybox)
  float	x
  float	y
  float	angle
  float	fjust
  char *	text
  float *	xbox
  float *	ybox
  CODE:
    cpgqtxt(x,y,angle,fjust,text,xbox,ybox);
  OUTPUT:
  xbox
  ybox


void
pgqvp(units,x1,x2,y1,y2)
  int	units
  float	x1 = NO_INIT
  float	x2 = NO_INIT
  float	y1 = NO_INIT
  float	y2 = NO_INIT
  CODE:
    cpgqvp(units,&x1,&x2,&y1,&y2);
  OUTPUT:
  x1
  x2
  y1
  y2


void
pgqvsz(units,x1,x2,y1,y2)
  int	units
  float	x1 = NO_INIT
  float	x2 = NO_INIT
  float	y1 = NO_INIT
  float	y2 = NO_INIT
  CODE:
    cpgqvsz(units,&x1,&x2,&y1,&y2);
  OUTPUT:
  x1
  x2
  y1
  y2


void
pgqwin(x1,x2,y1,y2)
  float	x1 = NO_INIT
  float	x2 = NO_INIT
  float	y1 = NO_INIT
  float	y2 = NO_INIT
  CODE:
    cpgqwin(&x1,&x2,&y1,&y2);
  OUTPUT:
  x1
  x2
  y1
  y2


void
pgrect(x1,x2,y1,y2)
  float	x1
  float	x2
  float	y1
  float	y2
  CODE:
    cpgrect(x1,x2,y1,y2);


float
pgrnd(x,nsub)
  float	x
  int	nsub = NO_INIT
  CODE:
    RETVAL = cpgrnd(x,&nsub);
  OUTPUT:
  nsub
  RETVAL


void
pgrnge(x1,x2,xlo,xhi)
  float	x1
  float	x2
  float	xlo = NO_INIT
  float	xhi = NO_INIT
  CODE:
    cpgrnge(x1,x2,&xlo,&xhi);
  OUTPUT:
  xlo
  xhi


void
pgsah(fs,angle,vent)
  int	fs
  float	angle
  float	vent
  CODE:
    cpgsah(fs,angle,vent);


void
pgsave()
  CODE:
    cpgsave();


void
pgunsa()
  CODE:
    cpgunsa();


void
pgscf(font)
  int	font
  CODE:
    cpgscf(font);


void
pgsch(size)
  float	size
  CODE:
    cpgsch(size);


void
pgsci(ci)
  int	ci
  CODE:
    cpgsci(ci);


void
pgscir(icilo,icihi)
  int	icilo
  int	icihi
  CODE:
    cpgscir(icilo,icihi);


void
pgscr(ci,cr,cg,cb)
  int	ci
  float	cr
  float	cg
  float	cb
  CODE:
    cpgscr(ci,cr,cg,cb);


void
pgscrn(ci,name,ier)
  int	ci
  char *	name
  int	ier = NO_INIT
  CODE:
    cpgscrn(ci,name,&ier);
  OUTPUT:
  ier


void
pgsfs(fs)
  int	fs
  CODE:
    cpgsfs(fs);


void
pgshls(ci,ch,cl,cs)
  int	ci
  float	ch
  float	cl
  float	cs
  CODE:
    cpgshls(ci,ch,cl,cs);


void
pgsitf(itf)
  int	itf
  CODE:
    cpgsitf(itf);


void
pgsls(ls)
  int	ls
  CODE:
    cpgsls(ls);


void
pgslw(lw)
  int	lw
  CODE:
    cpgslw(lw);


void
pgstbg(tbci)
  int	tbci
  CODE:
    cpgstbg(tbci);


void
pgsubp(nxsub,nysub)
  int	nxsub
  int	nysub
  CODE:
    cpgsubp(nxsub,nysub);


void
pgsvp(xleft,xright,ybot,ytop)
  float	xleft
  float	xright
  float	ybot
  float	ytop
  CODE:
    cpgsvp(xleft,xright,ybot,ytop);


void
pgvport(xleft,xright,ybot,ytop)
  float	xleft
  float	xright
  float	ybot
  float	ytop
  CODE:
    cpgsvp(xleft,xright,ybot,ytop);


void
pgswin(x1,x2,y1,y2)
  float	x1
  float	x2
  float	y1
  float	y2
  CODE:
    cpgswin(x1,x2,y1,y2);


void
pgwindow(x1,x2,y1,y2)
  float	x1
  float	x2
  float	y1
  float	y2
  CODE:
    cpgswin(x1,x2,y1,y2);


void
pgtbox(xopt,xtick,nxsub,yopt,ytick,nysub)
  char *	xopt
  float	xtick
  int	nxsub
  char *	yopt
  float	ytick
  int	nysub
  CODE:
    cpgtbox(xopt,xtick,nxsub,yopt,ytick,nysub);


void
pgtext(x,y,text)
  float	x
  float	y
  char *	text
  CODE:
    cpgtext(x,y,text);


void
pgupdt()
  CODE:
    cpgupdt();


void
pgvect_r(a,b,idim,jdim,i1,i2,j1,j2,c,nc,tr,blank)
  float *	a
  float *	b
  int	idim
  int	jdim
  int	i1
  int	i2
  int	j1
  int	j2
  float	c
  int	nc
  float *	tr
  float	blank
  CODE:
    cpgvect(a,b,idim,jdim,i1,i2,j1,j2,c,nc,tr,blank);


void
pgvsiz(xleft,xright,ybot,ytop)
  float	xleft
  float	xright
  float	ybot
  float	ytop
  CODE:
    cpgvsiz(xleft,xright,ybot,ytop);


void
pgvsize(xleft,xright,ybot,ytop)
  float	xleft
  float	xright
  float	ybot
  float	ytop
  CODE:
    cpgvsiz(xleft,xright,ybot,ytop);


void
pgvstd()
  CODE:
    cpgvstd();


void
pgvstand()
  CODE:
    cpgvstd();


void
pgwedg(side,disp,width,fg,bg,label)
  char *	side
  float	disp
  float	width
  float	fg
  float	bg
  char *	label
  CODE:
    cpgwedg(side,disp,width,fg,bg,label);


void
pgwnad(x1,x2,y1,y2)
  float	x1
  float	x2
  float	y1
  float	y2
  CODE:
    cpgwnad(x1,x2,y1,y2);


void
pgperlv()
  CODE:
  printf("PGPLOT module v1.0a - C code built Tue Jun 13 15:07:32 BST 1995 for PGPLOT v5.0.1\n");
  printf("Comments to: kgb@ast.cam.ac.uk\n");
  printf("WWW info:    http://www.ast.cam.ac.uk/~kgb/pgperl.html\n");

