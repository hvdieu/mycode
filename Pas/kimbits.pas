const   inp = 'kimbits.inp';
        out = 'kimbits.ou1';
        maxi = 33;
Var     fi,fo   :       text;
        x       :       array [1..maxi] of integer;
        s       :       array [0..1] of longint;
        n,l     :       longint;
        k,dem       :       int64;
{*      *       *       *       *}
Procedure Input;
BEGIN
    assign(fi,inp);reset(fi);
    read(fi,n,l,k);
    close(fi);
    assign(fo,out);rewrite(fo);
    dem:=0;
    s[1]:=l;
    s[0]:=n ;

END;
{*      *       *       *       *}
Procedure Try(i : integer);
Var j,t : longint;
BEGIN
    For j:=0 to 1 do
       if s[j]>0 then
         BEGIN
             x[i]:=j;
             Dec(s[j]);
               if i=n then
                 BEGIN
                   inc(dem);
                     BEGIN
                             if dem=k then
                               BEGIN
                               for t:=1 to n do write(fo,x[t]);
                                close(fo);
                                halt;
                             END;
                     END;

                 END
                else Try(i+1);
            Inc(s[j]);
         END;
END;
{*      *       *       *       *}
BEGIN
   input;
   try(1);

END.
