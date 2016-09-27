Const   inp = '';
        out = '';
Var     fi,fo : text;
        sb,se,s : string;
        i,n,min,k       : integer;
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,sb);
    readln(fi,se);
    close(fi);
    i:=length(sb) + 1;
    s:= '';
    n:= length(sb) + length(se);
    min:=n;
    While i > 1 do
     BEGIN
         dec(i);
         s :=sb[i] + s;
         if pos(s,se) = 1 then
            BEGIN
                k:= n - length(s);
                if k < min then min:=k;
            END;
     END;
     Assign(fo,out);rewrite(fo);
     write(fo,min);
     close(fo);
END.