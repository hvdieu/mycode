Const   inp = 'People.inp';
        out = 'People.out';
        maxn = 21;
Var     fi,fo   :       text;
        x       :       array [1..maxn] of integer;
        a       :       array [1..maxn,1..maxn] of integer;
        n       :       integer;
{*      *       *       *       *       *}
procedure input;
Var i,k,t,j : integer;
BEGIN
    assign(fi,inp);reset(fi);
    readln(fi,n);
    For i:=1 to n do
      For j:=1 to n do
        a[i,j]:=2;
    For i:=1 to n do
      BEGIN
          read(fi,k);
          For j:=1 to k do
            BEGIN
                read(fi,t);
                a[i,t]:=1;
            END;
          readln(fi);
          read(fi,k);
          For j:=1 to k do
            BEGIN
                read(fi,t);
                a[i,t]:=0;
            END;
          readln(fi);
      END;
    close(fi);
END;
{*      *       *       *       *       *}
procedure output;
Var i : integer;
BEGIN
    assign(fo,out);rewrite(fo);
    For i:=1 to n do
     if x[i]=0 then writeln(fo,'FALSE')
      else writeln(fo,'TRUE');
    close(fo);
    halt;
END;
{*      *       *       *       *       *}
Procedure Solve;
Var u,v,ok : integer;
BEGIN
    For u:=1 to n do
      BEGIN
          ok:=1;
          for v:=1 to n do
            if a[u,v]<> 2 then
              BEGIN
                 if a[u,v]<>x[v] then
                   BEGIN
                       ok:=0;
                       break;
                   END;
              END;
          if ok<>x[u] then exit;
      END;
      output;
END;
{*      *       *       *       *       *}
Procedure Try(i : integer);
Var j : integer;
BEGIN
    For j:=0 to 1 do
      BEGIN
          x[i]:=j;
          if i=n then solve
            else Try(i+1);
      END;
END;
{*      *       *       *       *       *}
BEGIN
    input;
    try(1);
END.