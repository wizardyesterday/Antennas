//******************************************************************
// Problem P11-37
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = calcApertureField(a,phi)
  psi = %pi*a*sin(phi);
  x1 = sin(psi);
  x2 = psi;
  m = find(x1 == 0);
  x1(m) = 0.000001
  m = find(x2 == 0);
  x2(m) = 0.000001;
  x = x1./x2;
endfunction

function x = calcDipoleField(d,phi)
  psi = 2*%pi*d*sin(phi);
  x = cos(psi/2);
endfunction

function x = calcSolidAngle(a,d)
  phi = 0:%pi/100:2*%pi;

  Eaperture = calcApertureField(a,phi);
  Edipole = calcDipoleField(d,phi);
  E = Eaperture .* Edipole;
  i = E .* E;

  x = inttrap(phi,i);
  x = x * 2;
endfunction

//******************************************************************
// main code
//******************************************************************
phiNull = asin(1/10);
phi = -phiNull:phiNull/100:phiNull;
aLamda = 10;
dLamda = 60;

// Calculate field of single aperture
Eaperture = calcApertureField(aLamda,phi);

// Calculate composite field
Edipole = calcDipoleField(dLamda,phi);
E = Eaperture .* Edipole;

// Calculate solid angle
omegaA = calcSolidAngle(aLamda,dLamda);

// Calculate effective aperture
Ae = 1 / omegaA;

//******************************************************************
// plot fields
//******************************************************************
set("figure_style","new");

title("Interferometer Pattern, Square Aperture: 20 lamda, Spacing 60 lamda");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "phi, degrees"; 
a.y_label.text = "|E|";
plot(phi*180/%pi,abs(E));
