function outVal = cardVals(cards,convType,firstPlay)
%convert between a card's value and what it's displayed as. 
%convType = 1 
    %value to appearance
    %input as integer, output as string (e.g. 13) gives "2"
%convType = 2 
    %appearance to value
    %input as string, output as integer (e.g. "2") gives 13
            
%input validate
%inputs 1-10, J,Q,K
if convType == 2 
    while length(cards) ~= 1 || ~any(cards == [1:10 "J" "Q" "K"])
        if cards == "0" %if turn skipped
            outVal = 0;
            return
        end
        fprintf('\nYou cannot play that card');
        if firstPlay == 1
            cards = upper(string(input('\nWhich card would you like to play? ','s')));
        else
            cards = upper(string(input('\nWhich card would you like to play? (Enter 0 to skip) ','s')));
        end
    end
end
    
    
outVal = [];
values = [12:13 1:11];
app = [1:10 "J" "Q" "K"];
for i = 1:length(cards)
    switch convType
        case 1 %value to appearance
            %find index of card's appearance
            for j = 1:13
                if values(j) == cards(i)
                    index = j;
                    break
                end
            end
            %return card appearance
            outVal = [outVal app(index)];
        case 2 %appearance to value 
            for j = 1:13
                if app(j) == cards(i)
                    index = j;
                    break
                end
            end
            %return card value
            outVal = values(index); %only one output needed
            break
    end
end
end