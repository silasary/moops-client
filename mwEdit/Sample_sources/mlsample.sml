(* A Sample Standard ML Source File *)
(* Version 0.1 *)
(* By David Muir *)


(* A slow version of a factorial function *)
fun factorial 0 = 1
| factorial n = n * factorial (n-1);

(* An optimised version of a factorial function *)
fun fast_factorial n = let
			fun facti (n,p) = if (n = 0) then p else facti (n-1, n*p)
		       in facti (n, 1)
end;	

(* A slow version of a power function *)
fun power (x, 0) = 1
| power (x, n) = x * power (x, n-1);

(* An optimised version of a power function *)
fun fast_power (x, 0) = 1
| fast_power (x, n) = if ((n mod 2) = 0) then fast_power (x*x, (n div 2))
		      else x * fast_power (x*x, (n div 2));