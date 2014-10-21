function fcn_processFID(handles,FID)
% Analyzes FIDs

%% Fit data.
[xData, yData] = prepareCurveData( FID.delay, FID.signal );

% Set up fittype and options.
ft = fittype( 'amplitude*exp(-((x-delay)/variance)^2) + nonResonant', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Algorithm = 'Levenberg-Marquardt';
opts.DiffMaxChange = 1e-10;
opts.DiffMinChange = 1e-22;
opts.Display = 'Off';
opts.MaxFunEvals = 6000;
opts.MaxIter = 4000;
opts.StartPoint = [3.5e-09 120 1e-10 15];
opts.TolFun = 1e-18;
opts.TolX = 1e-18;

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts )

%% Plot FID
figure( 'Name', FID.name );
h = plot(fitresult,FID.delay,FID.signal,'.b');
legend(h, regexprep(FID.name,'_','\\_'), 'Fit')
legend('show')
xlabel('Delay [ps]')
ylabel('Signal (a.u.)')
str = {'Delay:', num2str(fitresult.delay),...
    'Variance:', num2str(fitresult.variance)};
annotation('textbox', [0.2,0.4,0.1,0.1],...
           'String', str)
grid on

end