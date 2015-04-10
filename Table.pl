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