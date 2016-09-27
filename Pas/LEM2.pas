Const   inp = '';
        out = '';
        maxn = 21;
        max  = 1048576;
        maxq = 2000000;
Var     fi,fo   :       text;
        n,k,tt     :       longint;
        queue   :       array [1..maxq] of longint;
        dem     :       array [1..maxq] of longint;
        td      :       array [1..maxn,1..maxn] of longint;
        cx      :       array [1..max] of boolean;
        start,left,right,target      :       longint;
{*      *       *       *       *}
Function bat ( n : longint; i : integer) : longint;
BEGIN
    bat := n or ( 1 shl i );
END;
{*      *       *       *       *}
Function tat ( n : longint; i : integer) : longint;
BEGIN
    tat:= n and ( not ( 1 shl i ) );
END;
{*      *       *       *       *}
Procedure Input;
Var i,s,j,t : longint;
BEGIN
    fillchar(td,sizeof(td),0);
    Assign(fi,inp);reset(fi);
    readln(fi,n,k);
    For i:=1 to n do
      BEGIN
          read(fi,s);
          For j:=1 to s do
            BEGIN
                read(fi,t);
                td[i,t]:=1;
            END;
          readln(fi);
      END;
    t:=n;
    start:=0;
    For i:=1 to n do
      BEGIN
          dec(t);
          read(fi,s);
          if s=1 then start:= bat(start,t);
      END;
      target:=0;
    target:= bat(target,n-k);
END;
{*      *       *       *       *}
procedure output;
BEGIN
    assign(fo,out);rewrite(fo);
    write(fo,dem[left]);
    close(fo);
    halt;
END;
{*      *       *       *       *}
Procedure Solve;
Var i,j,t,u : longint;
    s   : longint;
BEGIN
    left:=0;
    right:=1;
    queue[right]:=start;
    dem[start]:=0;
    fillchar(cx,sizeof(cx),true);
    cx[start]:=false;
    While left < right do
       BEGIN
           Inc(left);
           u:=n;
           For i:=1 to n do
             BEGIN
                 dec(u);
                 s:= queue[left];
                 if s=target then output;
                 t:=n;
                 tt:= bat(s,u);
                 For j:=1 to n do
                   BEGIN
                       dec(t);
                       if td[i,j]=1 then tt:= tat(s,t);

                   END;
                 if dem[s]=0 then
                   BEGIN
                       Inc(right);
                       queue[right]:=s;
                       dem[tt]:=dem[s] + 1;
                   END;
             END;
       END;
END;
{*      *       *       *       *}
BEGIN
      Input;
      Solve;
END.
