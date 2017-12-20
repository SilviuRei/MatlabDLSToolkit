function n = water_indref(temperature,density,wavelength)
% function n = water_indref(temperature,density,wavelength)
% WATER_INDEX Compute the index of refraction using the 1997 release of
%   the IAPWS available on http://www.iapws.org
%
%   n = WATER_INDEX(T,rho,lambda) returns the refractive
%   index n for temperature (deg C), density (kg/m^3)
%   and wavelength (nm)
%
%   n = WATER_INDEX() returns the refractive
%   index n for reference constant temperature = 0 deg C,
%   density = 1000kg/m^3, wavelength = 589 nm
%
%   The density can be obtained from pressure and temperature using XSteam,
%   IAPWS_IF97 or similar solutions available on the Matlab File Exchange

% Reference constants
temperature_r = 273.15;   % reference temperature (K)
density_r     = 1000;     % reference density (kg/m^3)
wavelength_r  = 0.589;    % reference wavelength (micro m)

% no arguments? use reference values
switch nargin
    case 0
        temperature = temperature_r;
        density     = density_r;
        wavelength 	= wavelength_r;
        
    case 3
        % Range of formulation
        temperature_lim = [-12 500];
        density_lim     = [0 1060];
        wavelength_lim  = [0.2 1.1]*1000;
        
        % Input validation
        if min(temperature(:)) < min(temperature_lim) || max(temperature(:)) > max(temperature_lim)
            warning('Temperature outside recommended range of %.2f to %.2f K',temperature_lim)
        end
        if min(density(:)) < min(density_lim) || max(density(:)) > max(density_lim)
            warning('Density outside recommended range of %.0f to %.0f kg/m^3',density_lim)
        end
        if min(wavelength(:)) < min(wavelength_lim) || max(wavelength(:)) > max(wavelength_lim)
            warning('Wavelength outside recommended range of %.0f to %.0f nm',wavelength_lim)
        end
        
        % convert to absolute temperature and micrometers wavelength
        temperature = temperature+temperature_r;
        wavelength  = wavelength/1000;
        
    otherwise
        error('Invalid number of arguments')
end

% If we vectors, make sure they are all coluhm vectors 
if isvector(temperature) && isvector(density) && isvector(wavelength)
    temperature = temperature(:);
    density = density(:);
    wavelength = wavelength(:);
end

% Vectorization: make sure that if one or two of the three vectors has
% only one value, replicate it to match the size of the largest vector
if numel(temperature) == 1 && (numel(density) > 1 || numel(wavelength) > 1) 
    if numel(density) >= numel(wavelength) 
        temperature = repmat(temperature,size(density));
    else
        temperature = repmat(temperature,size(wavelength));
    end
end
if numel(density) == 1 && (numel(temperature) > 1 || numel(wavelength) > 1) 
    if numel(temperature) >= numel(wavelength) 
        density = repmat(density,size(temperature));
    else
        density = repmat(density,size(wavelength));
    end
end
if numel(wavelength) == 1 && (numel(density) > 1 || numel(temperature) > 1) 
    if numel(density) >= numel(temperature) 
        wavelength = repmat(wavelength,size(density));
    else
        wavelength = repmat(wavelength,size(temperature));
    end
end

% Dimensionless variables
T = temperature/temperature_r;
D = density/density_r;
L = wavelength/wavelength_r;

% Coefficients
a0 = 0.244257733;
a1 = 9.74634476e-3;
a2 = -3.73234996e-3;
a3 = 2.68678472e-4;
a4 = 1.58920570e-3;
a5 = 2.45934259e-3;
a6 = 0.900704920;
a7 = -1.66626219e-2;
lambdaUV_d = 0.2292020;
lambdaIR_d = 5.432937;

% Calculation of index of refraction (n^2-1)/(n^2+1) = b
b = (a0 + a1*D + a2*T + a3*L.^2.*T + a4./L.^2 ...
    + a5./(L.^2-lambdaUV_d.^2) + a6./(L.^2-lambdaIR_d.^2) ...
    + a7*D.^2).*D;
n = sqrt(-2*b-1)./sqrt(b-1);
