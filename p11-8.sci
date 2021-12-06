//******************************************************************
// Problem P11-8
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

function  i = calcStackedArrayCurrent(z11,z12,z13,z14,z23)
  r11 = real(z11);
  r12 = real(z12);
  r13 = real(z13);
  r14 = real(z14);
  r23 = real(z23);
  a2 = 2*(r11 + r12 - r13) - r23 - r14;
  i = sqrt(1/a2);
endfunction

function i = calcW8JKArrayCurrent(z11,z12,z13,z14)
  r11 = real(z11);
  r12 = real(z12);
  r13 = real(z13);
  r14 = real(z14);
  a2 = 2*(r11 + r14 - r12 - r13);
  i = sqrt(1/a2);
endfunction

function  i = calcDipoleCurrent(z11)
  r11 = real(z11);
  i = sqrt(1/r11);
endfunction

function x = calcDipoleEH(phi)
  a = size(phi);
  a = a(2);
  x = ones(1,a);
endfunction

function x = calcStackedArrayE(phi,d,h)
  psi1 = 2*%pi*h*sin(phi);
  psi2 = 2*%pi*(h-d)*sin(phi);
  x = 2*(sin(psi1) + sin(psi2));
endfunction

function x = calcW8JKArrayE(phi,d,h)
  psi1 = 2*%pi*d*cos(phi);
  psi2 = 2*%pi*2*h*sin(phi);
  psi3 = psi1 + psi2;
  x = 1 - exp(%i*psi1) - exp(%i*psi2) + exp(%i*psi3);
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
phi = 10*%pi/180;
ds = 0.5
dw = 0.125;
hs=(ds+0.0001):1.5/50:1.5;
hw=0.1:1.5/50:1.5;
n = 1;
l = 0.5;
beta = 2*%pi;

//******************************************************************
// construct stacked array gain vector
//******************************************************************
hlength = size(hs);    // compute upper limit of loop
hlength = hlength(2);

z11 = calcZ11(n);
dipoleE = calcDipoleEH(phi);
dipoleI = calcDipoleCurrent(z11);
dipoleE = abs(dipoleI * dipoleE);

for i=1:1:hlength
  ds12 = ds;
  ds13 = 2*hs(i) - ds;
  ds14 = 2*hs(i);
  ds23 = 2*(hs(i)-ds);
  z12 = calcZ21(l,ds12);
  z13 = calcZ21(l,ds13);
  z14 = calcZ21(l,ds14);
  z23 = calcZ21(l,ds23);
  I = calcStackedArrayCurrent(z11,z12,z13,z14,z23);
  E = calcStackedArrayE(phi,ds,hs(i));
  E = abs(I * E);
  stackedArrayG(i) = E / dipoleE;
end

//******************************************************************
// construct W8JK array gain vector
//******************************************************************
hlength = size(hw);    // compute upper limit of loop
hlength = hlength(2);

z11 = calcZ11(n);
dipoleE = calcDipoleEH(phi);
dipoleI = calcDipoleCurrent(z11);
dipoleE = abs(dipoleI * dipoleE);

for i=1:1:hlength
  dw12 = dw;
  dw13 = 2*hw(i);
  dw14 = sqrt(dw*dw + 4*hw(i)*hw(i));
  z12 = calcZ21(l,dw12);
  z13 = calcZ21(l,dw13);
  z14 = calcZ21(l,dw14);
  I = calcW8JKArrayCurrent(z11,z12,z13,z14);
  E = calcW8JKArrayE(phi,dw,hw(i));
  E = abs(I * E);
  W8JKArrayG(i) = E / dipoleE;
end
  
//******************************************************************
// plot array gains
//******************************************************************
set("figure_style","new");
p = get("hdl");
p.title.text = "Gain of Stacked Array and W8JK Array";
p.x_label.text = "Height above ground, lambda";
p.y_label.text = "Gain [AAG/HWFS]";
p.grid = [1 1];

p.line_style = 5;
plot2d(hs,stackedArrayG);

p.line_style = 0;
plot2d(hw,W8JKArrayG);
