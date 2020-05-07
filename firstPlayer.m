function [players,prevCard,trickSize,curCard] = firstPlayer(players,currentPlayer,prevCard)
%runs the first player's turn in each trick

%init
loopFinInner = 0;
loopFinOuter = 0;
%display hand
fprintf('\n%s, Your hand contains %d cards:\n',players{currentPlayer}{2},length(players{currentPlayer}{1}));
fprintf('%s ',cardVals(players{currentPlayer}{1},1));
playerMinHand = min(players{currentPlayer}{1}); %player's lowest card
playerMaxHand = max(players{currentPlayer}{1}); %player's highest card


%init card to play and no of cards, each with a way to return backwards
%init card to play
while loopFinOuter ~= 1 %return until a legal play is made
    doBreak = 0; %reset all loops
    curCard = cardVals(upper(string(input('\nWhich card would you like to play? ','s'))),2,1); %enter uppercase string input
 %check how many of curCard the player has
 c = 0;
   for i = 1:length(players{currentPlayer}{1}) %check through player's hand
       if players{currentPlayer}{1}(i) == curCard %find how many of curCard they have
           c = c+1;
       end
   end   
  while curCard < prevCard || curCard < playerMinHand || curCard > playerMaxHand || c == 0
       fprintf('\nYou cannot play that card');
       curCard = cardVals(upper(string(input('\nWhich card would you like to play? ','s'))),2,1); %enter uppercase string input
       c = 0;
   for i = 1:length(players{currentPlayer}{1}) %check through player's hand
       if players{currentPlayer}{1}(i) == curCard %find how many of curCard they have
           c = c+1;
       end
   end   
  end

  
%init no of cards
while loopFinInner ~= 1 %keep returning until a legal play is made   
   trickSize = str2num(input('\nHow many cards would you like to play? ','s')); %no of cards per player
    while isempty(trickSize) || trickSize < 1 || trickSize > 4 || ~mod(trickSize,1)==0%check if legal
       fprintf('You can only play between 1 and 4 cards\n');
       trickSize = str2num(input('\nHow many cards would you like to play? ','s'));
    end   
    
   while trickSize > c %if they dont have enough of that card
       fprintf('\nYou only have %d of that card\n',c);
       y = str2num(input('Would you like to play less of that card (1) or play a different card (2)? ','s'));
       while isempty(y) || ~(y == 1 || y == 2) %only accept either 1 or 2
        y = str2num(input('Would you like to play less of that card (1) or play a different card (2)? ','s'));
       end
       
       if y == 1 %return to redetermine trickSize
           break
       else
           %play a different card
           %return to curCard
           doBreak = 1;
           break
       end
   end
   %play the card(s)
    if trickSize <= c && doBreak == 0 %only triggered once everything finishes
        loopFinInner = 1; 
        loopFinOuter = 1; 
        prevCard = curCard;
        %remove cards from hand
        i = 1;
        while i <= trickSize
            for j = 1:length(players{currentPlayer}{1})
                if players{currentPlayer}{1}(j) == curCard
                   players{currentPlayer}{1}(j) = [];
                   i = i + 1;
                   break
                end
            end
        end
        %display a message
        if trickSize == 1 %pluralising or not
            fprintf('You played 1 %s\n',cardVals(curCard,1,1));
        else
            fprintf('You played %d %ss\n',trickSize,cardVals(curCard,1,1));
        end
    end
    if doBreak == 1
        break
    end
end
end
end