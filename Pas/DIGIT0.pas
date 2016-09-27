Const   inp = '';
        out = '';
        maxn = 10;
type    arr      =       array [1..maxn] of longint;
Var     fi,fo : text;
        s       :       ansistring;
        prime   :       array [1..maxn] of boolean;
        n,res       :       longint;
        dem     :       array ['a'..'z'] of longint;
        ts      :       arr;
{*      *       *       *       *}
Procedure Solve;
Var i,j,t,temp1,temp2 : longint;
    ch  : char;
BEGIN
    For i:=1 to n do
      inc( dem[ s[i] ]);
    fillchar(ts,sizeof(ts),0);
    For i:=2 to n do
      BEGIN
          t:=i;
          While t mod 2 = 0 do
            BEGIN
                inc(ts[2]);
                t:=t div 2;
            END;
          While t mod 5 = 0 do
            BEGIN
                inc(ts[5]);
                t := t div 5;
            END;
      END;
    For ch:= 'a' to 'z' do
      BEGIN
          if dem[ch] > 0 then
            BEGIN
                temp1:=0;
                temp2:=0;
                For i:=2 to dem[ch] do
                  BEGIN
                        t:=i;
                         While t mod 2 = 0 do
                           BEGIN
                              inc(temp1);
                               t:=t div 2;
                           END;
                           While t mod 5 = 0 do
                            BEGIN
                             inc(temp2);
                             t := t div 5;
                            END;
                   END;
                ts[2]:=ts[2] - temp1;
                ts[5]:=ts[5] - temp2;

            END;
      END;
END;
{*      *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    read(fi,s);
    close(fi);
    n:=length(s);
    fillchar(prime,sizeof(prime),true);
    solve;
    Assign(fo,out);rewrite(fo);
    res:=ts[2];
    if res > ts[5] then res:= ts[5];
    write(fo,res);
    close(fo);
END.