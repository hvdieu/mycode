Program Fibistr;
const   inp = 'fibistr.in5';
        out = 'fibistr.ou5';
        maxn = 36;
Var     fi,fo   :       text;
        f       :       array [1..maxn] of string;
        fa,fb,fc       :       array [1..maxn] of longint;
        i,n       :       integer;
        ch      :       char;
        st      :       string;
{*      *       *       *       *       *}
Procedure Tao;
Var i : integer;
BEGIN
     For i:=3 to 13 do
       f[i]:=f[i-1]+f[i-2];
     fa[1]:=1;
     fa[2]:=1;
     For i:=3 to 35 do fa[i]:=fa[i-1]+fa[i-2];
     fb[1]:=1;
     fb[2]:=1;
     For i:=3 to 35 do
       if i mod 2 =1 then fb[i]:=fb[i-1]+fb[i-2]+1
         else fb[i]:=fb[i-1]+fb[i-2];
     fc[1]:=1;
     fc[2]:=2;
     For i:=3 to 35 do
       fc[i]:=fc[i-1]+fc[i-2]+1;
END;
{*      *       *       *       *       *}
Function Xuly(n : integer; st : string) : longint;
Var j,k,t : integer;
    ok1,ok2 : boolean;
    s1,s2 : string;
BEGIN
    j:=0;

    if st='A' then
           BEGIN
              if n=1 then
                   xuly:=1
                   else
              if n=2 then
                    xuly:=0
                    else
              xuly:=fa[n-2];
              exit;

           END
      else if st='B' then
         BEGIN
           if n=1 then xuly:=0
           else
           if n=2 then xuly:=1
           else
           xuly:=fa[n-1];
           exit;
         END
        else if pos('AA',st)<>0 then
          BEGIN
              xuly:=0;
              exit;
          END;
      j:=0;
      k:=n;
      t:=1;
      if k>13 then k:=13;
      while length(f[t]) < length(st) do inc(t);
      For i:=t to k do
        BEGIN
           if pos(st,f[i])<>0 then
             BEGIN
                 j:=i;
                 break;
             END;
        END;
        if j=0 then
          BEGIN
              xuly:=0;
              exit;
          END;
      s1:=f[j-1];
      s2:=f[j-2];
      if pos(st,s2+s1)<>0 then ok1:=true
        else ok1:=false;
      if pos(st,s1+s1)<>0 then ok2:=true
        else ok2:=false;
      if ok1 and ok2 then xuly:=fc[n-j+1]
        else if ok1 or ok2 then xuly:=fb[n-j+1]
          else xuly:=fa[n-j+1];


END;
{*      *       *       *       *       *}
BEGIN
     Assign(fi,inp);reset(fi);
     Assign(fo,out);rewrite(fo);
     f[1]:='A';
     f[2]:='B';
       tao;
     While not eof(fi) do
       BEGIN
           readln(fi,n,ch,st);
           writeln(fo,Xuly(n,st));
       END;
     Close(fi);
     Close(fo);
END.
