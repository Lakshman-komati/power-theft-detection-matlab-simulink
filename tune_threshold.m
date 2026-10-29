tm = normalMismatchRMS.Time(:);
x = squeeze(normalMismatchRMS.Data);
x = x(:);

% Exclude startup and any load-switching transition.
% Adjust these time ranges to match your actual model.
keep = (tm > 0.2 & tm < 1.8);
normalValues = x(keep);

muNormal = mean(normalValues);
sigmaNormal = std(normalValues, 0);

thresholdA = max(0.2, muNormal + 5*sigmaNormal);

fprintf('Normal mean = %.4f A RMS\n', muNormal);
fprintf('Normal std  = %.4f A RMS\n', sigmaNormal);
fprintf('Threshold   = %.4f A RMS\n', thresholdA);
