
clc;
clear;
close all;

sourceEnergy = [100 100 100 100 100 100 100 100];
meteredEnergy = [94 95 93 94 92 75 94 70];
threshold = 0.12;

[theftDetected, lossPercent] = ...
    theftDetector(sourceEnergy, meteredEnergy, threshold);

disp('POWER THEFT DETECTION RESULTS');

for i = 1:length(sourceEnergy)
    fprintf('Sample %d: Energy Loss = %.2f%%', ...
        i, lossPercent(i));

    if theftDetected(i)
        fprintf(' --> SUSPECTED THEFT\n');
    else
        fprintf(' --> Normal\n');
    end
end

figure;
bar(lossPercent);
hold on;
yline(threshold * 100, 'r--', 'Theft Threshold (12%)');
xlabel('Sample Number');
ylabel('Energy Loss (%)');
title('Power Theft Detection');
grid on;
hold off;
