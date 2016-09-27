Const   inp = 'TPAPER.INP';
        out = 'TPAPER.OUT';
        maxn = 5000;
Var     fi,fo   :       text;
        dau,cuoi,giua,ngoai,db   :       array [1..maxn] of string;
        cx      :       array [1..maxn] of boolean;
        d1,d2,d3,d4,d5,dd,n        :       integer;
        ch      :       char;
        s       :       string;
        max1,max2       :       string;
        res     :       ansistring;
{*      *       *       *       *}
procedure input;
Var i : integer;
BEGIN
     Assign(fi,inp);reset(fi);
     ch:='#';
     readln(fi,n);
     For i:=1 to n do
       BEGIN
           readln(fi,s);
           if pos(ch,s)=0 then
             BEGIN
                 inc(d2);
                 giua[d2]:=s;
             END
               else
                 BEGIN
                     dd:=length(s);
                     if dd=2 then
                         BEGIN
                             if (s[1]=ch) and (s[2]<> ch) then
                                BEGIN
                                    Inc(d1);
                                    dau[d1]:=s[2];
                                END;
                             if (s[1]<>ch) and (s[2]=ch) then
                                BEGIN
                                    Inc(d3);
                                    cuoi[d3]:=s[1];
                                END;
                         END
                           else if dd=3 then
                                    BEGIN
                                        if (s[1]<>ch) and (s[2]<>ch) and (s[3]=ch) then
                                             BEGIN
                                                 Inc(d3);
                                                 cuoi[d3]:=s[1]+s[2];
                                             END;
                                        if (s[1]=ch) and (s[2]<>ch) and (s[3]<>ch) then
                                             BEGIN
                                                 inc(d1);
                                                 dau[d1]:=s[2]+s[3];
                                             END;
                                        if (s[1]<>ch) and (s[2]=ch) and (s[3]<>ch) then
                                             BEGIN
                                                 inc(d5);
                                                 db[d5]:=s;
                                             END;
                                        if (s[1]=ch) and (s[2]=ch) and (s[3]<>ch) then
                                             BEGIN
                                                 Inc(d1);
                                                 dau[d1]:=s[3];
                                             END;
                                        if (s[1]<>ch) and (s[2]=ch) and (s[3]=ch) then
                                             BEGIN
                                                 Inc(d3);
                                                 cuoi[d3]:=s[1];
                                             END;
                                        if (s[1]=ch) and (s[2]<>ch) and (s[3]=ch) then
                                             BEGIN
                                                 inc(d4);
                                                 ngoai[d4]:=s[2];
                                             END;
                                    END;
                 END;
       END;
END;
{*      *       *       *       *}
Function lon(xx,yy : string) : string;
Var aa,bb : string;
BEGIN
   aa:=xx+yy;
   bb:=yy+xx;
   if aa = bb then lon := '1000';
   if aa > bb then lon := xx;
   if aa < bb then lon := yy;
END;
{*      *       *       *       *}
Procedure Swap( Var xx,yy : string);
Var temp : string;
BEGIN
    temp:=xx;
    xx:=yy;
    yy:=temp;
END;
{*      *       *       *       *}
procedure Quicksort(L,H : integer);
Var i,j : integer;
    key : string;
BEGIN
    if l>=h then exit;
    i:=l;
    j:=h;
    key := giua [ (l+h) div 2] ;
    Repeat
       BEGIN
           While lon(giua[i],key) = giua[i] do inc(i);
           While lon(giua[j],key) = key do dec(j);
           if i<=j then
             BEGIN
                 if i<j then Swap(giua[i],giua[j]);
                 Inc(i);
                 Dec(j);
             END;
       END;
          Until i>j;
    Quicksort(l,j);
    Quicksort(i,h);

END;
{*      *       *       *       *}
procedure Solve;
Var i,so1,so2,j,vt,ok : integer;
    st,mao  :       string;
BEGIN
    Quicksort(1,d2);
    For i:=1 to d2 do
      res:=res + giua[i];
    max1:= dau[1];
    For i:=2 to d1 do
      BEGIN
          if length(max1) < length(dau[i]) then
            BEGIN
               max1:=dau[i];
            END
             else if length(max1) = length(dau[i]) then
               BEGIN
                   Val(max1,so1);
                   Val(dau[i],so2);
                   if so2 > so1 then max1:=dau[i];
               END;
      END;
    max2:=cuoi[1];
    For i:=2 to d3 do
      BEGIN
          if length(max2) < length(cuoi[i]) then max2:=cuoi[i]
            else if length(max2) = length(cuoi[i]) then
               BEGIN
                   Val(max2,so1);
                   Val(cuoi[i],so2);
                   if so2 > so1 then max2:=cuoi[i];
               END;
      END;
      vt:=0;
    if (d5 > 0) and (length(max1) < 2 ) then
       BEGIN
          ok:=0;
          if max1 = '' then
            BEGIN
              if res <> '' then
              BEGIN
              max1:= res[1];
              ok:=1;
              END;
            END;
          For i:=1 to d5 do
             BEGIN

                 st:= db[i];
                 if (st[3] > max1) and ( st[3] <> ch ) then
                   BEGIN
                     max1:=st[3];
                     vt:=i;
                     ok:=2;
                   END;
             END;
          if vt<> 0 then db[vt]:= '###';
          if ok=1 then max1:='';
       END;
       vt:=0;
    if (d5 > 0) and (length(max2) < 2 ) then
      BEGIN
          For i:=1 to d5 do
            BEGIN
                st:= db[i];
                if (st[1] > max2) and (st[1] <> ch ) then
                   BEGIN
                       max2:=st[1];
                       vt:=i;
                   END;
            END;
          if vt <> 0 then db[vt]:= '###';
      END;
END;
{*      *       *       *       *}
procedure output;
Var i : integer;
BEGIN
    res:=max1+res+max2;
    if length(res) <= 1 then
      BEGIN
          For i:=1 to d4 do
            BEGIN
                if res<ngoai[i] then res:=ngoai[i];
            END;
      END;
    Assign(fo,out);rewrite(fo);
    write(fo,res);
    close(fo);
END;
{*      *       *       *       *}
BEGIN
     input;
     solve;
     output;
END.
