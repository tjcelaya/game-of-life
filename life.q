/ seed rng
system "S ",string[neg`int$.z.t mod 1000]

R:{
  p:x*y;
  1 = ((y,x) # (neg p) ? p) mod 150 }

life:{
  {(2=x) | (3=x) & x}[sum 1 _ raze (0 -1 1) rotate/:\: (0 -1 1) rotate/:\: x] }

renderMatrix:{[m] {x,"\n",y}/[`char$(`int$" ")+m] }

board::R[100;50]

\t 200
.z.ts:{ board::life board }

.z.ws:{
    neg[.z.w] renderMatrix board
  }

// use .h.hp with a list of strings
// to render a valid HTTP response
/.z.ph:{
/    .h.hp enlist renderMatrix board
/  }
