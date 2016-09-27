Const   inp = '';
        out = '';
        maxn = 100;
Var     fi,fo   :       text;
        a       :       array [1..maxn,1..maxn] of longint;
        d,trace       :       array [1..maxn,1..maxn] of longint;
        path    :     array [1..maxn] of longint;
        u,v,c,i,j,n,m,k,z,st,dem : longint;
        stop : boolean;
{*      *       *       *       *}
{Procedure ford(u,v : integer);
Var i,j,f : integer;
BEGIN
    For i:=1 to n do
     d[i]:=maxint;
     d[u]:=0;
     stop:=false;
     Repeat
       BEGIN
           stop:=true;
           For i:=1 to n do
             For j:=1 to n do
               if d[j] > d[i] + a[i,j] then
                 BEGIN
                     d[j]:=d[i] + a[i,j];
                     trace[j]:=i;
                     stop:=false;
                 END;
       END;
         until stop;
       if z=0 then
         writeln(fo,d[v])
           else
             BEGIN
                 dem:=0;
                 While u <> v do
                   BEGIN
                       inc(dem);
                       path[dem]:=v;
                       v:=trace[v];
                   END;
                 inc(dem);
                 path[dem]:=u;
                 write(fo,dem,' ');
                 For f:=dem downto 1 do
                   write(fo,path[f],' ');
                 writeln(fo);

             END;

END;   }
{*      *       *       *       *}
Procedure Floyd;
Var i,j,l : integer;
BEGIN
    For i:=1 to n do
      For j:=1 to n do
         trace[i,j]:=j;
      For l:=1 to n do
        For i:=1 to n do
          For j:=1 to n do
           if a[i,j] > a[i,l] + a[l,j] then
             BEGIN
                 a[i,j] := a[i,l] + a[l,j];
                 trace[i,j] := trace[i,l];
             END;
END;
{*      *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    Assign(fo,out);rewrite(fo);
    readln(fi,n,m,k);
    For i:=1 to n do
      For j:=1 to n do
       if i=j then a[i,j]:=0
        else
        a[i,j]:=maxint;
    For i:=1 to m do
      BEGIN
          readln(fi,u,v,c);
          a[u,v]:=c;
          a[v,u]:=c;
      END;
      floyd;
    For st:=1 to k do
      BEGIN
          readln(fi,z,u,v);
          if z=0 then writeln(fo,a[u,v])
            else
              BEGIN
                  dem:=0;
                  repeat
                    BEGIN
                        inc(dem);
                        path[dem]:=u;
                        u:= trace[u,v];
                    END;
                      Until u=v;
                    inc(dem);
                    path[dem]:=v;
                    write(fo,dem,' ');
                    For i:=1 to dem do
                      write(fo,path[i],' ');
                    writeln(fo);
              END;
      END;
    Close(fi);
    Close(fo);
END.
