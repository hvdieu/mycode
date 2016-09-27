Const    inp = '';
         out = '';
         maxn = 15;
Var      fi,fo  :       text;
         n      :       byte;
         a      :       array [1..maxn] of integer;
         p      :       longint;
         x,b      :       array [1..maxn] of integer;
         d      :       array [1..maxn] of boolean;
         dem,kq    :       longint;
         ok1,ok2   :       boolean;
{*       *      *       *       *}
Procedure Input;
Var i : integer;
BEGIN
    assign(fi,inp);reset(fi);
    i:=0;
    While not seekeoln(fi) do
      BEGIN
          Inc(i);
          read(fi,a[i]);
      END;
    n:=i;
    readln(fi);
    read(fi,p);
    close(fi);
    fillchar(x,sizeof(x),0);
    fillchar(d,sizeof(d),true);
    dem:=0;
    ok1:=false;
    ok2:=false;
END;
{*      *       *       *       *}
Function kt : boolean;
Var u : integer;
    ok : boolean;
BEGIN
    ok:=true;
    For u:=1 to n do
      if a[u]<>x[u] then BEGIN
                             ok:=false;
                             break;
                         END;
      kt:=ok;
END;
{*      *       *       *       *}
Procedure Try ( i : integer);
Var j,k : integer;
BEGIN
     For j:=1 to n do
       if d[j] then
         BEGIN
             x[i]:=j;
             if i=n then BEGIN
                             Inc(dem);
                             if dem=p then
                              BEGIN
                                  for k:=1 to n do b[k]:=x[k];
                                  ok2:=true;
                              END;
                             if kt then BEGIN
                                            kq:=dem;
                                            ok1:=true;
                                        END;
                             if ok1 and ok2 then exit;
                         END
                          else
                            BEGIN
                              d[j]:=false;
                              Try(i+1);
                              d[j]:=true;
                            END;

         END

END;
{*      *       *       *       *}
Procedure Output;
Var i : integer;
BEGIN
    assign(fo,out);rewrite(fo);
    writeln(fo,kq);
    For i:=1 to n do
     write(fo,b[i],' ');
    Close(fo);
END;
{*      *       *       *       *}
BEGIN
        input;
        try(1);
        output;
END.
