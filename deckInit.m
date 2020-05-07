
function [players] = deckInit(numDecks, playerCount, players)
%create n decks stored in vector deck, then randomly and evenly divide
%cards between all players

%init vars
deck = [];
n = numDecks;

%create n decks
for i = 1:4*n %4 of each card
deck = [deck 1:13];
end

%divide randomly
for i = 1:length(deck) 
    %deal cards 1 at a time to each player
   for j = 1:playerCount
       %avoid error when deck is empty
       if ~isempty(deck)
           %choose a random card in the deck
           deckIndex = randi([1, length(deck)]);
           %add it to the first cell of each player which is their hand in a vector
           players{j}{1} = [players{j}{1} deck(deckIndex)];
           deck(deckIndex) = [];
       end
   end
end
%sort hands for readability
for i = 1:playerCount
    players{i}{1} = sort(players{i}{1});
end
end
   