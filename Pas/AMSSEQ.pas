Const   inp = '';
        out = '';
        maxn = 101;
Var     fi,fo   :       text;
        f,a       :       array [0..maxn] of longint;
        n,k,i,d,j,res,max       :       longint;

BEGIN
      Assign(fi,inp); reset(fi);
      readln(fi,n,k);
      For i := 1 to n do read(fi,a[i]);
      close(fi);
      f[0] := 0;
      fillchar(f,sizeof(f),0);
      For i := 1 to n do
        BEGIN
              if i-k < 0 then d := 0
                else d := i-k;
              max := -maxlongint;
              For j := d to i - 1 do if max < f[j] then max := f[j];
              f[i] := max + a[i];
        END;
      res := -maxlongint;
     For i := 0 to n do
       if res < f[i] then res := f[i];
     Assign(fo,out); rewrite(fo);
     write(fo,res);
     close(fo);
END.
