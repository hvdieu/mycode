Const   inp = '';
        out = '';
Var     fi,fo : text;
        n,dem1,dem2,i       :       longint;
        res     :       ansistring;
        t       :       integer;
        ch      :       string;
        kl      :       array [0..17] of longint;
        a1,a2   :       array [1..17] of longint;
        dem     :       array [0..17] of longint;
{*      *       *       *       *}
Procedure Phantich(n : longint);
BEGIN
    While n<>0 do
      BEGIN
          t:= n mod 3;
          str(t,ch);
          res:=res+ch;
          n:= n div 3;
      END;
END;
{*      *       *       *       *}
BEGIN
    assign(fi,inp);reset(fi);
    read(fi,n);
    close(fi);
    phantich(n);
    kl[0]:=1;
    For i:=1 to 17 do
     kl[i]:=kl[i-1]*3;
    dem1:=0;
    dem2:=0;
    For i:=1 to length(res) do
      BEGIN
       if res[i] = '1' then inc(dem[i-1])
        else if res[i] ='2' then dem[i-1]:=2;
      END;
    For i:=0 to 17 do
      BEGIN
          if dem[i]=2 then
            BEGIN
                dec(dem[i]);
                inc(dem[i+1]);
                inc(dem1);
                a1[dem1]:=kl[i];
            END
             else if dem[i]=1 then
               BEGIN
                   inc(dem2);
                   a2[dem2]:=kl[i];
               END
                else if dem[i]=3 then
                   BEGIN
                       dec(dem[i]);
                       inc(dem[i+1]);
                   END;
      END;
    Assign(fo,out);rewrite(fo);
    write(fo,dem1,' ');
    For i:=1 to dem1 do
     write(fo,a1[i],' ');
     writeln(fo);
    write(fo,dem2,' ');
    For i:=1 to dem2 do
      write(fo,a2[i],' ');
      close(fo);
END.