Program MDIGITS2;
Const   inp = '';
        out = '';
Var     fi,fo : text;
        s,n1,s1       : ansistring;
        n       :       longint;
        i,k       : int64;
BEGIN
    Assign(fi,inp);reset(fi);
    read(fi,n);
    Close(fi);
    str(n,n1);
    i:=0;
    k:=0;
    s:='';
    repeat
      BEGIN
         Inc(i);
         str(i,s1);
         s:=s+s1;
         if i=n then break;
      END;
       until false;
    Assign(fo,out);rewrite(fo);
    Write(fo,pos(n1,s));
    Close(fo);

END.
