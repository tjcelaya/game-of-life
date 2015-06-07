/ seed rng
system "S ",string[neg`int$.z.t mod 1000]

R:{
  p:x*y; inverseChance: floor avg x;y;;
  1 = ((y,x) # (neg p) ? p) mod inverseChance }

life:{
  {(2=x) | (3=x) & x}[sum 1 _ raze (0 -1 1) rotate/:\: (0 -1 1) rotate/:\: x] }

renderMatrix:{[m] ({x,"\n",y}/){?[x;"#";" "]} each "b"$m }

board::R[100;50]

\t 200
.z.ts:{ board::life board }

.z.ws:{ neg[.z.w] renderMatrix board }

.h.HOME:(first system "pwd"),"/static"
