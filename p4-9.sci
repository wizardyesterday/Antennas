phi = 0:%pi/200:%pi;
phi(1) = 0.00001;
n = 10;
d = 3/8;
deltaA = -3*%pi/4;
Ea = En(n,d,deltaA,phi);
deltaB = -%pi*(3/4 + 1/n);
Eb = En(n,d,deltaB,phi);
theta = 0:0180/200:180;
subplot(211);
plot2d(theta,Ea);
subplot(212);
plot2d(theta,Eb);
