function [players,startingPlayer] = roundRun(players,startingPlayer,playerCount)
%play through one round of the game

%declare necessary vars
rank = 1; %first player to finish each round will win
remainingPlayers = playerCount;
roundFin = 0;

%while more than 1 player have cards remaining
while roundFin ~= 1
    [players,remainingPlayers,rank,roundFin,startingPlayer] = trickRun(playerCount,players,startingPlayer,remainingPlayers,rank,roundFin);
end

%declare the winner of the round and distribute points
for i = 1:length(players) 
    switch players{i}{3} %check player rank
        case 1
            startingPlayer = i;
            switch playerCount %check playerCount
                case {3,4} %rich
                    players{i}{4} = players{i}{4} + 1;
                otherwise %very rich
                    players{i}{4} = players{i}{4} + 2; 
            end
            fprintf('The winner of this round was %s!\n',players{i}{2});
        case 2
            switch playerCount %check playerCount
                case {5,6,7,8} %rich
                    players{i}{4} = players{i}{4} + 1;
            end
        case 3
            switch playerCount %check playerCount
                case {7,8} %rich
                    players{i}{4} = players{i}{4} + 1;
            end    
    end
end
end