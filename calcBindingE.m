function Uwb = calcBindingE(thi,ths,thr,thmin,alpha,m,n)

% ths = 0.4856;
% thr = 0.0056;
% alpha = 0.0288;
% n = 1.3794;
% m = 0.275;

th = [thmin:0.0001:thi(i)];
Se = (th - thr)./(ths - thr);
%psi = 1/alpha * (1/(Se^(1/m))-1)^(1/n) * 98.0665; %[cm] -> [Pa]
psi = 1./alpha * (1./(Se.^(1/m))-1).^(1/n) ./ 100; %[cm] -> [m]

Uwb = -sum(psi); %[m]

end