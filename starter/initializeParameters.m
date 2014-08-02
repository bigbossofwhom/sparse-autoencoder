function theta = initializeParameters(hiddenSize, visibleSize)

%% Initialize parameters randomly based on layer sizes.
r  = sqrt(6) / sqrt(hiddenSize+visibleSize+1);   % we'll choose weights uniformly from the interval [-r, r]
W1 = rand(hiddenSize, visibleSize) * 2 * r - r; %W1是在（0,1）中间任意取值的25*64矩阵
W2 = rand(visibleSize, hiddenSize) * 2 * r - r;%W2是在（0,1）中间任意取值的64*25矩阵

b1 = zeros(hiddenSize, 1); %25*1的矩阵做偏离项
b2 = zeros(visibleSize, 1);%64*1的矩阵做偏离项

% Convert weights and bias gradients to the vector form.
% This step will "unroll" (flatten and concatenate together) all 
% your parameters into a vector, which can then be used with minFunc. 
theta = [W1(:) ; W2(:) ; b1(:) ; b2(:)];
%theta为包含矩阵权值和偏差项的矩阵
end

