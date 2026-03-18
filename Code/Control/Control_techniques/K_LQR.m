function K = K_LQR()
    %% LQR
    
    Extr_A_B_SS;
    
    Q = diag([20 10 15 15 10 1 1 1 1 1]); 
    
    R = diag([1 1 1]);
    
    K = lqr(A, B, Q, R);

end