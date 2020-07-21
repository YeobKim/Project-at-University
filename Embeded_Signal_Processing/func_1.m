function [f_hat, X, cnt] = func_1(x,N)
    l = 0:N-1;
    X = zeros(1,N); % X(k)�� ������ �÷��ִ� ��.
    cnt = 0;

    for k = l
        X_2 = 0;
        for n = l
            X_1 = x(n+1)*exp((-1i)*2*pi*(k/N)*n); % DFT ��
            X_2 = X_2 + X_1; % X_1���� ���� ������ ��� ����
            cnt =cnt + 1; % n�� �� �� �� ������ ī��Ʈ ����
        end               % ��� ���� �� ������ Ƚ�� ���ϴ� ����  
        X(k+1) = X_2;
    end

    f_hat = linspace(-0.5, 0.5, N+1);
    f_hat = f_hat(1:end-1); % end-1 = N
 
    X = [X((N/2)+1:end), X(1:(N/2))]; 
end