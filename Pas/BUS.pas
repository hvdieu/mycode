Const   inp = 'BUS.INP';
        out = 'BUS.OUT';
Var     fi,fo : text;
        t,d,n,i,s,kq : longint;
{*      *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    Assign(fo,out);rewrite(fo);
    readln(fi,n,d,t);
    For i:=1 to n do
      BEGIN
          Read(fi,s);
          If s<=t then write(fo,1,' ')
            else if s>t then
              BEGIN
                 kq:= 1 + (s-t) div d;
                 if (s-t) mod d <> 0 then inc(kq);
                 write(fo,kq,' ');
              END;
      END;
    Close(fo);
END.