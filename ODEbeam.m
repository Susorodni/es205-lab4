% DE Model of the clamped beam

function qdot = ODEbeam(~, q, m, k, c)
    y = q(1);
    ydot = q(2);

    yddot = -(1/m)*(c*ydot + k*y);

    qdot = [ydot; yddot];
end