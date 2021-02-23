

function [UserVar,CtrlVar,MeshBoundaryCoordinates]=Ua2D_InitialUserInput(UserVar,CtrlVar)


CtrlVar.TimeDependentRun=1; 
CtrlVar.Experiment='FlowLineMountain';

CtrlVar.Restart=0;   
CtrlVar.WriteRestartFile=1;

CtrlVar.time=0 ; 
CtrlVar.dt=1; 
CtrlVar.TotalNumberOfForwardRunSteps=500;  
CtrlVar.TotalTime=500;

% automated time stepping
CtrlVar.AdaptiveTimeStepping=1 ; CtrlVar.ATSdtMax=1; 


% Flow approximation.
% SSHEET is what in the litterature is often referred to as SIA
 CtrlVar.FlowApproximation='SSHEET';  CtrlVar.NLtol=1e-15 ; % 

% set mininum allowed ice thickness
CtrlVar.ThickMin=1;                
CtrlVar.ResetThicknessToMinThickness=0;  
CtrlVar.ThicknessConstraints=1;  
%% Mesh domain and resolution 
xd=70e3; xu=-70e3 ; yl=1e3 ; yr=-1e3;
MeshBoundaryCoordinates=[xu yr ; xd yr ; xd yl ; xu yl];
CtrlVar.MeshSize=1000;


end
