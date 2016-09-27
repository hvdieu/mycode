Program Train;
Const   inp = 'TRAIN.IN1';
        out = 'TRAIN.OU1';
        maxd    =       30;
Var     fi,fo :         text;
        a,b,t     :       array [1..maxd] of integer;
        sum       :       array [1..maxd] of longint;
        x,down         :       array [0..maxd] of integer;
        n,m,d     :       integer;
        s,max         :       longint;
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
Var i,tang,u,v,dau,cuoi : longint;
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
    for i:=1 to d do
      sum[i]:=(b[i]-a[i]) * t[i];

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
Procedure Work;
Var k,dem : integer;
BEGIN
    s:=0;dem:=0;
    fillchar(down,sizeof(down),0);
    for k:=1 to d do
      BEGIN
          if x[k]=1 then
            BEGIN
                dem:=dem-down[a[k]];
                dem:=dem+t[k];
                if dem>n then exit
                 else
                 BEGIN
                    s:=s+sum[k];
                    down[b[k]]:=down[b[k]]+t[k];
                 END;
            END;
      END;
    if s>max then max:=s;
END;
{*      *       *       *       *}
Procedure Try( i : integer);
Var j : integer;
BEGIN
     For j:=0 to 1 do
       BEGIN
           x[i]:=j;
           if i=d then work
             else try(i+1);
       END;
END;
{*      *       *       *       *}
Procedure Xuly;
BEGIN
    max:=0;
    quicksort(1,d);
    init;
    Try(1);

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
