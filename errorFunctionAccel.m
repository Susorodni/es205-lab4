function E = errorFunctionAccel(z,aData,tData,k)
 y0 = z(1);
 m = z(2);
 c = z(3);

 options = odeset('AbsTol', 0.00001, 'RelTol', 0.00001);
 q0 = [y0; 0]; % initial conditions
 [~, q] = ode45(@ODEbeam, tData, q0, options, m, k, c);

 y = q(:,1);
 ydot = q(:,2);
 aModel = -(1/m)*(c*ydot + k*y);
 
 % E = sqrt(sum((aData-aModel).^2));

 E = norm(aData - aModel);
 end
