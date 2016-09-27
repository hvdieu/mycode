{
ID: pynhp9x1
PROG: calfflac
LANG: PASCAL
}

const   inp = 'calfflac.in';
        out = 'calfflac.out';
        maxn = 20000;
Var     fi,fo    :       text;
        si,s        :       array [1..maxn] of char;
        d       :   array [1..maxn] of boolean;
        c,l,cs     :   array [1..maxn] of integer;
        n,m,max,first,last,res       :   integer;
{*      *       *   *   *}
Procedure input;
Var i,j : integer;
BEGIN

    assign(fi,inp);reset(fi);
    i:=0;j:=0;
    While not eof(fi) do
      BEGIN
          inc(i);
          read(fi,si[i]);
          if (si[i] in ['A'..'Z']) or (si[i] in ['a'..'z']) then
             BEGIN
                 inc(j);
                 s[j]:=si[i];
                 cs[j]:=i;
             END;
      END;
    n:=i;
    m:=j;
    close(fi);
END;
{*      *       *       *}
Procedure Init;
Var i : integer;
BEGIN
      for i:=1 to m do
        s[i]:=upcase(s[i]);
      fillchar(c,sizeof(c),0);
      for i:=1 to m do
       l[i]:=1;
      max:=1;
      first:=cs[1];
      last:=cs[1];
END;
{*      *       *       *}
Procedure Solve;
Var i,dem,dau,cuoi : integer;
BEGIN
    for i:=2 to m-1 do
      BEGIN
          dem:=1;
          dau:=i;
          cuoi:=i;
        While (dau>1) and (cuoi<m) do
         BEGIN
                if s[dau-1]=s[cuoi+1] then
                  BEGIN
                    dem:=dem+2;
                    dau:=dau-1;
                    cuoi:=cuoi+1;
                      if dem>max then
                        BEGIN
                          max:=dem;
                          first:=cs[dau];
                          last:=cs[cuoi];
                        END;
                 END
                   else break;
            END;
         l[i]:=dem;
      END;
    For i:=2 to m-2 do
        BEGIN
            if s[i]=s[i+1] then
                 BEGIN
                     dem:=2;
                     dau:=i;
                     cuoi:=i+1;
                     if dem> max then
                       BEGIN
                           max:=dem;
                           first:=cs[dau];
                           last:=cs[cuoi];
                       END;
                     While (dau>1) and (cuoi<m) do
                         BEGIN
                             if s[dau-1]=s[cuoi+1] then
                               BEGIN
                                   dem:=dem+2;
                                   Dec(dau);
                                   Inc(cuoi);
                                   if dem>max then
                                     BEGIN
                                         max:=dem;
                                         first:=cs[dau];
                                         last:=cs[cuoi];
                                     END;
                               END
                                   else break;
                         END;

                     c[i]:=dem;
                 END;
        END;
END;
{*      *       *       *}
Procedure Output;
Var i : integer;
BEGIN
     assign(fo,out);rewrite(fo);
     writeln(fo,max);
     for i:=first to last do
        write(fo,si[i]);
     writeln(fo);
     close(fo);
END;
{*      *       *       *}
BEGIN
     input;
     init;
     solve;
     output;
END.
