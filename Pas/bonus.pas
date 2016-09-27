Const  inp = '';
        out = '';
        maxn = 1001;
Var     fi,fo   :       text;
        n,i,j,k,u,v       :       integer;
        a       :       array [1..maxn,1..maxn] of integer;
        s       :       array [0..maxn,0..maxn] of longint;
        max,t     :       longint;
{*      *       *       *       *       *}

{*      *       *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n,k);
    For i:=1 to n do
     For j:=1 to n do read(fi,a[i,j]);
    For i:=1 to n do
      For j:=1 to n do
        s[i,j]:= s[i-1,j] + s[i,j-1] + a[i,j] - s[i-1,j-1];
    For i:= k to n do
      For j:= k to n  do
        BEGIN
           u:= i -k +1;
           v:= j-k+1;
           t:= s[i,j] - s[u-1,j] - s[i,v-1] + s[u-1,v-1];
           if max < t then max:=t;
        END;
      Assign(fo,out);rewrite(fo);
      write(fo,max);
      close(fo);
END.
