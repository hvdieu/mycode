Program Train;
Const   inp = 'TRAIN.IN1';
        out = 'TRAIN.OUT';
        maxd    =       30;
Var     fi,fo :         text;
        a,b,t     :       array [1..maxd] of integer;
        sum       :       array [1..maxd] of longint;
        x,down         :       array [0..maxd] of integer;
        n,m,d     :       integer;
        s,max,weight         :       longint;
{*      *       *        *       *}
Procedure Input;
Var i : integer;
BEGIN
    assign(fi,inp);reset(fi);
    readln(fi,n,m,d);
    for i:=1 to d do
     readln(fi,a[i],b[i],t[i]);
    close(fi);
END;
{*      *       *       *       *}
Procedure Swap ( Var u,v : integer);
Var temp : integer;
BEGIN
    temp:=u;
    u:=v;
    v:=temp;
END;
{*      *       *        *       *}
Procedure Init;
Var i,tang,u,v,dau,cuoi : integer;
BEGIN
    i:=1;
    tang:=1;
    dau:=1;
    cuoi:=0;
      While i<d do
         BEGIN
            dau:=i;
            While a[i]=a[i+1] do
              BEGIN
                  cuoi:=i+1;
                  Inc(i);
              END;
              if dau<cuoi then
            for u:=dau+1 to cuoi do
               for v:=cuoi downto u do
                 if b[v]<b[v-1] then
                   BEGIN
                      Swap(b[v],b[v-1]);
                      Swap(t[v],t[v-1]);
                   END;
               Inc(i);
         END;
      i:=1;
      while i<d do
        BEGIN
            While (a[i]=a[i+1]) and (b[i]=b[i+1]) do
              BEGIN
                  t[i+1]:=t[i]+t[i+1];
                  a[i]:=0;
                  b[i]:=0;
                  t[i]:=0;
                  i:=i+1;

              END;
            Inc(i);
        END;
    for i:=1 to d do
      sum[i]:=(b[i]-a[i]) * t[i];
    weight:=0;
    fillchar(down,sizeof(down),0);
    s:=0;max:=0;

END;
{*      *       *       *       *}
Procedure Quicksort(L,H : integer);
Var i,j,key : integer;
BEGIN
    if l>=h then exit;
    i:=l;j:=h;
    key := a[ (l+h) div 2 ];
    Repeat
       BEGIN
             While a[i]<key do inc(i);
             While a[j]>key do dec(j);
             If i<=j then
               BEGIN
                   If i<j then
                     BEGIN
                         Swap(a[i],a[j]);
                         Swap(b[i],b[j]);
                         Swap(t[i],t[j]);
                     END;
                   Inc(i);
                   Dec(j);
               END;
       END;
          until i>j;
       Quicksort(L,j);
       Quicksort(i,H);
END;
{*      *       *       *       *}
Procedure Try( i,weight : integer);
Var j : integer;
BEGIN

     For j:=i+1 to d do
       BEGIN
           if weight-down[a[j]]+t[j]<=n then
             BEGIN
                 down[a[j]]:=0;
                 down[b[j]]:=down[b[j]]+t[j];
                 s:=s+sum[j];
                 if max<s then max:=s;
                 Try(j,weight-down[a[j]]+t[j]);
                 down[b[j]]:=down[b[j]]-t[j];
                 s:=s-sum[j];
             END;
       END;
END;
{*      *       *       *       *}
Procedure Xuly;
BEGIN
    max:=0;
    quicksort(1,d);
    init;
    Try(0,0);

END;
{*      *       *       *       *}
Procedure output;
BEGIN
    assign(fo,out);rewrite(fo);
    write(fo,max);
    close(fo);
END;
{*      *       *       *       *}
BEGIN
      input;
      xuly;
      output;
END.
