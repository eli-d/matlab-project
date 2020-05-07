function players = tradeCards(players,playerCount)
%assign a role to players depending on their placement in the
%previous round, then trade cards between their hands accordingly. function
%will not run in the first round where no roles are assigned. cards are
%traded from the outside in (e.g. 1-8,2-7,3-6)

if isempty(players{1}{3}) %first round
    return 
end 

%assign roles
%swap cards
switch playerCount
    case {3,4}
        for i = 1:playerCount
            if players{i}{3} == 1
                %first place
                %index of lowest card is always 1
                lowCard = players{i}{1}(1);
                rich = i;
            elseif players{i}{3} == playerCount
                %last place
                %index of highest card is final card
                highCard = players{i}{1}(length(players{i}{1}));
                poor = i;
            end
        end
        %swap cards
        players{rich}{1}(1) = highCard;
        players{poor}{1}(length(players{poor}{1})) = lowCard;
%append V to vars to represent very (e.g. very rich, very poor)
    case {5,6}
        for i = 1:playerCount
            switch players{i}{3}
                case 1
                    %first place
                    %first two cards
                    lowCardV = players{i}{1}(1:2);
                    richV = i;
                case playerCount
                    %last place
                    %final two cards
                    highCardV = players{i}{1}(length(players{i}{1}):-1:(length(players{i}{1})-1));
                    poorV = i;
                case 2
                    %second place
                    lowCard = players{i}{1}(1);
                    rich = i;
                case playerCount-1
                    %second last place
                    highCard = players{i}{1}(length(players{i}{1}));
                    poor = i;
            end
        end
        %swap cards
        players{richV}{1}(1:2) = highCardV;
        players{poorV}{1}(length(players{i}{1}):-1:(length(players{i}{1})-1)) = lowCardV;   
        players{rich}{1}(1) = highCard;
        players{poor}{1}(length(players{poor}{1})) = lowCard; 
    case {7,8}
        %the same as 5,6 but with an extra trade in the middle
        for i = 1:playerCount
            switch players{i}{3}
                case 1
                    %first place
                    %first two cards
                    lowCardV = players{i}{1}(1:2);
                    richV = i;
                case playerCount
                    %last place
                    %final two cards
                    highCardV = players{i}{1}(length(players{i}{1}):-1:(length(players{i}{1})-1));
                    poorV = i;
                case 2
                    %second place
                    lowCard = players{i}{1}(1);
                    rich = i;
                case playerCount-1
                    %second last place
                    highCard = players{i}{1}(length(players{i}{1}));
                    poor = i;
                case 3
                    %third place
                    lowCardMid = players{i}{1}(1);
                    richMid = i;
                case playerCount-2
                    %third last place
                    highCardMid = players{i}{1}(length(players{i}{1}));
                    poorMid = i;                       
            end
        end
        %swap cards
        %first & last
        players{richV}{1}(1:2) = highCardV;
        players{poorV}{1}(length(players{i}{1}):-1:(length(players{i}{1})-1)) = lowCardV;   
        %second and second last
        players{rich}{1}(1) = highCard;
        players{poor}{1}(length(players{poor}{1})) = lowCard; 
        %third and third last
        players{richMid}{1}(1) = highCardMid;
        players{poorMid}{1}(length(players{poor}{1})) = lowCardMid;    
end
                        
%sort hands
for i = 1:playerCount
    players{i}{1} = sort(players{i}{1});
end
end