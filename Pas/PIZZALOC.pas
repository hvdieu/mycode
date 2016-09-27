Const   inp = '';
        out = '';
        maxn = 25;
type    arr     =       array [1..110] of boolean;
Var     fi,fo   :       text;
        ax,ay,s   :       array [1..110] of longint;
        d       :       array [1..maxn,1..110] of longint;
        free    :       array [1..110] of boolean;
        k,m,r,res,n,st   :       longint;
        mx,my,x   :       array [0..maxn] of longint;

Procedure input;
Var i,j : longint;
        BEGIN
               Assign(fi,inp) ;reset(fi);
               readln(fi,k,r);
               readln(fi,m);
               For i := 1 to m do readln(fi,mx[i],my[i]);
               readln(fi,n);
               for i := 1 to n do readln(fi,ax[i],ay[i],s[i]);
               close(fi);
        END;

Procedure init;
Var i,j : longint;
        BEGIN
               For i := 1 to m do
                  For j := 1 to n do
                     d[i,j] := sqr(mx[i] - ax[j]) + sqr(my[i] - ay[j]);
               x[0] := 0;
               res := 0;
               r := r*r;
               st := 0;
               fillchar(free,sizeof(free),true);
        END;

Procedure main;
Var u,v,st : longint;
        BEGIN
              st := 0;

              For u := 1 to k do
                 BEGIN
                       For v := 1 to n do
                          if (d[x[u],v] <= r) and free[v] then
                            BEGIN
                                 st := st + s[v];
                                 free[v] := false;
                            END;
                 END;
              if st > res then res := st;
        END;

Procedure ql( i : longint);
Var j,v,sum : longint;
    cx  : arr;
        BEGIN
              For j := x[i-1] + 1 to m - k + i do
                 BEGIN
                       x[i] := j;
                       cx := free;
                       sum := st;
                       for v := 1 to n do
                          if (d[j,v] <= r) and free[v] then
                             BEGIN
                                   free[v] := false;
                                   st := st + s[v];
                             END;
                       if i = k then
                          BEGIN
                               if st > res then res := st;
                          END
                          else ql(i+1);
                       free := cx;
                       st := sum;
                 END;
        END;

BEGIN
       input;
       init;
       ql(1);
       Assign(fo,out); rewrite(fo);
       write(fo,res);
       close(fo);
END.