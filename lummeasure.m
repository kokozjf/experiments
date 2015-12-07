%% Luminance measure
try
    Screens=Screen('Screens');
    whichScreen=max(Screens);
    [MyScreen,Rect]=Screen('OpenWindow',whichScreen,0);
    HideCursor;
    KbName('UnifyKeyNames');
    EscapeKey = KbName('ESCAPE');
    spaceKey=KbName('1!');    
    RestrictKeysForKbCheck([EscapeKey,spaceKey]);
    lumset=0:15:255;
    lumset1=255:-15:0;
%%  measure
    for i=1:18
        Screen('FillRect', MyScreen,lumset(i),[0 0 1024 768]);
        Screen('DrawText', MyScreen,num2str(lumset(i)),980, 740, [255,0,0]);
        Screen('Flip',MyScreen);
        [keyIsDown,keysecs,keyCode]=KbCheck;
        while ~(keyIsDown && keyCode(spaceKey))
            [keyIsDown,keysecs,keyCode]=KbCheck;
        end
        if keyCode(spaceKey)==1
        elseif keyCode(EscapeKey)==1
            break;            
        end
        WaitSecs(1); 
    end
%% end   
    sca;
    ShowCursor;
    RestrictKeysForKbCheck([]);   
catch 
    sca;
    RestrictKeysForKbCheck([]);
    ShowCursor;
    rethrow(lasterror);  
end
