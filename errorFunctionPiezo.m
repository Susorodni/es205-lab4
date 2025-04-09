function E = errorFunctionPiezo(z,vData,tData,k,theta)
 y0 = z(1);
 m = z(2);
 c = z(3);

 options = odeset('AbsTol', 0.00001, 'RelTol', 0.00001);
 q0 = [y0; 0; vData(1)]; % initial conditions
 [~, q] = ode45(@ODEpiezo, tData, q0, options, m, k, c, theta);

 v = q(:,3);
 
 E = norm(vData - v);
 end
