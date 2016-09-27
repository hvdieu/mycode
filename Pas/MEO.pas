Const    inp = '';
         out = '';
         maxn = 10001;
Var      fi,fo  :       text;
         n,k,i,t    :       longint;
         a      :       array [1..maxn] of char;
         r,g,w :       boolean;
{*       *      *       *       *       *}
BEGIN
        Assign(fi,inp);reset(fi);
        readln(fi,n,k);
        For i:=1 to n do read(fi,a[i]);
        close(fi);
        a[n+1]:=a[1];
        For t:=1 to k do
          BEGIN
              For i:=1 to n do
                BEGIN
                    r:=false;
                    g:=false;
                    w:=false;
                    if a[i]= 'G' then g:=true;
                    if a[i]= 'R' then r:=true;
                    if a[i]= 'W' then w:=true;
                    if a[i+1] = 'G' then g:=true;
                    if a[i+1] = 'R' then r:=true;
                    if a[i+1] = 'W' then w:=true;
                    if g and r then
                      BEGIN
                         a[i]:='W';
                         if i=1 then a[n+1]:= 'W';
                         if i=n then
                            BEGIN
                               a[i+1]:='W';
                               a[1]:='W';
                            END
                              else a[i+1]:='W';
                      END
                        else if g and w then
                           BEGIN
                              a[i]:='R';
                              if i=1 then a[n+1]:='R';
                              a[i+1]:='R';
                              if i=n then a[1]:='R';
                           END
                             else if r and w then
                                 BEGIN
                                     a[i]:= 'G';
                                     if i=1 then a[n+1]:='G';
                                     a[i+1]:='G';
                                     if i=n then a[1]:= 'G';
                                 END;
                END;

          END;
        Assign(fo,out);rewrite(fo);
        For i:=1 to n do
        write(fo,a[i]);
        close(fo);
END.
