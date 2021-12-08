%{
Yutong Gu
ITP-168 - Fall 2015
A9
yutonggu@usc.edu

Revision History
Date          Changes          Programmer
---------------------------------------------
11/11/15        Original         Yutong Gu
%}
load('HW9.mat');
A=6.371*10^6;

%store change in degrees
dX=diff(X);
dY=diff(Y);

%store the size of the map
xLength=length(X);
yLength=length(Y);

%create vector of zeros which will later be used to store x y in meters
xMeters=zeros(1,xLength);
yMeters=zeros(yLength,1);

%converting and adding distance into x and y matrix
for i=2:xLength
    xMeters(i)=xMeters(i-1)+A*tand(dX(i-1));
end
for i=2:yLength
    yMeters(i)=yMeters(i-1)+A*tand(dY(i-1));
end

viewSize=50;
moveFactor=10;

%setting the starting and ending x and y values
startingX=1;
endingX=startingX+viewSize;
startingY=1;
endingY=startingY+viewSize;

%generating box
boxX=xMeters(1,startingX:endingX);
boxTopY=yMeters(startingY);
boxBottomY=yMeters(endingY);
boxY= yMeters(startingY:endingY,1);
boxLeftX= xMeters(startingX);
boxRightX= xMeters(endingX);

%generating surface plot
subplot(2,1,1);
[plotX,plotY]=meshgrid(boxX,boxY);
plotZ=ELEV(startingY:endingY,startingX:endingX);
plotHandle=surf(plotX,plotY,plotZ);

%generating contour map
subplot(2,1,2);
contour(xMeters,yMeters,ELEV);
hold on;
%generating box
plotHandleTop= plot(boxX,boxTopY,'b');
plotHandleBottom= plot(boxX,boxBottomY,'b');
plotHandleLeft=plot(boxLeftX,boxY,'b');
plotHandleRight=plot(boxRightX,boxY,'b');
hold off;

userinput=-1;
while(userinput~=0) %looping through program
    
    %user input
    fprintf('Choose an option:');
    fprintf('\n\t1. North\n\t2. South\n\t3. East\n\t4. West\n\t0. Quit\n');
    userinput=input('Choose: ');
    if(userinput<0||userinput>4)
        fprintf('Invalid option\n');
        continue;
    end
    
    switch(userinput)
        case 1 %moving north by adjusting starting and ending X and Y
            if(endingY+moveFactor>length(yMeters)) %checking if out of bounds
                endingY=length(yMeters);
                startingY=endingY-viewSize;
            else
                endingY=endingY+moveFactor;
                startingY=startingY+moveFactor;
            end
        case 2 %moving south by adjusting starting and ending X and Y
            if(startingY-moveFactor<1) %checking if out of bounds
                startingY=1;
                endingY=startingY+viewSize;
            else
                endingY=endingY-moveFactor;
                startingY=startingY-moveFactor;
            end
        case 3 %moving east by adjusting starting and ending X and Y
            if(endingX+moveFactor>length(xMeters)) %checking if out of bounds
                endingX=length(xMeters);
                startingX=endingX-viewSize;
            else
                endingX=endingX+moveFactor;
                startingX=startingX+moveFactor;
            end
        case 4 %moving west by adjusting starting and ending X and Y
            if(startingX-moveFactor<1) %checking if out of bounds
                startingX=1;
                endingX=startingX+viewSize;
            else
                endingX=endingX-moveFactor;
                startingX=startingX-moveFactor;
            end
        case 0 %ending program
           break;
    end
    %redrawing box
    boxX=xMeters(1,startingX:endingX);
    boxTopY=yMeters(startingY);
    boxBottomY=yMeters(endingY);
    boxY= yMeters(startingY:endingY,1);
    boxLeftX= xMeters(startingX);
    boxRightX= xMeters(endingX);
    
    %creating new meshgrids 
    [plotX,plotY]=meshgrid(boxX,boxY);
    plotZ=ELEV(startingY:endingY,startingX:endingX);
    %updating value of surf plot
    set(plotHandle,'XData',plotX);
    set(plotHandle,'YData',plotY);
    set(plotHandle,'ZData',plotZ);
    
    %updating values of box
    set(plotHandleTop,'YData',boxTopY*ones(length(boxX),1));
    set(plotHandleTop,'XData',boxX);
    set(plotHandleBottom,'YData',boxBottomY*ones(length(boxX),1));
    set(plotHandleBottom,'XData',boxX);
    set(plotHandleLeft,'YData',boxY);
    set(plotHandleLeft,'XData',boxLeftX*ones(1,length(boxY)));
    set(plotHandleRight,'YData',boxY);
    set(plotHandleRight,'XData',boxRightX*ones(1,length(boxY)));
    drawnow;
    
    
end



