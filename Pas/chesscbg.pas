{$MODE OBJFPC}
Const   inp = '';
        out = '';
        maxn = 4;
        max = 65536;
        maxk = 11000;
        h       :       array [1..4] of integer = (-1,0,1,0);
        c       :       array [1..4] of integer = (0,1,0,-1);
        bit     :       array [1..4] of integer = (4,-1,-4,1);
Type    arr     =       array [1..4,1..4] of char;
Var     fi,fo   :       text;
        start       :       array [1..4,1..4] of char;
        target  :       array [1..4,1..4] of char;
        cx       :       array [0..max] of boolean;
        dem     :       array [0..maxk] of integer;
        queue   :       array [1..maxk] of arr;
        que     :       array [1..maxk] of longint;
        ok : boolean;
        left,right : longint;
{*      *       *       *       *}
procedure kiemtra(b : arr);
Var u,v : integer;
BEGIN
    ok:=true;
    For u:=1 to 4 do
      For v:=1 to 4 do
        if b[u,v]<> target[u,v] then
          BEGIN
              ok:=false;
              exit;
          END;
END;
{*      *       *       *       *}
procedure input;
Var i,j : integer;
BEGIN
   assign(fi,inp);reset(fi);
   For i:=1 to 4 do
    BEGIN
    For j:=1 to 4 do
      read(fi,start[i,j]);
     readln(fi);
    END;
   For i:=1 to 4 do
    BEGIN
    For j:=1 to 4 do
      read(fi,target[i,j]);
        readln(fi);
    END;
   close(fi);

   kiemtra(start);
END;
{*      *       *       *       *}
Function Bat(n : longint; i : integer) : longint ;
BEGIN
    bat := n or ( 1 shl i);
END;
{*      *       *       *       *}
Function Tat(n : longint; i : integer) : longint;
BEGIN
    tat:=n and (not ( 1 shl i) );
END;
{*      *       *       *       *}
Procedure Init;
Var i,j,k : integer;
    t   : longint;
    s   : string;
BEGIN
    t:=0;
    k:=16;
    For i:=1 to 4 do
      For j:=1 to 4 do
        BEGIN
            dec(k);
            if start[i,j]='1' then t:=bat(t,k);
        END;
    left:=0;
    right:=1;
    queue[right]:=start;
    que[1]:=t;
    fillchar(cx,sizeof(cx),true);
    cx[t]:=false;
END;
{*      *       *       *       *}

{*      *       *       *       *}
Procedure Loangrong;
Var b,cc : arr;
    i,j,k,t : integer;
    s1,st       :       longint;
BEGIN
    While left<right do
      BEGIN
          Inc(left);
          b:=queue[left];
          t:=16;
          For i:=1 to 4 do
            For j:=1 to 4 do
              BEGIN
                  Dec(t);
                    if b[i,j]='1' then
                      BEGIN
                         For k:=1 to 4 do
                           if (i+h[k]>0) and (i+h[k]<5) and (j+c[k]>0) and(j+ c[k]<5) then
                             if b[i+h[k],j+c[k]]='0' then
                              BEGIN
                                 st:=que[left];
                                 st:=tat(st,t);
                                 st:=bat(st,t+bit[k]);
                                 if cx[st] then
                                   BEGIN
                                       cc:=b;
                                       Inc(right);
                                       cc[i,j]:='0';
                                       cc[i+h[k],j+c[k]]:='1';
                                       cx[st]:=false;
                                       queue[right]:=cc;
                                       que[right]:=st;
                                       dem[right]:=dem[left]+1;
                                       kiemtra(cc);
                                       if ok then
                                         BEGIN
                                              writeln(fo,dem[right]);
                                              close(fo);
                                              halt;
                                         END;
                                   END;
                              END;
                      END;
              END;
      END;
END;
{*      *       *       *       *}
BEGIN
    Input;
    assign(fo,out);rewrite(fo);
    Init;
    Loangrong;

END.



