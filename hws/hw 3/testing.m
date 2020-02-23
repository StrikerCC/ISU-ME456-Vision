clear all;
clc;

h = 1/42 *[0 0 0 8 4;
    2 4 8 4 2;
    1 2 4 2 1];
h = 1/16*[0 0 7;
    3 5 1];


[col_h, row_h] = size(h);
center_col = 1;
center_row = (row_h+1)/2;



eij = ones(10,10);
[cols, rows] = size(eij);
errADD = zeros(cols, rows);
for i = center_col+1:cols-center_col
    for j = center_row:rows-center_row
        
        errAdd_ele = zeros(col_h, row_h);
        for k = 1:col_h
            for l = 1:row_h
                a = i-(k-center_col);
                b = j-(l-center_row);
                errAdd_ele(k,1) = h(k,l)*eij(a,b);
            end
        end
        errADD(i,j) = sum(sum(errAdd_ele));
    end
end
%% system respound first one 
figure 
kp = 36;
ki = 200;
sys = tf([kp,ki],[4,4+kp,ki]);
step(sys);
hold on

kp = 36;
ki = 100;
sys = tf([kp,ki],[4,4+kp,ki]);
step(sys);
hold on

kp = 216;
ki = 1000;
sys = tf([kp,ki],[4,4+kp,ki]);
step(sys);
hold off 

title('system respond respound vs time');
legend('damping ratio 0.707','damping ratio 1','root separation factor 10');
%% system actuator respound 
figure 
kp = 36;
ki = 200;
sys = tf(4*[kp,kp+ki,ki],[4,4+kp,ki]);
step(sys);
hold on

kp = 36;
ki = 100;
sys = tf(4*[kp,kp+ki,ki],[4,4+kp,ki]);
step(sys);
hold on

kp = 216;
ki = 1000;
sys = tf(4*[kp,kp+ki,ki],[4,4+kp,ki]);
step(sys);
hold off 

title('system actuator respound vs time');
legend('damping ratio 0.707','damping ratio 1','root separation factor 10');

