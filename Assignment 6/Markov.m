load HW6_Trajectory;
N = size(unique(X),1);
P_hat = zeros(N,N);
nums = zeros(N);

for i = 2:size(X,1)
    P_hat(X(i-1),X(i)) = P_hat(X(i-1),X(i))+1;
    nums(X(i-1)) = nums(X(i-1))+1;
end

for i = 1:N
    P_hat(i,:) = P_hat(i,:)/nums(i);
end

disp('estimate transition probability matrix P is:');
disp(P_hat);

disp('transition probability matrix P is probabily be:');
P = [0    0    1/2  1/4  1/4  0    0  ;
     0    0    1/3  0    2/3  0    0  ; 
     0    0    0    0    0    1/3  2/3;
     0    0    0    0    0    1/2  1/2;
     0    0    0    0    0    3/4  1/4;
     1/2  1/2  0    0    0    0    0  ;
     1/4  3/4  0    0    0    0    0   ];
disp(P);