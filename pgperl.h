
/* 
   pgperl.h

   This file contains miscelleneous C code which is required
   to initialise pgperl and handle C<->perl function passing. 

   This version for perl5.

   Karl Glazebrook [email: kgb@ast.cam.ac.uk]

   pgperl WWW info: http://www.ast.cam.ac.uk/~kgb/pgperl.html

*/

/* Alternate ways of calling F77 from C */

#ifdef NO_TRAILING_USCORE

#define PGFUNX pgfunx
#define PGFUNY pgfuny
#define PGFUNT pgfunt
#define PGCONX pgconx

#else

#define PGFUNX pgfunx_
#define PGFUNY pgfuny_
#define PGFUNT pgfunt_
#define PGCONX pgconx_

#endif


/* Prototypes */

static char*  pgfunname[2];
float pgfun1();
float pgfun2();
int   pgfunplot();


/* CPGPLOT prototypes missing in PGPLOT 5 - these handle passed
functions. Mechanism used below only works with standard UNIX
C/F77 passing so only enabled if compiled with -DHAS_UNIX_FUNCTIONS
otherwise it causes an error */


cpgfunx (float pgfun1(), int n, float xmin, float xmax, int pgflag) {

#ifdef HAS_UNIX_FUNCTIONS

   PGFUNX(pgfun1,&n,&xmin,&xmax,&pgflag);

#else

   croak("PGPLOT routine pgfunx not available in this implementation");

#endif

}


cpgfuny (float pgfun1(), int n, float ymin, float ymax, int pgflag) {

#ifdef HAS_UNIX_FUNCTIONS

   PGFUNY(pgfun1,&n,&ymin,&ymax,&pgflag);

#else

   croak("PGPLOT routine pgfuny not available in this implementation");

#endif

}


cpgfunt (float pgfun1(), float pgfun2(), int n, float tmin, float tmax, 
         int pgflag) {

#ifdef HAS_UNIX_FUNCTIONS

   PGFUNT(pgfun1,pgfun2,&n,&tmin,&tmax,&pgflag);

#else

   croak("PGPLOT routine pgfunt not available in this implementation");

#endif

}


cpgconx ( float* a, int idim, int jdim, int i1, int i2, 
          int j1, int j2, float* c, int nc, int pgfunplot()) {

#ifdef HAS_UNIX_FUNCTIONS

   PGCONX(a,&idim,&jdim,&i1,&i2,&j1,&j2,c,&nc,pgfunplot);

#else

   croak("PGPLOT routine pgconx not available in this implementation");

#endif

}

/* The functions we actually pass to f77 - these call back
   to the correct perl function whose names(s) are passed
   via the back door (i.e. char static varables)          */

/* pgplot called function perl intermediate number 1 */

float pgfun1(x)  
   float *x; {

   dSP ;
   int count;
   char* funname;
   float retval;

   funname = pgfunname[0];          /* Pass perl function name */

   ENTER ;
   SAVETMPS ;

   PUSHMARK(sp) ;

   /* Push arguments */

   XPUSHs(sv_2mortal(newSVnv(*x)));

   PUTBACK ;

   /* Call Perl */

   count = perl_call_pv(funname, G_SCALAR);

   SPAGAIN;

   if (count !=1) 
      croak("Error calling perl function\n");

   retval = (float) POPn ;  /* Return value */

   PUTBACK ;
   FREETMPS ;
   LEAVE ;

   return retval;  
}


/* pgplot called function perl intermediate number 2 */

float pgfun2(x)  
   float *x; {

   dSP ;
   int count;
   char* funname;
   float retval;

   funname = pgfunname[1];          /* Pass perl function name */

   ENTER ;
   SAVETMPS ;

   PUSHMARK(sp) ;

   /* Push arguments */

   XPUSHs(sv_2mortal(newSVnv(*x)));

   PUTBACK ;

   /* Call Perl */

   count = perl_call_pv(funname, G_SCALAR);

   SPAGAIN;

   if (count !=1) 
      croak("Error calling perl function\n");

   retval = (float) POPn ;  /* Return value */

   PUTBACK ;
   FREETMPS ;
   LEAVE ;

   return retval;  
}

/* pgplot called function perl intermediate for PGCONX */

int pgfunplot(visible,x,y,z)  
   int *visible;
   float *x,*y,*z; {

   dSP ;
   int count;
   char* funname;
   float retval;

   funname = pgfunname[0];          /* Pass perl function name */

   ENTER ;
   SAVETMPS ;

   PUSHMARK(sp) ;

   /* Push arguments */

   XPUSHs(sv_2mortal(newSViv(*visible)));
   XPUSHs(sv_2mortal(newSVnv(*x)));
   XPUSHs(sv_2mortal(newSVnv(*y)));
   XPUSHs(sv_2mortal(newSVnv(*z)));

   PUTBACK ;

   /* Call Perl */

   count = perl_call_pv(funname, G_SCALAR);

   SPAGAIN;

   if (count !=1) 
      croak("Error calling perl function\n");


   PUTBACK ;
   FREETMPS ;
   LEAVE ;
}

