function [players,currentPlayer,remainingPlayers,rank,roundFin,startingPlayer] = rankPlayer(playerCount,players,currentPlayer,remainingPlayers,rank,startingPlayer)
%when called, check if the current player has finished. if they have, rank 
%them with the next available rank, remove the current player from the round
%then move to the next player. otherwise, just move to the next player
roundFin = 0;

%if last player remaining
if remainingPlayers == 1
    players{currentPlayer}{3} = rank;
    %finish round
    roundFin = 1;    
    return
end

%if player is finished, and hasn't already been ranked
if isempty(players{currentPlayer}{1}) && (length(players{currentPlayer}) < 3 || isempty(players{currentPlayer}{3}))
    %display rank message to player
    switch rank
        case 1
            suf = 'st';
        case 2
            suf = 'nd';
        case 3
            suf = 'rd';
        otherwise
            suf = 'th';
    end
    fprintf('%s, you ranked %d%s place for this round!\n',players{currentPlayer}{2},rank,suf);
    pause(0.3);
    players{currentPlayer}{3} = rank;
    rank = rank + 1;
    remainingPlayers = remainingPlayers - 1;
end

%go to next player
startingPlayer = currentPlayer; %last person to play a card will start the next trick
if currentPlayer < playerCount
    currentPlayer = currentPlayer + 1; %goto next player
else
    currentPlayer = 1; %if last player, go to first
end

while length(players{currentPlayer}) > 2 && ~isempty(players{currentPlayer}{3}) %while currentPlayer is finished
    if currentPlayer >= playerCount %loop back to first player
    currentPlayer = 1;
    else
      currentPlayer = currentPlayer + 1; %goto next player  
    end
end 
%check if startingPlayer played their last card
if length(players{startingPlayer}) > 2 && ~isempty(players{startingPlayer}{3})
    startingPlayer = currentPlayer;
end

%check again for last player
if remainingPlayers == 1
    players{currentPlayer}{3} = rank;
    roundFin = 1;    
    return
end
end