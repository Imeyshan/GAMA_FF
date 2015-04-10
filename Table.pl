/*operators*/
:- op(1000,xfy,'and').
:- op(1000,xfy,'or').
:- op(900,fy,'not').

discover _vars(N,V,V) :- member(N,[0,1]),!.    /* Boolean constants in expression */
discover_vars(X,Vin,Vout) :- atom(X), 
                         (member(X,Vin) -> Vout = Vin ;   /* already have  */
                            Vout = [X|Vin]).                 /* include           */
discover_vars(X and Y,Vin,Vout) :- discover_vars(X,Vin,Vtemp),
                               discover_vars(Y,Vtemp,Vout).
discover_vars(X or Y,Vin,Vout) :-  discover_vars(X,Vin,Vtemp),
                               discover_vars(Y,Vtemp,Vout).
discover_vars(not X,Vin,Vout) :-   discover_vars(X,Vin,Vout).

first_assign([],[]).
first_assign([X|R],[0|S]) :- first_assign(R,S).

successor(A,S) :- reverse(A,R),
                  next(R,N),
                  reverse(N,S).


next([0|R],[1|R]).
next([1|R],[0|S]) :- next(R,S).

true_value(N,_,_,N) :- member(N,[0,1]).
true_value(X,Vars,A,Val) :- atom(X),
                             lookup(X,Vars,A,Val).
true_value(X and Y,Vars,A,Val) :- true_value(X,Vars,A,VX),
                                   true_value(Y,Vars,A,VY),
                                   boole_and(VX,VY,Val).
true_value(X or Y,Vars,A,Val) :-  true_value(X,Vars,A,VX),
                                   true_value(Y,Vars,A,VY),
                                   boole_or(VX,VY,Val).
true_value(not X,Vars,A,Val) :-   true_value(X,Vars,A,VX),
                                   boole_not(VX,Val).

lookup(X,[X|_],[V|_],V).
lookup(X,[_|Vars],[_|A],V) :- lookup(X,Vars,A,V).

