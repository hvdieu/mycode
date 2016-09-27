Const    inp = '';
         out = '';
         maxn = 10001;
Var      fi,fo  :       text;
         s,n    :       int64;
         k,i      :       longint;
         f      :       array [0..maxn] of longint;
         dem    :       longint;
{*       *      *       *       *}
Procedure Swap(Var xx,yy : longint);
Var temp : longint;
BEGIN
     temp:=xx;
     xx:=yy;
     yy:=temp;
END;
{*      *       *       *       *}
Procedure Quicksort(l,h : longint);
Var i,j,key : longint;
BEGIN
    if l>=h then exit;
    i:=l;
    j:=h;
    key:= f[ (l+h) div 2];
    Repeat
      BEGIN
          While f[i] < key do inc(i);
          While f[j] > key do dec(j);
          if i<=j then
            BEGIN
                if i<j then Swap(f[i],f[j]);
                inc(i);
                dec(j);
            END;
      END;
        Until i>j;
      Quicksort(L,j);
      Quicksort(i,H);
END;
{*      *       *       *       *}
BEGIN
    assign(fi,inp);reset(fi);
    readln(fi,n,k,s);
    close(fi);
    f[1]:=1;
    f[2]:=2;
    f[3]:=(1+2) mod k;
    i:=3;
    While ( (f[i]<>2) or (f[i-1]<>1)) and (i<n) do
      BEGIN
          inc(i);
          f[i]:= ((f[i-1] mod k) + (f[i-2] mod k)) mod k;
      END;
    dem:=i-2;
    Quicksort(1,dem);
    f[0]:=f[dem];
    s:= s mod dem;
    Assign(fo,out);rewrite(fo);
    write(fo,f[s]);
    close(fo);

END.