function [timeSeries,duration]=serialInterface(comPort,baudRate,frequency,duration)
%------------------------------------------------------------
% Version 20171030, Silviu Rei
% function [timeSeries,duration]=serialInterface(comPort,baudRate,frequency,duration)
% This function records a time series using the COM port
% Input:
%	comPort = COM port
%	baudRate = baud rate
%	frequency = acquisition frequency
%	duration = time series length
% Output:
%	timeSeries = time series vector
%	duration = duration of the acquisition
%------------------------------------------------------------

    try
        %tic;
        disp('Data Acquisition v1');
        x=linspace(1,frequency*duration,frequency*duration);
        y=zeros(frequency*duration,1,'int16');
        oldSerial=instrfind('Port',comPort);
        if (~isempty(oldSerial))
            fprintf('WARNING: %s in use. Closing port\n', comPort);
            delete(oldSerial)
        end
        comHandler=serial(comPort, 'BaudRate',baudRate);
        pause(1);
        fprintf('Initialized: %s at %d baudrate\n', comPort, comHandler.baudRate);
        %set(comHandler,'BaudRate', 250000);
        %set(comHandler,'Parity','none');
        %set(comHandler,'DataBits',8);
        %set(comHandler,'StopBit',1);
        %disp(get(comHandler,{'Type','Name','Port','BaudRate','Parity','DataBits','StopBits'}));
        fopen(comHandler);
        command = sprintf('f %d',frequency);
        fprintf(comHandler, command);
        disp(fscanf(comHandler,'%s'));
        command = sprintf('b %d', frequency*duration);
        fprintf(comHandler, command);
        disp(fscanf(comHandler,'%s'));
        fprintf(comHandler, 'o 0');
        disp(fscanf(comHandler,'%s'));
        command = sprintf('z %d',frequency*duration);
        fprintf(comHandler, command);
        disp(fscanf(comHandler,'%s'));
        fprintf(comHandler, 's');
        disp(fscanf(comHandler,'%s'));
        pause(2.5);
        disp('Acquisition complete');
        %fprintf(comHandler, 'd');
        disp('Downloading data');
        format short g;
        delta=0;
        for i=1:length(x)
            tic;
            command = sprintf('x %d',i);
            fprintf(comHandler,command);
            y(i)=fscanf(comHandler,'%d');
            %pause(0.001)
            delta = delta+toc;
            eTa=(frequency*duration-i)*(delta/i);
            pC= i/length(x)*100;
            if (rem(i,100)==0)
                fprintf('Progress=%.1f%%. Time elapsed=%.1f s. Time left=%.1f s\n',pC,delta,eTa);
            end
        end    
        disp('Saving data on SD');
        fprintf(comHandler,'m');
        disp(fscanf(comHandler,'%s'));
        fclose(comHandler);
        timeSeries = y;
        plot(x,y);
        fprintf('Download complete.\n')
        duration = delta;
        fprintf('Time=%.1f s\n', duration);
    catch errorMessage
        fprintf('Error:%s\n', errorMessage.message);
        fclose(comHandler);
        %duration=toc;
    end        
end
