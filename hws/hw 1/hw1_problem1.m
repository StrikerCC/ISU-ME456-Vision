%% Problem 1: red and white checkboard 2/12/2019 by Cheng Chen
clear all
close all
clc

gridSize = 10;
NofCol = 3; % Number of double color columes
NofRow = 3; % Number of double color rows

redGrid = zeros(gridSize, gridSize, 3);
redGrid(:,:,1) = 1; % color a red grid

buleGrid = zeros(gridSize, gridSize, 3);
buleGrid(:,:,3) = 0.9;  % color a bule grid

I_checkBoardOddRow = [];    % initilze a row of checkboard
I_checkBoardEvenRow = [];   % initilze a row of checkboard
I_checkBoard = [];  % initilze the whole checkboard

for row = 1:NofRow % form two different columes of checkboard 
        I_checkBoardOddRow = [I_checkBoardOddRow;buleGrid;redGrid]; 
        I_checkBoardEvenRow = [I_checkBoardEvenRow;redGrid;buleGrid];
end
for col = 1:NofCol % form whole checkboard using two different columes
    I_checkBoard = [I_checkBoard,I_checkBoardOddRow,I_checkBoardEvenRow];
end
figure, imshow((I_checkBoard));

