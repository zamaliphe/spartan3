function [ output_args ] = Untitled1( input_args )
%UNTITLED1 Summary of this function goes here
%   Detailed explanation goes here
>> x = sin(0.4*2*n*pi/256)

x =

  Columns 1 through 7 

         0    0.0098    0.0196    0.0294    0.0393    0.0491    0.0589

  Columns 8 through 14 

    0.0687    0.0785    0.0882    0.0980    0.1078    0.1175    0.1273

  Columns 15 through 21 

    0.1370    0.1467    0.1564    0.1661    0.1758    0.1855    0.1951

  Columns 22 through 28 

    0.2047    0.2143    0.2239    0.2334    0.2430    0.2525    0.2620

  Columns 29 through 35 

    0.2714    0.2809    0.2903    0.2997    0.3090    0.3183    0.3276

  Columns 36 through 42 

    0.3369    0.3461    0.3553    0.3645    0.3736    0.3827    0.3917

  Columns 43 through 49 

    0.4007    0.4097    0.4187    0.4276    0.4364    0.4452    0.4540

  Columns 50 through 56 

    0.4627    0.4714    0.4800    0.4886    0.4972    0.5057    0.5141

  Columns 57 through 63 

    0.5225    0.5308    0.5391    0.5474    0.5556    0.5637    0.5718

  Columns 64 through 70 

    0.5798    0.5878    0.5957    0.6036    0.6114    0.6191    0.6268

  Columns 71 through 77 

    0.6344    0.6420    0.6494    0.6569    0.6643    0.6716    0.6788

  Columns 78 through 84 

    0.6860    0.6931    0.7001    0.7071    0.7140    0.7209    0.7276

  Columns 85 through 91 

    0.7343    0.7410    0.7475    0.7540    0.7604    0.7667    0.7730

  Columns 92 through 98 

    0.7792    0.7853    0.7914    0.7973    0.8032    0.8090    0.8147

  Columns 99 through 105 

    0.8204    0.8260    0.8315    0.8369    0.8422    0.8475    0.8526

  Columns 106 through 112 

    0.8577    0.8627    0.8677    0.8725    0.8773    0.8819    0.8865

  Columns 113 through 119 

    0.8910    0.8954    0.8997    0.9040    0.9081    0.9122    0.9162

  Columns 120 through 126 

    0.9201    0.9239    0.9276    0.9312    0.9347    0.9382    0.9415

  Columns 127 through 133 

    0.9448    0.9480    0.9511    0.9540    0.9569    0.9597    0.9625

  Columns 134 through 140 

    0.9651    0.9676    0.9700    0.9724    0.9746    0.9768    0.9788

  Columns 141 through 147 

    0.9808    0.9827    0.9844    0.9861    0.9877    0.9892    0.9906

  Columns 148 through 154 

    0.9919    0.9931    0.9942    0.9952    0.9961    0.9969    0.9976

  Columns 155 through 161 

    0.9983    0.9988    0.9992    0.9996    0.9998    1.0000    1.0000

  Columns 162 through 168 

    1.0000    0.9998    0.9996    0.9992    0.9988    0.9983    0.9976

  Columns 169 through 175 

    0.9969    0.9961    0.9952    0.9942    0.9931    0.9919    0.9906

  Columns 176 through 182 

    0.9892    0.9877    0.9861    0.9844    0.9827    0.9808    0.9788

  Columns 183 through 189 

    0.9768    0.9746    0.9724    0.9700    0.9676    0.9651    0.9625

  Columns 190 through 196 

    0.9597    0.9569    0.9540    0.9511    0.9480    0.9448    0.9415

  Columns 197 through 203 

    0.9382    0.9347    0.9312    0.9276    0.9239    0.9201    0.9162

  Columns 204 through 210 

    0.9122    0.9081    0.9040    0.8997    0.8954    0.8910    0.8865

  Columns 211 through 217 

    0.8819    0.8773    0.8725    0.8677    0.8627    0.8577    0.8526

  Columns 218 through 224 

    0.8475    0.8422    0.8369    0.8315    0.8260    0.8204    0.8147

  Columns 225 through 231 

    0.8090    0.8032    0.7973    0.7914    0.7853    0.7792    0.7730

  Columns 232 through 238 

    0.7667    0.7604    0.7540    0.7475    0.7410    0.7343    0.7276

  Columns 239 through 245 

    0.7209    0.7140    0.7071    0.7001    0.6931    0.6860    0.6788

  Columns 246 through 252 

    0.6716    0.6643    0.6569    0.6494    0.6420    0.6344    0.6268

  Columns 253 through 256 

    0.6191    0.6114    0.6036    0.5957

