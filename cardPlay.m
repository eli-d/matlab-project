function [players,skipCount,curCard,prevCard] = cardPlay(players,skipCount,trickSize,curCard,prevCard,currentPlayer)
%allows current player to play 1 or more cards

%init
loopFinInner = 0;
loopFinOuter = 0;
%display hand
if trickSize == 1 %fix pluralisation
    s = '';
else
    s = 's';
end
fprintf('The current trick size is %d card%s and the current card value is %s\n',trickSize,s,cardVals(curCard,1,0));
fprintf('\n%s, Your hand contains %d cards:\n',players{currentPlayer}{2},length(players{currentPlayer}{1}));
fprintf('%s ',cardVals(players{currentPlayer}{1},1,0));
playerMinHand = min(players{currentPlayer}{1}); %player's lowest card
playerMaxHand = max(players{currentPlayer}{1}); %player's highest card

%determine play
while loopFinOuter ~= 1 %return until a legal play is made
    doBreak = 0; %reset all loops
    curCard = cardVals(upper(string(input('\nWhich card would you like to play? (Enter 0 to skip) ','s'))),2,0); %enter uppercase string input
    if curCard == 0 %if skipped
        skipCount = skipCount + 1;
        curCard = prevCard; %reset
    return
    end
 %check how many of curCard the player has
 c = 0;
   for i = 1:length(players{currentPlayer}{1}) %check through player's hand
       if players{currentPlayer}{1}(i) == curCard %find how many of curCard they have
           c = c+1;
       end
   end   
   
  while curCard < prevCard || curCard < playerMinHand || curCard > playerMaxHand || c == 0 %check if legal play
       fprintf('\nYou cannot play that card');
       curCard = cardVals(upper(string(input('\nWhich card would you like to play? (Enter 0 to skip) ','s'))),2,0); %enter uppercase string input
        if curCard == 0 %if skipped
            skipCount = skipCount + 1;
            curCard = prevCard; %reset
            return
         end
       
c = 0;
   for i = 1:length(players{currentPlayer}{1}) %check through player's hand
       if players{currentPlayer}{1}(i) == curCard %find how many of curCard they have
           c = c+1;
       end
   end   
  end
 
%init no of cards
while loopFinInner ~= 1 %keep returning until a legal play is made
   while trickSize > c %if they dont have enough of that card
       fprintf('\nYou only have %d of that card\n',c);
       %play a different card
       %return to curCard
       doBreak = 1;
       break      
   end
    if doBreak == 1 %return to the first loop
       break
   end
   %play the card(s)
    if trickSize <= c && doBreak == 0 %only triggered once everything finishes
        loopFinInner = 1; %finish looping
        loopFinOuter = 1; 
        prevCard = curCard;
        skipCount = 0; %reset skipped turns if a play is made
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
        if trickSize == 1 %pluralising digit
            fprintf('You played 1 %s\n',cardVals(curCard,1,0));
        else
            fprintf('You played %d %ss\n',trickSize,cardVals(curCard,1,0));
        end
    end
end
end 
end