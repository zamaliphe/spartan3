function output = logpolar(input)
    oRows = size(input, 1);
    oCols = size(input, 2);
    output = zeros(oRows,oCols);
    dTheta = 2*pi / oCols;                 % the step size for theta 
    b = 10 ^ (log10(oRows) / oRows);       % base for the log-polar conversion 
    for i = 1:oRows                        % rows     
        for j = 1:oCols                    % columns
            r = b ^ i - 1;                 % the log-polar
            theta = j * dTheta;
            x = round(r * cos(theta) + size(input,2) / 2);
            y = round(r * sin(theta) + size(input,1) / 2);
            if (x>0) & (y>0) & (x<size(input,2)) & (y<size(input,1)) 
                output(i,j) = input(y,x);
            end
        end
    end
