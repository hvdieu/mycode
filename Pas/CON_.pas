Const   inp = '';
        out = '';
        maxn = 100001;
Var     fi,fo   :       text;
        a,b     :       array [0..maxn+1] of longint;
        i,n,suma       :       longint;
        sum,sum1,sum2       :       int64;
{*      *       * *       *     *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n);
    sum:=0;
    sum1:=0;
    sum2:=0;
    For i:=1 to n do
     BEGIN
        read(fi,b[i]);
        sum:=sum + b[i];
     END;
    suma:=sum div 3;
    close(fi);
    if n mod 3 = 1 then
      BEGIN
         For i:=1 to n do
           if i mod 3 = 2 then
              sum1:=sum1 + b[i]
                else if i mod 3 = 0 then
                  sum2 := sum2 + b[i];
         a[1]:=suma - sum2;
         a[n]:=suma - sum1;
         a[0]:=a[n];
         a[n+1]:=a[1];
         for i:=2 to n-1 do
           a[i]:=b[i-1] - a[i-1] - a[i-2];
      END
        else if n mod 3 = 2 then
             BEGIN
                for i:=2 to n-1 do
                  if i mod 3 = 1 then
                    sum1:=sum1 + b[i]
                      else if i mod 3 = 2 then
                        sum2:= sum2 + b[i];
                a[n]:=b[1] - (suma - sum1);
                a[1]:=b[n] - (suma - sum2);
                a[0]:=a[n];
                a[n+1]:=a[1];
                for i:=2 to n-1 do
                 a[i]:= b[i-1] - a[i-1] - a[i-2];
             END
               else if n mod 3 = 0 then
                 BEGIN
                     a[1]:=0;
                     a[2]:=0;
                     for i:=3 to n do
                      a[i]:= b[i-1] - a[i-1] - a[i-2];
                 END;
      Assign(fo,out);rewrite(fo);
      For i:=1 to n do
       write(fo,a[i],' ');
       close(fo);
END.