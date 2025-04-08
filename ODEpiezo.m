% DE Model of the whole system

function qdot = ODEpiezo(~, q, m, k, c, theta)
    RL = 10000; % ohms
    Cp = 9.62e-9; % nanofarads

    y = q(1);
    ydot = q(2);

    v = q(3);

    yddot = -(1/m)*(c*ydot + k*y);
    vdot = (theta/(Cp*c))*(m*yddot + k*y) - (1/(Cp*RL))*v;

    qdot = [ydot; yddot; vdot];
end