Const    inp = '';
         out = '';
         maxn = 10;
         max  =  10000;
         kq     :       array [1..maxn] of longint = (0,2,2,4,96,1024,2880,81024,770144,6309300);
Var      fi,fo  :       text;
         n,i,j      :       integer;
         x      :       array   [1..2*maxn] of integer;
         c      :       array [1..2*maxn] of boolean;
         res    :       array [1..max] of string;
         dem    :       longint;
         prime  :       array [1..40] of boolean;
         st,si     :       string;
{*       *      *       *       *}
Procedure Xuly;
Var i,j,t : integer;
BEGIN
     inc(dem);
     if dem<=10000 then
     BEGIN
       For i:=1 to n-1 do
        write(fo,x[i],' ');
        writeln(fo,x[n]);
     END
      else
       BEGIN
           close(fo);
           halt;
       END;
END;
{*      *       *       *       *}
Procedure Try ( i : integer);
Var j : integer;
BEGIN
    For j:= 2 to n do
      if c[j] then
      if prime[x[i-1] + j] then
      BEGIN
           x[i]:=j;
           c[j]:=false;
           if i=n then
             BEGIN
              if prime[x[n]+1] then
              xuly;
             END
            else Try(i+1);
           c[j]:=true;
      END;
END;
{*      *       *       *       *}
Procedure Sangngto;
Var i,j : integer;
BEGIN
    For i:=2 to trunc(sqrt(40)) do
      BEGIN
          if prime[i] then
            BEGIN
                j:=i*i;
                While j<=40 do
                  BEGIN
                      Prime[j]:=false;
                      j:=j+i;
                  END;
            END;
      END;
END;
{*      *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    read(fi,n);
    close(fi);
    n:=2*n;
    x[1]:=1;
    x[n+1]:=x[1];
    fillchar(c,sizeof(c),true);
    fillchar(prime,sizeof(prime),true);
    Sangngto;
    Assign(fo,out);rewrite(fo);
    writeln(fo,kq[n div 2]);
    Try(2);
    close(fo);
END.
