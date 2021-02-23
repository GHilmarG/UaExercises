function  UserVar=DefineOutputs(UserVar,CtrlVar,MUA,BCs,F,l,GF,InvStartValues,InvFinalValues,Priors,Meas,BCsAdjoint,RunInfo)

%%
%
%   This is the m-file you use to define/plot your results.
%
%   You will find all the outputs in the variable F
%
%   The variable F is a structure, and has various fields.
%
%   For example:
%
%   F.s             The upper glacier surface%   
%   F.b             The lower glacier surface
%   F.B             The bedrock
%   F.rho           The ice density
%   F.C             Basal slipperiness, i.e. the variable C in the basal sliding law
%   F.AGlen         The rate factor, i.e. the variable A in Glen's flow law
%
%   All these variables are nodal variables, i.e. these are the corresponding values at the nodes of the computational domain.
%
%   You find informaton about the computational domain in the variable MUA
%
%   For example, the x and y coordinates of the nodes are in the nx2 array MUA.coordinates, where n is the number of nodes.
%   
%   MUA.coordinates(:,1)    are the nodal x coordinates 
%   MUA.coordinates(:,y)    are the nodal y coordinates 
%
%
%%



plots='-ubvb-e-save-';
plots='-udvd-ud(x)-sbB(x)-';
plots='-sbB(x)-';


x=MUA.coordinates(:,1);  y=MUA.coordinates(:,2);

if contains(plots,'-save-')
    
    % save data in files with running names
    % check if folder 'ResultsFiles' exists, if not create
    
    if strcmp(CtrlVar.DefineOutputsInfostring,'First call ') && exist('ResultsFiles','dir')~=7
        mkdir('ResultsFiles') ;
    end
    
    if strcmp(CtrlVar.DefineOutputsInfostring,'Last call')==0
        %FileName=['ResultsFiles/',sprintf('%07i',round(100*time)),'-TransPlots-',CtrlVar.Experiment]; good for transient runs
        
        FileName=['ResultsFiles/',sprintf('%07i',CtrlVar.DefineOutputsCounter),'-TransPlots-',CtrlVar.Experiment];
        
        fprintf(' Saving data in %s \n',FileName)
        save(FileName,'CtrlVar','MUA','F')
        
    end
end


if contains(plots,'-sbB(x)-')
    
    [~,I]=sort(x);
    
    FindOrCreateFigure("Mountain") ; 
    
    
    xBedrockPoly=[x(I);x(I(1))];
    BedrockPoly=[F.B(I);F.B(I(1))] ;
    GlacierPoly=[F.s(I);fliplr(F.b(I))] ;
    xGlacierPoly=[x(I);fliplr(x(I))] ;
    
    hold off
    
    fill(xBedrockPoly/1000,BedrockPoly,[0.9 0.9 0.9],'LineStyle','none'); hold on
    fill(xGlacierPoly/1000,GlacierPoly,'b','Linestyle','none');
    
    title(sprintf('t=%-g (yr)',CtrlVar.time)) ; xlabel('x (km)') ; ylabel('z (m)')
    %Fig_sbB.Position=[1500 1000 1000 400];
    drawnow
end



end
