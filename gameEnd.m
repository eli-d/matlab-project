function gameEnd(players,playerCount)
%run at game end. displays the winner, player rankings, and thanks players
%for playing.


rankPos = []; %store index of player final round rank 
winCount = []; %store players{x}{4} in a vector

%store which number player got the nth rank in nth index of rankPos
for i = 1:playerCount
    rankPos(players{i}{3}) = i;
    winCount = [winCount players{i}{4}];
end
%sort winCount
winIndex = winSort(playerCount,winCount);

%display final round winner
fprintf('The winner of the final round was %s.\n',players{rankPos(1)}{2});
pause(1.5);
%display overall winner
fprintf('The overall final winner was %s, with %d points! Congratulations!\n\n',players{winIndex(1)}{2},players{winIndex(1)}{4});
pause(2.5);
%player rankings
fprintf('The final rankings for all players are as follows: \n');
pause(1.5);
j = 1;
for i = winIndex
    if players{i}{4} == 1
        fprintf('%d: %s with 1 win\n',j,players{i}{2});
    else
        fprintf('%d: %s with %d wins\n',j,players{i}{2},players{i}{4});
    end
    j = j + 1;
    pause(0.7);
end
fprintf('Thanks for playing!\n');
input('Press enter to exit the game.');
clc
end