Const    inp = '';
         out = '';
         maxn = 1001;
Var      fi,fo  :       text;
        a       :       array [1..maxn] of longint;
        d       :       array [1..maxn] of integer;
        i,n,k,t,x,res     :       longint;
{*      *       *       *       *}
Procedure swap(var xx,yy : longint);
Var temp : longint;
BEGIN
        temp:=xx;
        xx:=yy;
        yy:=temp;
END;
{*      *       *       *       *}
Function max (xx, yy,zz : longint ) : longint;
BEGIN
    max:=xx;
    if max < yy then max:=yy;
    if max < zz then max:=zz;

END;
{*      *       *       *       *}
Procedure sort(l,h : longint);
Var i,j,key : longint;
BEGIN
        if l>=h then exit;
        i:=l;
        j:=h;
        key := a[ (l+h) div 2];
        Repeat
                BEGIN
                    While a[i] < key do inc(i);
                    While a[j] > key do dec(j);
                    if i <= j then
                       BEGIN
                           if i < j then
                             swap(a[i],a[j]);
                           inc(i);
                           dec(j);
                       END;
                END;
                        until i>j;
        Sort(l,j);
        sort(i,h);

END;
{*      *       *       *       *}
Function find(d,c,key : longint) : longint;
Var giua : longint;
BEGIN
        While d <= c do
                BEGIN
                   giua := ( d+ c ) div 2;
                   if a[giua] = key then
                      BEGIN
                          find:=giua;
                          exit;
                      END;
                   if a[giua] < key then d:= giua +1
                     else c := giua -1;

                END;
        find:=0;
END;
{*      *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    readln(fi,n);
    For i:=1 to n do
      read(fi,a[i]);
    close(fi);
    sort(1,n);
    for i:=1 to n do
     d[i]:=1;
    for k:=2 to n do
      for i:=1 to k-1 do
         BEGIN
             t:=a[k] - a[i];
             x:=find(i+1,k-1,t);
             if x <> 0 then
               d[k]:= max (d[k], d[i]+1, d[x]+1);
         END;
    res:=d[1];
    for i:=2 to n do
     if res < d[i] then res:=d[i];
    Assign(fo,out);rewrite(fo);
    write(fo,res);
    close(fo);

END.