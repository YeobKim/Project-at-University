function [f_hat, Xk, N_mult] = Np_FFT(x,N)

for n=0:N-1  % ����� ������ f_hat�� ������ ����
    if n < N/2
    f_hat(n+1) = n/N;
    elseif n>=N/2
    f_hat(n+1) = (n/N) - 1;
    end
end

q = log2(N);    
% N=length(x);
xtmp = zeros(1,N);
value = zeros(1,q);

for i = 0 : N-1 % �Է� x�� ������ �ٲ��ִ� ����
    shift = i;
    for t = 1 : q
        shift = bitshift(i,1-t); % ���������� ����Ʈ ����
        value(t) = bitand(shift,1); %2������ and������ 
    end
    pos = 0; %pos�� �ִ� ��ġ�� ������ 
    for k = 1 : q
        pos = pos + (value(k) * 2^(q-k)); %value������ 2�� ���°��� �ٽ� 10������ 
    end
    xtmp(pos + 1) = x(i + 1); % �ٲ� x�� ������ ����.
end


N_mult = 0;
for l = 1 : q %�����ö��� ���� �� �ܰ踦 ����                                
    new_W = 1;                                   
    W = exp((-1i)*2*pi/2^l); %������ ��� ������ ����ó�� ������ l ���� 1���� �Ѿ�鼭  %����ȭ                  
    p = 0; 
    while p < 2^(l-1); % ���� �ܰ�� �Ѿ�� while��  %��Ŀ��� �ʰ��ؼ�                         
        i = p; 
        while i < N % �ܰ躰 ���� ȭ��ǥ                       
            ip = i + 2^(l-1); % ip�ϰ� �ؿ� i�� ���� ���� �̷������� W ����Ǵ� ���� ���� %-��                 
            t = new_W * xtmp(ip + 1); % �� �ܰ��� W*������ X   %t�� ppt���� W                
            xtmp(ip + 1) = xtmp(i + 1) - t; % ���� �� ���� ����. 
            xtmp(i+1) = t +xtmp(i + 1); % ���� �� ���ϱ� ����.
            i = i + 2^l;  % while�� Ż���ϰ� �Ϸ��� �������
            N_mult = N_mult + 1; %�ʿ��� �������� ��
        end 
        new_W = new_W * W;                            
        p = p + 1; 
    end  
end
Xk = xtmp;