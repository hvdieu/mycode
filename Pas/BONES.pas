Const   inp = '';
        out = '';
Var     fi,fo   :       text;
        s1,s2,s3,i,j,k,t,min,max,res : integer;
        dem     :       array [1..80] of longint;
{*      *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,s1,s2,s3);
    close(fi);
    For i:=1 to s1 do
      For j:=1 to s2 do
       For k:=1 to s3 do
         BEGIN
            t:= i+j+k;
            inc(dem[t]);
         END;
         max:=s1+s2+s3;
         min:=0;
      For i:=1 to max do
        if dem[i]  > min then
          BEGIN
              min:=dem[i];
              res:=i;
          END;
      Assign(fo,out);rewrite(fo);
      write(fo,res);
      close(fo);
END.