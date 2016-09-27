Const   inp = 'MASS,INP';
        out = 'MASS.OUT';
        maxn = 200;
Var     fi,fo   :       text;
        s       :       string;
        a       :       array [1..maxn] of longint;
        d       :       array [1..maxn] of boolean;
        kl      :       array [67..79] of integer;
        stack   :       array [1..maxn] of longint;
        top     :       integer;
        m       :       longint;
{*      *       *       *       *}
procedure input;
Var i : integer;
BEGIN
    assign(fi,inp);reset(fi);
    read(fi,s);
    close(fi);
    fillchar(d,sizeof(d),true);
    kl[67]:=12;
    kl[72]:=1;
    kl[79]:=16;
END;
{*      *       *       *       *}
Procedure Xuly;
Var i,t : integer;
    k   :  longint;
BEGIN
    top:=0;
    For i:=1 to length(s) do
      BEGIN
          if s[i] in ['A'..'Z'] then
            BEGIN
                Inc(top);
                stack[top]:=kl[ord(s[i])];
            END
              else if s[i] in ['1'..'9'] then
                BEGIN
                    inc(top);
                    val(s[i],t);
                    stack[top]:=t;
                    d[top]:=false;
                END
                 else if s[i]='(' then
                   BEGIN
                       inc(top);
                       stack[top]:=-1;
                   END
                   else if s[i]=')' then
                       BEGIN
                           k:=0;
                           While stack[top]<>-1 do
                           BEGIN
                           if d[top]=false then
                             BEGIN
                                Dec(top);
                                k:=k+stack[top]*stack[top+1];
                                d[top+1]:=true;
                             END
                               else if d[top] then k:=k+stack[top];
                               dec(top);
                           END;
                           stack[top]:=k;
                       END;
      END;

END;
{*      *       *       *       *}
Procedure output;
Var i : integer;
BEGIN
   assign(fo,out);rewrite(fo);
   i:=0;
   m:=0;
   While top>0 do
     BEGIN
         if d[top] then m:=m+stack[top]
           else BEGIN
                    m:=m+stack[top]*stack[top-1];
                    dec(top);
                END;
           dec(top);
     END;
     write(fo,m);
     close(fo);
END;
{*      *       *       *       *}
BEGIN
   input;
   xuly;
   output;
END.