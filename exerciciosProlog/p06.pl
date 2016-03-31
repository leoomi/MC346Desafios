%P06 (*) Find out whether a list is a palindrome.
palindrome(X) :-
    reverse(X,X,[]).
