%initialise and run game
clear
clc

%initialise player cells
gameIntro
playerCount = str2num(input('How many players will there be? (between 3 and 8) ','s'));
while isempty(playerCount) || playerCount < 3 || playerCount > 8 || mod(playerCount,1)~=0
    fprintf('Invalid input.\n');
    playerCount = str2num(input('How many players will there be? ','s'));
end
players = [];
for i = 1:playerCount
    players = [players {{[]}}];
    players{i}{4} = 0;
    players{i}{2} = input(sprintf('Please enter a player name for player %d (leave blank for default name)\n',i),'s');
    if isempty(players{i}{2})
        players{i}{2} = "Player " + i;
    end
end

%determine round cap
roundCap = str2num(input('Please enter the number of rounds to play, or leave blank for no round cap\n','s'));
if isempty(roundCap)
    roundCap = inf;
end

%determine number of decks to use
switch playerCount
    case {3,4}
    numDecks = 1;
    otherwise
    numDecks = 2;
end

%initialise each player's starting hand
fprintf('Shuffling deck...\n');
pause(0.6);
players = deckInit(numDecks, playerCount, players);

%run the first round
startingPlayer = randi(playerCount); %random starting player
fprintf('The starting player will be %s!\n',players{startingPlayer}{2});
pause(0.2);
[players,startingPlayer] = roundRun(players,startingPlayer,playerCount);
roundsPlayed = 1;
fprintf('There has been 1 round played.\n');

if roundsPlayed >= roundCap %reached cap
    fprintf('There have been %d rounds played.\n',roundsPlayed);
    gameEnd(players,playerCount);
    return
end

while 1 %until quit
    %display game state
    if roundsPlayed ~= 1
        fprintf('There have been %d rounds played.\n',roundsPlayed);
    end
    %ask if player wants to quit 
    doQuit = str2num(input('Would you like to keep playing? (1 for yes, 0 for no) ','s'));
    while isempty(doQuit) || (doQuit ~= 1 && doQuit ~= 0)
        fprintf('Invalid input.\n');
        doQuit = str2num(input('Would you like to keep playing? (1 for yes, 0 for no) ','s'));
    end
    if doQuit == 0
        gameEnd(players,playerCount);
        return
    end
    %deal out the deck
    fprintf('Shuffling deck...\n');
    pause(0.6);
    for i = 1:playerCount
        players{i}{1} = [];
    end
    players = deckInit(numDecks, playerCount, players);
    %assign roles and trade cards
    fprintf('Trading cards...\n');
    pause(0.3);
    players = tradeCards(players,playerCount);
    %reset previous round positions
    for i = 1:playerCount
       players{i}{3} = [];
    end
    %run round
    fprintf('The starting player will be %s!\n',players{startingPlayer}{2});
    [players,startingPlayer] = roundRun(players,startingPlayer,playerCount);
    roundsPlayed = roundsPlayed + 1;
    if roundsPlayed >= roundCap %reached cap
        fprintf('There have been %d rounds played.\n',roundsPlayed);
        gameEnd(players,playerCount);
        return
    end
end

