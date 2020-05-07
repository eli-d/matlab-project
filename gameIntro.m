function gameIntro
%gives the user an introduction to the game
fprintf('Welcome to my project. I have created the game Rich Man Poor Man, originally a Japanese card game called Daifugo.\n');
pause(0.5)
%display rules if user wants to
viewRules = upper(input('Would you like to view the rules? [Y/N] ','s'));
while viewRules == 'Y' %print one section at a time
    A = importdata('project_ruleset.txt');
    clc
    fprintf('%s\n',A{1});
    cont;
    for i = 2:6
        fprintf('%s\n',A{i});
    end
    cont;
    fprintf('%s\n',A{7});
    cont;
    for i = 8:9
        fprintf('%s\n',A{i});
    end
    cont;
    for i = 10:11
        fprintf('%s\n',A{i});
    end
    input('\nPress enter to continue','s');   
    viewRules = upper(input('Would you like to view the rules again? [Y/N] ','s'));    
end %assume other inputs are no
end

function cont
%move to next section
input('\nPress enter to continue','s');   
clc
end