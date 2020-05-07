function winIndex = winSort(playerCount,winCount)
%create a vector winIndex that orders the players based on number of wins

winCountSort = sort(winCount,'descend'); %winCount sorted descending
winIndex = []; %output
remVal = [1:playerCount]; %stop duplicates

for i = 1:length(winCount) %move through winCount
    for j = 1:length(winCount) %move through winCountSort
        if winCount(i) == winCountSort(j) && remVal(j) ~= 0 %if same player
            winIndex(j) = i; %store index
            remVal(j) = 0;
            break
        end
    end
end