>> plot(abs(fft(x)))
>> plot(abs(fft(x)),512)
>> plot(abs(fft(x)),512
)
??? plot(abs(fft(x)),512
                        |
Error: Expression or statement is incorrect--possibly unbalanced (, {, or [.

>> plot(abs(fft(x)),512
??? plot(abs(fft(x)),512
                        |
Error: Expression or statement is incorrect--possibly unbalanced (, {, or [.

>> plot(abs(fft(x)),512)
>> plot(abs(fft(x,512)))
>> plot(x)
>> x = sin(2*n*pi/256);
>> plot(x)
>> plot(abs(fft(x,512)))
>> pwd

ans =

E:\MATLAB71\work

>> x = cos(pi*n*0.2) + j*sin(pi*n*0.2);
>> plot(abs(fft(x,512)))
>> plot(re(x))
??? Undefined command/function 're'.

>> plot(real(x))
>> hold on;
>> plot(imag(x))
>> plot(abs(fft(x,512)))
>> help fft
 FFT Discrete Fourier transform.
    FFT(X) is the discrete Fourier transform (DFT) of vector X.  For
    matrices, the FFT operation is applied to each column. For N-D
    arrays, the FFT operation operates on the first non-singleton
    dimension.
 
    FFT(X,N) is the N-point FFT, padded with zeros if X has less
    than N points and truncated if it has more.
 
    FFT(X,[],DIM) or FFT(X,N,DIM) applies the FFT operation across the
    dimension DIM.
    
    For length N input vector x, the DFT is a length N vector X,
    with elements
                     N
       X(k) =       sum  x(n)*exp(-j*2*pi*(k-1)*(n-1)/N), 1 <= k <= N.
                    n=1
    The inverse DFT (computed by IFFT) is given by
                     N
       x(n) = (1/N) sum  X(k)*exp( j*2*pi*(k-1)*(n-1)/N), 1 <= n <= N.
                    k=1
 
    See also fft2, fftn, fftshift, fftw, ifft, ifft2, ifftn.

    Overloaded functions or methods (ones with the same name in other directories)
       help uint8/fft.m
       help uint16/fft.m
       help gf/fft.m
       help qfft/fft.m
       help iddata/fft.m

    Reference page in Help browser
       doc fft



 FFTSHIFT Shift zero-frequency component to center of spectrum.
    For vectors, FFTSHIFT(X) swaps the left and right halves of
    X.  For matrices, FFTSHIFT(X) swaps the first and third
    quadrants and the second and fourth quadrants.  For N-D
    arrays, FFTSHIFT(X) swaps "half-spaces" of X along each
    dimension.
 
    FFTSHIFT(X,DIM) applies the FFTSHIFT operation along the 
    dimension DIM.
 
    FFTSHIFT is useful for visualizing the Fourier transform with
    the zero-frequency component in the middle of the spectrum.
 
    Class support for input X:
       float: double, single
 
    See also ifftshift, fft, fft2, fftn, circshift.


    Reference page in Help browser
       doc fftshift



>> x2=abs(fft(x,512));
>> plot(abs(fftshift(x2)))
>> 
>> plot(abs(fftshift(x,512)))
 Overloaded functions or methods (ones with the same name in other directories)
   doc images/fftshift
   doc signal/fftshift

>> plot(imag(x))
>> x2=abs(fft(x,512));
>> plot(abs(fftshift(x2)))
>> x = sin(2*n*pi/256);
>> x2=abs(fft(x,512));
>> plot(abs(fftshift(x2)))
>> x = sin(4*n*pi/256);
>> x2=abs(fft(x,512));
>> plot(abs(fftshift(x2)))
>> x = sin(100*n*pi/256);
>> x2=abs(fft(x,512));
>> plot(abs(fftshift(x2)))
>> x = sin(128*n*pi/256);
>> x2=abs(fft(x,512));
>> plot(abs(fftshift(x2)))
>> x2=abs(fft(x,256));
>> plot(abs(fftshift(x2)))
>> x = sin(68*n*pi/256);
>> x2=abs(fft(x,256));
>> plot(abs(fftshift(x2)))
>> x = sin(30*n*pi/256);
>> x2=abs(fft(x,256));
>> plot(abs(fftshift(x2)))
>> x = sin(10*n*pi/256);
>> x2=abs(fft(x,256));
>> plot(abs(fftshift(x2)))
>> x2=abs(fft(x,256));
>> plot(abs(fft(x2)))
>> plot(abs(fft(x)))
>> x = sin(100*n*pi/256);
>> plot(abs(fft(x)))
>> x = cos(pi*n*0.2) + j*sin(pi*n*0.2);
>> plot(abs(fft(x)))
>> plot(real(fft(x)))
>> plot(imag(fft(x)))
>> x = cos(pi*n*0.2);
>> plot(abs(fft(x)))
>> x = cos(pi*n*0.2) + cos(pi*n*0.7);
>> plot(abs(fft(x)))
>> 