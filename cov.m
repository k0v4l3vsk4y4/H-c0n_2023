% Aquest  codi calcula covariancia creuada entre un vector v (wm) i diferents
% vectors r (guesses)
clear


v= [1 0 1 0 1 0]; 
r1 = [0.2559    0.2699         0    1.0000    0.2559    0.2275];
r2 = [0.8373    0.0341    0.4463         0    1.0000    0.0656];
r3 = [1.0000    0.4923    0.8129         0    0.1926    0.3563];

figure(1)
hold on
plot(v,".--")
plot(r1)
plot(r2)
plot(r3)
legend("v","r1","r2","r3")
hold off

figure(2)
hold on
plot(abs(xcov(v,r1)))
plot(abs(xcov(v,r2)))
plot(abs(xcov(v,r3)))
legend("cov v-r1","cov v-r2","cov v-r3")
hold off

maxVR1 = max(xcov(v,r1))
maxVR2 = max(xcov(v,r2))
maxVR3 = max(xcov(v,r3))
