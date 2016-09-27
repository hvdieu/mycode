Const   inp =  '';
        out =  '';
        maxn = 100001;
Var     fi,fo   :       text;
        a,b1,b2    :       array [0..maxn] of longint;
        l       :       array [0..maxn] of longint;
        queue   :       array [1..maxn] of longint;
        d       :       array [1..maxn] of boolean;
        adj     :       array [1..2*maxn] of longint;
        n,i,j,m,left,right   :       longint;
{*      *       *       *       *       *}
Procedure Input;
Var i,x,y,z : longint;
BEGIN
        Assign(fi,inp);reset(fi);
        readln(fi,n,m);
        For i:=1 to m do
          BEGIN
              readln(fi,x,y,z);
              b1[x]:=y;
              b2[x]:=z;
          END;
        Close(fi);
        fillchar(d,sizeof(d),true);
END;
{*      *       *       *       *       *}
Procedure BFS;
Var px,py,k : longint;
BEGIN
    l[1]:=1;
    left:=0;
    right:=1;
    queue[1]:=1;
    While left < right do
      BEGIN
          inc(left);
          px:=queue[left];
          d[px]:=false;
          py:= b1[px];
          if (py <> 0)  then
            BEGIN
                d[py]:=false;
                inc(right);
                queue[right]:=py;
                l[py]:=l[px] +1;
            END;
          py:= b2[px];
          if py <> 0 then
            BEGIN
                d[py]:=false;
                inc(right);
                queue[right]:=py;
                l[py]:=l[px] +1;
            END;

      END;
END;
{*      *       *       *       *       *}
procedure output;
Var i : longint;
BEGIN
    Assign(fo,out);rewrite(fo);
    for i:=1 to n do writeln(fo,l[i]);
    close(fo);
END;
{*      *       *       *       *       *}
BEGIN
   input;
   bfs;
   output;
END.
