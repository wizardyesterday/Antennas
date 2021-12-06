//******************************************************************
// Problem P10-3
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function a = cin(x)
  v = 0:.01:x;
  v(1) = .0000001;
  i = (1 - cos(v)) ./ v;
  a = inttrap(v,i);
endfunction

function a = si(x)
  v = 0:.01:x;
  v(1) = .0000001;
  i = sin(v) ./ v;
  a = inttrap(v,i);
endfunction

function a = ci(x)
  a = 0.577 + log(x) - cin(x);
endfunction

function z21 = calcZ21(l,d,h)
  a = beta*(sqrt(d*d + h*h) + h);
  ap = beta*(sqrt(d*d + h*h) - h);
  b = beta*(sqrt(d*d + (h-1)*(h-l)) + (h-l));
  bp = beta*(sqrt(d*d + (h-1)*(h-l)) - (h-l));
  c = beta*(sqrt(d*d + (h+1)*(h+l)) + (h+l));
  cp = beta*(sqrt(d*d + (h+1)*(h+l)) - (h+l));

  rcos  = -15*cos(beta*h)*(-2*ci(a)-2*ci(ap)+ci(b)+ci(bp)+ci(c)+ci(cp));
  rsin  = 15*sin(beta*h)*(2*si(a)-2*si(ap)-si(b)+si(bp)-si(c)+si(cp));
  r21 = rcos + rsin;

  xcos  = -15*cos(beta*h)*(2*si(a)+2*si(ap)-si(b)-si(bp)-si(c)-si(cp));
  xsin  = 15*sin(beta*h)*(2*ci(a)-2*ci(ap)-ci(b)+ci(bp)-ci(c)+ci(cp));
  x21 = xcos + xsin;

  z21 = r21 + %i*x21;
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
l = 0.5;
d = 0.25;
h = 1.25;
beta = 2*%pi;

//******************************************************************
// compute mutual resistance and mutual reactance terms
//******************************************************************
z21 = calcZ21(l,d,h);
