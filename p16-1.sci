//******************************************************************
// Problem P16-1
//******************************************************************

//*****************************************************************
// function declarations
//******************************************************************
function x = computeStubImpedance(betaX,z0)
  x = (-%i * z0) ./ tan(betaX);
endfunction

function x = computeRhoV(z0,zL)
  x = (zL - z0) ./ (zL + z0);
endfunction

function x = computeVswr(rhoV)
  x = (1 + abs(rhoV)) ./ (1 - abs(rhoV));
endfunction

//******************************************************************
// main code
//******************************************************************

//******************************************************************
// set parameters
//******************************************************************
z0 = 65;
z0c = 40;
betaX = (0.7:0.05:1.3) * %pi;

zA = [2.3171E+01 - %i*2.2874E+02;
      2.7747E+01 - %i*1.9002E+02;
      3.3055E+01 - %i*1.5386E+02;
      3.9224E+01 - %i*1.1963E+02;
      4.6413E+01 - %i*8.6826E+01;
      5.4822E+01 - %i*5.5049E+01;
      6.4696E+01 - %i*2.3954E+01;
      7.6344E+01 + %i*6.7348E+00;
      9.0154E+01 + %i*3.7234E+01;
      1.0662E+02 + %i*6.7691E+01;
      1.2636E+02 + %i*9.8156E+01;
      1.5018E+02 + %i*1.2855E+02;
      1.7905E+02 + %i*1.5856E+02]';

frequency = 210:15:390;

//******************************************************************
// compute VSWR
//******************************************************************

// compute input impedance of stub
zic = computeStubImpedance(betaX,z0c);

// compute impedance seen by transmission line
zComposite = (zic .* zA) ./ (zic + zA);

// compute voltage reflection coefficient
rhoV = computeRhoV(z0,zComposite);

// compute VSWR
vswr = computeVswr(rhoV);

//******************************************************************
// plot VSWR
//******************************************************************
set("figure_style","new");

title("VSWR Versus Frequency For Dipole Antenna With Stub");
a = gca();
a.margins = [0.125 0.2 0.125 0.125];
a.margins = [0.125 0.2 0.125 0.2];
a.grid = [1 1];
a.x_label.text = "Frequency, MHz";
a.y_label.text = "VSWR";
plot2d(frequency,vswr);

