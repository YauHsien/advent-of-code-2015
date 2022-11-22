%% [https://adventofcode.com/2015/day/1](https://adventofcode.com/2015/day/1)

%% --- Day 1: Not Quite Lisp ---
%% Santa was hoping for a white Christmas, but his weather machine's "snow" function is powered by stars, and he's fresh out! To save Christmas, he needs you to collect fifty stars by December 25th.
%%
%% Collect stars by helping Santa solve puzzles. Two puzzles will be made available on each day in the Advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!
%%
%% Here's an easy puzzle to warm you up.
%%
%% Santa is trying to deliver presents in a large apartment building, but he can't find the right floor - the directions he got are a little confusing. He starts on the ground floor (floor 0) and then follows the instructions one character at a time.
%%
%% An opening parenthesis, (, means he should go up one floor, and a closing parenthesis, ), means he should go down one floor.
%%
%% The apartment building is very tall, and the basement is very deep; he will never find the top or bottom floors.
%%
%% For example:
%%
%% (()) and ()() both result in floor 0.
%% ((( and (()(()( both result in floor 3.
%% ))((((( also results in floor 3.
%% ()) and ))( both result in floor -1 (the first basement level).
%% ))) and )())()) both result in floor -3.
%% To what floor do the instructions take Santa?
input('day-01.input').

read-input(StreamAlias, Result) :-
    input(FileName),
    open(FileName, read, _Fd, [alias(StreamAlias)]),
    get-chars(StreamAlias, Result),
    close(StreamAlias).

get-chars(StreamAlias, Result) :-
    get-chars(StreamAlias, [], Result).

get-chars(StreamAlias, Acc, Result) :-
    get_char(StreamAlias, C),
    ( end_of_file == C, !,
      reverse(Acc, Result)
    ; get-chars(StreamAlias, [C|Acc], Result)
    ).

floor(Floor, [], Floor) :- !.
floor(Floor, ['('|Rest], FloorN) :- !,
    floor(Floor+1, Rest, FloorN).
floor(Floor, [')'|Rest], FloorN) :- !,
    floor(Floor-1, Rest, FloorN).

solution(N) :-
    read-input(input, Input),
    floor(0, Input, Add),
    N is Add.
%% Your puzzle answer was `?- solution(N)`.
%%
%% The first half of this puzzle is complete! It provides one gold star: *

%% --- Part Two ---
%% Now, given the same instructions, find the position of the first character that causes him to enter the basement (floor -1). The first character in the instructions has position 1, the second character has position 2, and so on.
%%
%% For example:
%%
%% ) causes him to enter the basement at character position 1.
%% ()()) causes him to enter the basement at character position 5.
%% What is the position of the character that causes Santa to first enter the basement?
floor(NthStep, OnFloor, ToFloor, ['('|_Rest], NthStep+1) :-
    ToFloor is OnFloor +1, !.
floor(NthStep, OnFloor, ToFloor, [')'|_Rest], NthStep+1) :-
    ToFloor is OnFloor -1, !.
floor(NthStep, OnFloor, ToFloor, ['('|Rest], MthStep) :- !,
    floor(NthStep+1, OnFloor+1, ToFloor, Rest, MthStep).
floor(NthStep, OnFloor, ToFloor, [')'|Rest], MthStep) :- !,
    floor(NthStep+1, OnFloor-1, ToFloor, Rest, MthStep).

solution2(N) :-
    read-input(input, Input),
    floor(0, 0, -1, Input, NthStep),
    N is NthStep.
%% Your puzzle answer was `?- solution2(N)`.
%%
%% Both parts of this puzzle are complete! They provide two gold stars: **
