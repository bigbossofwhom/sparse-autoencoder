function [h, array] = display_network(A, opt_normalize, opt_graycolor, cols, opt_colmajor)
% This function visua u do not need to worry
% about it.
% opt_normalize: whether we need to normalize the filter so that all of
% them can have similar contrast. Default value 默认值 is true.
% opt_graycolor: whether we use gray as the heat map. Default is true.
% cols（有值，且值为8）: how many columns are there in the display. Default value is the
% squareroot of the number of columns in A.列
% opt_colmajor: you can switch convention to row major for A. In that
% case, each row of A is a filter. Default value is false.
warning off all
%检查变量名opt_normalize中的变量是否存在
if ~exist('opt_normalize', 'var') || isempty(opt_normalize)
    opt_normalize= true;
end

if ~exist('opt_graycolor', 'var') || isempty(opt_graycolor)
    opt_graycolor= true;
end

if ~exist('opt_colmajor', 'var') || isempty(opt_colmajor)
    opt_colmajor = false;
end

% rescale
A = A - mean(A(:));
%colormap(gray) 输出一个灰色系的曲面图
if opt_graycolor, colormap(gray); end

% compute rows, cols
[L M]=size(A);
sz=sqrt(L);
buf=1;
if ~exist('cols', 'var')
    if floor(sqrt(M))^2 ~= M
        n=ceil(sqrt(M));
        while mod(M, n)~=0 && n<1.2*sqrt(M), n=n+1; end %算出n=17；
        m=ceil(M/n); %m为12
    else
        n=sqrt(M);
        m=n;
    end
else
    n = cols;
    m = ceil(M/n);
end

array=-ones(buf+m*(sz+buf),buf+n*(sz+buf));%109*154的矩阵
%buf=1，m=12，n=17，sz=8；
if ~opt_graycolor
    array = 0.1.* array;
end


if ~opt_colmajor
    k=1;
    for i=1:m
        for j=1:n
            if k>M, 
                continue; 
            end
            clim=max(abs(A(:,k)));%选出A矩阵中第K列中最大值
            if opt_normalize%把array矩阵赋值；
                array(buf+(i-1)*(sz+buf)+(1:sz),buf+(j-1)*(sz+buf)+(1:sz))=reshape(A(:,k),sz,sz)/clim;
            else
                array(buf+(i-1)*(sz+buf)+(1:sz),buf+(j-1)*(sz+buf)+(1:sz))=reshape(A(:,k),sz,sz)/max(abs(A(:)));
            end
            k=k+1;
        end
    end
else
    k=1;
    for j=1:n
        for i=1:m
            if k>M, 
                continue; 
            end
            clim=max(abs(A(:,k)));
            if opt_normalize
                array(buf+(i-1)*(sz+buf)+(1:sz),buf+(j-1)*(sz+buf)+(1:sz))=reshape(A(:,k),sz,sz)/clim;
            else
                array(buf+(i-1)*(sz+buf)+(1:sz),buf+(j-1)*(sz+buf)+(1:sz))=reshape(A(:,k),sz,sz);
            end
            k=k+1;
        end
    end
end

if opt_graycolor
    h=imagesc(array,'EraseMode','none',[-1 1]);%系统自带的imagesc（）函数；
else
    h=imagesc(array,'EraseMode','none',[-1 1]);
    %将array中的数据线性映射到[-1,1]之间，然后使用当前设置的颜色表进行显示。
    %此时的[-1,1]充满了整个颜色表。背景擦除模式设置为node，表示不擦除背景。
end
axis image off

drawnow;

warning on all
