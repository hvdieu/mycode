Const   inp = 'LAMPS.INP';
        out = 'LAMPS.OUT';
        maxn = 101;
Var     fi,fo   :       text;
        n,left,qt       :       integer;
        c       :       longint;
        target    :       array [1..maxn] of integer;
        a       :       array [1..20] of string;
        x       :       array [1..4] of integer;
        d       :       array [1..maxn] of integer;
        ok      :       boolean;
{*      *       * *       *}
Procedure Input;
Var i,k : integer;
BEGIN
    assign(fi,inp);reset(fi);
    readln(fi,n);
    readln(fi,c);
    For i:=1 to n do
     target[i]:=2;
    While not eoln(fi) do
      BEGIN
          read(fi,k);
          if k<>-1 then
                target[k]:=1
      END;
      readln(fi);
    While not eoln(fi) do
       BEGIN
           read(fi,k);
           if k<>-1 then
             target[k]:=0
       END;
    Close(fi);
END;
{*      *       *       *       *}
Procedure Kiemtra;
Var t : integer;
BEGIN
    OK:=true;
    For t:=1 to n do
      if target[t]=2 then continue
        else if target[t]<>2 then
          if d[t]<>target[t] then
            BEGIN
                ok:=false;
                break;
            END;

END;
{*      *       *       *       *}
Procedure init;
Var i,k : integer;
 m : string;
BEGIN
  if c>=3 then qt:=c mod 2
    else qt:=10;
  left:=0;
  if c mod 2 = 0 then

       BEGIN
                For i:=1 to n do
           d[i]:=1;
           kiemtra;
           if ok then
             BEGIN
                       Inc(left);
                       a[left]:='';
                       For k:=1 to n do
                         BEGIN
                             Str(d[k],m);
                             a[left]:=a[left]+m;
                         END;
             END;
       END;
END;
{*      *       *       *       *}
Procedure Xuly;
Var u,v,dem,k : integer;
    m : string;
BEGIN
    dem:=0;
    For u:=1 to 4 do
      if x[u]=1 then inc(dem);
        if (dem =c) or (dem mod 2 = qt)then
           BEGIN
               For u:=1 to n do
                 d[u]:=1;
               For u:=1 to 4 do
                 if x[u]=1 then
                    BEGIN
                        if u=1 then
                          BEGIN
                             For v:=1 to n do
                               if d[v]=1 then d[v]:=0
                                 else d[v]:=1;
                          END
                            else if u=2 then
                              BEGIN
                                  For v:=1 to n do
                                    if v mod 2 = 1 then
                                    if d[v]=1 then d[v]:=0
                                 else d[v]:=1;
                              END
                              else if u=3 then
                                BEGIN
                                   For v:=1 to n do
                                    if v mod 2 = 0 then
                                      if d[v]=1 then d[v]:=0
                                 else d[v]:=1;
                                END
                                  else if u=4 then
                                    BEGIN
                                        For v:=1 to n do
                                          if v mod 3 = 1 then
                                            if d[v]=1 then d[v]:=0
                                               else d[v]:=1;
                                    END;
                    END;
                 Kiemtra;
                 if ok then
                   BEGIN
                       Inc(left);
                       a[left]:='';
                       For k:=1 to n do
                         BEGIN
                             Str(d[k],m);
                             a[left]:=a[left]+m;
                         END;
                   END;
           END;
END;
{*      *       *       *       *}
Procedure Try(i : integer);
Var j : integer;
BEGIN
     For j:=0 to 1 do
       BEGIN
           x[i]:=j;
           if i=4 then Xuly
             else Try(i+1);
       END;
END;
{*      *       *       *       *}
Procedure Swap(Var g,f : string);
Var temp: string;
BEGIN
    temp:=g;
    g:=f;
    f:=temp;
END;
{*      *       *       *       *}
Procedure Quicksort(L,H : integer);
Var i,j : integer;
    key : string;
BEGIN
    if l>=h then exit;
    i:=l;
    j:=h;
    key:= a[ (l+h) div 2];
    Repeat
      BEGIN
            While a[i]<key do Inc(i);
            While a[j]>key do Dec(j);
            If i<=j then
              BEGIN
                  if i<j then swap(a[i],a[j]);
                  inc(i);
                  dec(j);
              END;
      END;
        until i>j;
      Quicksort(L,j);
      Quicksort(i,H);
END;
{*      *       *       *       *}
Procedure Output;
Var i : integer;
BEGIN
    assign(fo,out);rewrite(fo);
    if left=0 then write(fo,'IMPOSSIBLE')
     else BEGIN

    quicksort(1,left);
    For i:=1 to left do
     if a[i]=a[i+1] then continue
      else writeln(fo,a[i]);
     END;
    close(fo);
END;
{*      *       *       *       *}
BEGIN
  input;
  init;
  try(1);
  output;
END.

