function [players,remainingPlayers,rank,roundFin,startingPlayer] = trickRun(playerCount,players,startingPlayer,remainingPlayers,rank,roundFin)
%play through a trick

%initalise values
currentPlayer = startingPlayer;
skipCount = 0;
prevCard = 0;

%first player's turn
[players,prevCard,trickSize,curCard] = firstPlayer(players,currentPlayer,prevCard);

[players,currentPlayer,remainingPlayers,rank,roundFin,startingPlayer] = rankPlayer(playerCount,players,currentPlayer,remainingPlayers,rank,startingPlayer); %check win
if roundFin == 1 %check win
    return
end

%ask each player to play a card or skip
while skipCount < remainingPlayers
    %ask next player to play
    action = str2num(input(sprintf('%s, enter ''1'' to play a card or ''2'' to skip your turn: ',players{currentPlayer}{2}),'s')); 
    while isempty(action) || (action ~= 1 && action ~= 2)
        fprintf('Invalid input.\n');
        action = str2num(input('Enter ''1'' to play a card or ''2'' to skip your turn: ','s'));
    end
    
    if action == 1        
        %play a card
        [players,skipCount,curCard,prevCard] = cardPlay(players,skipCount,trickSize,curCard,prevCard,currentPlayer);
    else
        %skip turn
        skipCount = skipCount + 1; %count skipped turns
    end
    [players,currentPlayer,remainingPlayers,rank,roundFin,startingPlayer] = rankPlayer(playerCount,players,currentPlayer,remainingPlayers,rank,startingPlayer); %check for win
    if roundFin == 1 %check win
        return
    end
end
end