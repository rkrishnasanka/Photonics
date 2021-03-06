% dguide.m - TE modes in dielectric slab waveguide
%
% Usage: [be,kc,ac,fc,err] = dguide(lambda,a,n1,n2,Nit)
%        [be,kc,ac,fc,err] = dguide(lambda,a,n1,n2)     (equivalent to Nit=3)
%
% lambda= wavlength of the light
% a     = half-width of slab
% n1,n2 = refractive indices of slab and cladding (n1>n2)
% Nit   = number of Newton iterations (default Nit=3)
%
% be  = propagation wavenumbers of the supported TE modes in rads/m 
% kc  = cutoff wavenumbers inside slab in rad/m
% ac  = cutoff wavenumbers outside slab in nepers/m
% fc  = cutoff frequencies below f in Hz
% err = approximation error in determining kc,ac
%
% calls DSLAB to solve for kc,ac

% Sophocles J. Orfanidis - 1999-2008 - www.ece.rutgers.edu/~orfanidi/ewa

function [be,kc,ac,fc,k0,err] = dguide(lambda0,a,n1,n2,Nit)

if nargin==0, help dguide; return; end
if nargin==4, Nit=3; end;

c0 = 3e8;                                   % c0 in m/s
k0 = 2*pi/lambda0;%= 2*pi*f/c0;              % free-space wavenumber
NA = sqrt(n1^2 - n2^2);                     % numerical aperture 
R = k0*a*NA;                                % circle radius
M = floor(2*R/pi);                          % number of modes = M+1
m = 0:M;                                    % mode numbers
Rc = m*pi/2;                                % cutoff radii
fc = c0*Rc/(2*pi*a*NA);                     % cutoff frequencies in GHz
%lambdac = 2*pi/(Rc/(2*pi*a*NA));

[u,v,err] = dslab(R,Nit);                   

kc = u/a;
ac = v/a;

be = sqrt(n1^2*k0^2 - kc.*kc);              % propagation wavenumbers


