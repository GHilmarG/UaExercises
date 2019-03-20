function  UserVar=UaOutputs(UserVar,CtrlVar,MUA,BCs,F,l,GF,InvStartValues,InvFinalValues,Priors,Meas,BCsAdjoint,RunInfo);

persistent Fig_sbB


plots='-ubvb-e-save-';
plots='-udvd-ud(x)-sbB(x)-';
plots='-sbB(x)-';


x=MUA.coordinates(:,1);  y=MUA.coordinates(:,2);

if contains(plots,'-save-')
    
    % save data in files with running names
    % check if folder 'ResultsFiles' exists, if not create
    
    if strcmp(CtrlVar.UaOutputsInfostring,'First call ') && exist('ResultsFiles','dir')~=7
        mkdir('ResultsFiles') ;
    end
    
    if strcmp(CtrlVar.UaOutputsInfostring,'Last call')==0
        %FileName=['ResultsFiles/',sprintf('%07i',round(100*time)),'-TransPlots-',CtrlVar.Experiment]; good for transient runs
        
        FileName=['ResultsFiles/',sprintf('%07i',CtrlVar.UaOutputsCounter),'-TransPlots-',CtrlVar.Experiment];
        
        fprintf(' Saving data in %s \n',FileName)
        save(FileName,'CtrlVar','MUA','F')
        
    end
end


if contains(plots,'-sbB(x)-')
    
    [~,I]=sort(x);
    
    if ishandle(Fig_sbB)
        Fig_sbB=figure(Fig_sbB) ;
    else
        Fig_sbB= figure;
    end
    
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
