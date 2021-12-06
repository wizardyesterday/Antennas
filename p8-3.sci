//******************************************************************
// Problem P8-3
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

function zk = calcZk(thetaHc)
  zk = 120*log(cotg(thetaHc/2));
endfunction

function rm = calcRm(bl)
  r1 = 60 * cin(2*bl);
  r2 = 0.577 + log(bl) - 2*ci(2*bl) + ci(4*bl);
  r2 = r2 .* cos(2*bl) * 30;
  r3 = si(4*bl) - 2*si(2*bl);
  r3 = r3 .* sin(2*bl) * 30;
  rm = r1 + r2 + r3;
endfunction

function xm = calcXm(bl)
  x1 = 60 * si(2*bl);
  x2 = ci(4*bl) - log(bl) - 0.577;
  x2 = x2 .* sin(2*bl) * 30;
  x3 = -30 * si(4*bl) .* cos(2*bl);
  xm = x1 + x2 + x3;
endfunction

function zi = calcZi(bl,thetaHc)
  zk = calcZk(thetaHc);

  rm = calcRm(bl);
  xm = calcXm(bl);
  zm = rm + %i*xm;

  znum = zk + %i*zm*tan(bl);
  zden = zm + %i*zk*tan(bl);

  zi = zk .* znum ./ zden;
  zi = zi / 2;
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
betaL = 3*%pi/4;
thetaHc = %pi/180;

//******************************************************************
// compute input impedance of conical antenna
//******************************************************************
zi = calcZi(betaL,thetaHc);
