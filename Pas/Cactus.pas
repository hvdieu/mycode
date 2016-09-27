Const      inp = 'cactus.inp';
           out = 'cactus.out';
           maxn = 51;
           max = 1000;
           h    :       array [1..4] of integer = (-1,0,1,0);
           c    :       array [1..4] of integer = (0,1,0,-1);
Var        fi,fo        :       text;
           r,co,sx,sy,ax,ay,dx,dy          :       integer;
           map          :       array [1..maxn,1..maxn] of char;
           da,move    :        array [1..maxn,1..maxn] of integer;
           cx,free   :        array [0..maxn,0..maxn] of boolean;
           i,j          :       integer;
           left,right   :       longint;
           qx,qy        :       array [1..max] of integer;
{*         *    *       *       *       *}
Function min (xx, yy : integer ) : integer;
BEGIN
        if xx>yy then min:=yy
          else min:=xx;
END;
{*      *       *       *       *       *}
Procedure Init;
Var u,v,px,py,k : integer;
BEGIN
   left:=0;
   right:=1;
   qx[right]:=ax;
   qy[right]:=ay;
   For u:=1 to r do
     For v:=1 to co do
         free[u,v]:=true;
   While left < right do
      BEGIN
          inc(left);
          px:=qx[left];
          py:=qy[left];
          free[px,py]:=false;
          For k := 1 to 4 do
            if free[ px + h[k], py + c[k] ] then
              BEGIN
                 if (map[px + h[k], py + c[k] ] <> 'D') or (map[px + h[k], py + c[k]] <> 'X') then
                   BEGIN
                      inc(right);
                      qx[right]:= px + h[k];
                      qy[right]:= py + c[k];
                      da[px + h[k], py + c[k]] := min(da[ px,py ] + 1,da[ px +h[k], py+c[k]]);

                  END
                    else if map[ px +h[k], py + c[k]] = 'X' then
                       BEGIN
                           da[px+h[k], py+c[k]] := min(da[px,py] +1,da[ px + h[k], py + c[k]]);
                       END;
              END;
      END;
END;
{*      *       *       *       *       *}
Procedure Solve;
Var i,j,px,py,k,x,y : integer;
BEGIN
    left:=0;
    right:=1;
    fillchar(qx,sizeof(qx),0);
    fillchar(qy,sizeof(qy),0);
    qx[right]:=sx;
    qy[right]:=sy;
    While left < right do
       BEGIN
           inc(left);
           px:=qx[left];
           py:=qy[left];
           cx[px,py]:=false;
           For k:=1 to 4 do
              if cx[ px + h[k], py + c[k]] then
                 BEGIN
                     x:= px + h[k];
                     y:= py + c[k];
                     move[x,y] := move[ px,py ] +1;
                     cx[x,y]:=false;
                     if (x=dx) and (y = dy) then
                               BEGIN
                                   Write(fo,move[dx,dy]);
                                   close(fo);
                                   halt;
                               END;
                     if move[x,y] < da[x,y] then
                        BEGIN
                            inc(right);
                            qx[right]:=x;
                            qy[right]:=y;

                        END;

                 END;
       END;
END;
{*      *       *       *       *       *}
BEGIN
    Assign(fi,inp);reset(fi);
    Assign(fo,out);rewrite(fo);
    readln(fi,r,co);
    fillchar(cx,sizeof(cx),false);
    fillchar(free,sizeof(free),false);

    For i:=1 to r do
     BEGIN
      For j:=1 to co do
        BEGIN
            read(fi,map[i,j]);
            if map[i,j] = 'D' then
               BEGIN
                  dx:=i;
                  dy:=j;
               END
                 else
                     if map[i,j] = 'S' then
                         BEGIN
                            sx:=i;
                            sy:=j;
                         END;
               cx[i,j]:=true;
               free[i,j]:=true;
        END;
        readln(fi);
      END;
      For i:=1 to r do
         For j:=1 to co do
        da[i,j]:=maxint;
      For i:=1 to r do
        For j:=1 to co do
      if map[i,j] = '*' then
                               BEGIN
                                  ax:=i;
                                  ay:=j;
                                  da[i,j]:=0;
                                  Init;
                               END;
    close(fi);
    Solve;
    Write(fo,'NO');
    close(fo);
END.
