//******************************************************************
// Problem P11-1
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

function z11 = calcZ11(n)
  r11 = 30 * cin(2*%pi*n);
  x11 = 30 * si(2*%pi*n);
  z11 = r11 + %i*x11;
endfunction

function z21 = calcZ21(l,d)
  a1 = beta*d;
  a2 = beta*(sqrt(d*d + l*l) + l);
  a3 = beta*(sqrt(d*d + l*l) - l);
  r21 = 30*(2*ci(a1) - ci(a2) - ci(a3));
  x21 = -30*(2*si(a1) - si(a2) - si(a3));
  z21 = r21 + %i*x21;
endfunction

function x = calcDipoleEH(phi)
  a = size(phi);
  a = a(2);
  x = ones(1,a);
endfunction

function x = calcDipoleV(theta)
  x1 = cos((%pi/2)*cos(theta));
  x2 = sin(theta);
  m = find(x2 == 0);
  x2(m) = 0.000001;
  x = x1./x2;
endfunction

function x = calcArrayEh(phi)
  x = 2*cos((%pi/2)*cos(phi));
endfunction

function x = calcArrayEv(theta)
  x1 = cos((%pi/2)*cos(theta));
  x2 = sin(theta);
  m = find(x2 == 0);
  x2(m) = 0.000001;
  x = 2*x1./x2;
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 0:%pi/100:2*%pi;
theta = -%pi:%pi/100:%pi;
d = 0:0.1:2;
d(1) = 0.0011;
n = 1;
l = 0.5;
beta = 2*%pi;


//******************************************************************
// compute self resistance and self reactance terms
//******************************************************************
z11 = calcZ11(n);
r11 = real(z11);
r00 = real(z11);

//******************************************************************
// construct gain vector
//******************************************************************
dlength = size(d);      // compute upper limit of loop
dlength = dlength(2); 

// construct multual resistance vector
for i=1:1:dlength
  r12(i) = real(calcZ21(l,d(i)));
  i = i + 1;
end

gf = sqrt(2*r00 ./(r11 + r12));


//******************************************************************
// Construct fields for dipole and array
//******************************************************************
eDipoleH = calcDipoleEH(phi);
eDipoleV = calcDipoleV(theta);
eArrayH = calcArrayEh(phi);
eArrayV = calcArrayEv(theta);

//******************************************************************
// plot of gain
//******************************************************************
subplot(221);
plot2d(d,gf);

//******************************************************************
//******************************************************************
subplot(223);
x = abs(eDipoleH) .* cos(phi);
y = abs(eDipoleH) .* sin(phi);
plot2d(y,x);

x = abs(eArrayH) .* cos(phi);
y = abs(eArrayH) .* sin(phi);
plot2d(y,x);
//******************************************************************
//******************************************************************
subplot(224);
x = abs(eDipoleV) .* cos(phi);
y = abs(eDipoleV) .* sin(phi);
plot2d(y,x);

x = abs(eArrayV) .* cos(phi);
y = abs(eArrayV) .* sin(phi);
plot2d(y,x);
