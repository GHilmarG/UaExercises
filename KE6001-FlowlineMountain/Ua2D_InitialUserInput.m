

function [UserVar,CtrlVar,MeshBoundaryCoordinates]=Ua2D_InitialUserInput(UserVar,CtrlVar)


CtrlVar.TimeDependentRun=1; 
CtrlVar.Experiment='FlowLineMountain';

CtrlVar.Restart=0;   
CtrlVar.WriteRestartFile=1;

CtrlVar.time=0 ; 
CtrlVar.dt=1; 
CtrlVar.TotalNumberOfForwardRunSteps=50;  
CtrlVar.TotalTime=2000;

% automated time stepping
CtrlVar.AdaptiveTimeStepping=1 ; CtrlVar.ATStimeStepTarget=1.0  ;


% Flow approximatoin.
% SSHEET is what in the litterature is often referred to as SIA
CtrlVar.FlowApproximation='SSHEET';

% set mininum allowed ice thickness
CtrlVar.ThickMin=1;                
CtrlVar.ResetThicknessToMinThickness=1;  
CtrlVar.ThicknessConstraints=0;  
%% Mesh domain and resolution 
xd=70e3; xu=-70e3 ; yl=1e3 ; yr=-1e3;
MeshBoundaryCoordinates=[xu yr ; xd yr ; xd yl ; xu yl];
CtrlVar.MeshSize=1e3;


end
