Const   inp = '';
        out = '';
        maxn = 1001;
Var     fi,fo   :       text;
        a,b,res   :  extended;
        i,n       :       integer;

BEGIN
       Assign(fi,inp); reset(fi);
       readln(fi,n,a);
       b := 0;
       For i := 3 to n do
         if ((i-2)*a-(i-1)*(i-2)) / (i-1) > b then b := ((i-2)*a-(i-1)*(i-2)) / (i-1);
       res := (n-1) * b - ((n-2)*a - (n-1)*(n-2));
       Assign(fo,out); rewrite(fo);
       write(fo,res:0:2);
       close(fo);
END.