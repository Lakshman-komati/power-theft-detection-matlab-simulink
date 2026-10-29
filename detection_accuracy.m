% Read logged Simulink signals
actualTS = out.actualTheft;
detectedTS = out.detectedTheft;

% Convert detector output to a column vector
tPred = detectedTS.Time(:);
predData = squeeze(detectedTS.Data);
pred = predData(:) >= 0.5;

% Convert reference signal to a column vector
tRef = actualTS.Time(:);
refData = squeeze(actualTS.Data);
refData = refData(:);

% Remove duplicate time values
[tRef, idx] = unique(tRef, 'stable');
refData = refData(idx);

% Align actual state to detector sample times
actualValues = interp1(tRef, double(refData), ...
    tPred, 'previous', 'extrap');

actual = actualValues >= 0.5;

% Calculate confusion counts
TP = sum(actual & pred);
TN = sum(~actual & ~pred);
FP = sum(~actual & pred);
FN = sum(actual & ~pred);

% Calculate performance metrics
accuracy = 100 * (TP + TN) / numel(actual);

if TP + FP > 0
    precision = 100 * TP / (TP + FP);
else
    precision = NaN;
end

if TP + FN > 0
    recall = 100 * TP / (TP + FN);
else
    recall = NaN;
end

if TN + FP > 0
    falseAlarmRate = 100 * FP / (TN + FP);
else
    falseAlarmRate = NaN;
end

% Display results
fprintf('\n--- POWER THEFT DETECTION RESULTS ---\n');
fprintf('TP = %d, TN = %d, FP = %d, FN = %d\n', ...
    TP, TN, FP, FN);
fprintf('Accuracy        = %.2f %%\n', accuracy);
fprintf('Precision       = %.2f %%\n', precision);
fprintf('Recall          = %.2f %%\n', recall);
fprintf('False alarm rate = %.2f %%\n', falseAlarmRate);