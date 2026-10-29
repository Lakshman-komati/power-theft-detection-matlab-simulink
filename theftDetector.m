
function [theftDetected, lossPercent] = ...
    theftDetector(sourceEnergy, meteredEnergy, threshold)

% Validate input values
if any(sourceEnergy <= 0)
    error('Source energy must be greater than zero.');
end

if any(meteredEnergy < 0) || ...
        any(meteredEnergy > sourceEnergy)
    error('Metered energy must be between zero and source energy.');
end

% Calculate unaccounted energy loss percentage
lossPercent = ...
    ((sourceEnergy - meteredEnergy) ./ sourceEnergy) * 100;

% Detect unusually high energy loss
theftDetected = lossPercent > (threshold * 100);

end
