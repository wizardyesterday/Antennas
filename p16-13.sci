//******************************************************************
// Problem P16-13
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

function gf = calcGain(r11,r12,rl,h)
  nu = r11 + rl;
  de = r11 + rl - r12;
  gf = 2 * sqrt(nu ./ de) .* abs(sin(2*%pi*h));
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
n = 1;
l = 0.5;
beta = 2*%pi;
rl1 = 0;
rl2 = 1;
h = 0:0.01:1;
h(1) = 0.001;

//******************************************************************
// compute self and mutual resistances
//******************************************************************

// computer upper limit of loop
hlength = size(h);
hlength = hlength(2);

// compute self resistance vector
r11 = real(calcZ11(n)) * ones(1,hlength);

// compute mutual resistance vector
for i=1:1:hlength
  d = 2 * h(i);
  r12(i) = real(calcZ21(l,d));
end

// transpose for later
r12 = r12';

//******************************************************************
// compute gains
//******************************************************************
h(1) = 0;
gain1 = calcGain(r11,r12,rl1,h);
gain2 = calcGain(r11,r12,rl2,h);

//******************************************************************
// plot gains
//******************************************************************
set("figure_style","new");

subplot(211);
title("Gain of Half Wave Dipole Above a Conducting Sheet (RL = 0)");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "Height Above Sheet, lamda";
a.y_label.text = "Gain";
plot2d(h,gain1)

subplot(212);
title("Gain of Half Wave Dipole Above a Conducting Sheet (RL = 1 ohm)");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "Height Above Sheet, lamda";
a.y_label.text = "Gain";
plot2d(h,gain2)

