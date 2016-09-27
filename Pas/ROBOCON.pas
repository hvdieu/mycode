Const   inp = '';
        out = '';
        maxn = 501;
        h       :       array [1..3] of integer = (0,1,1);
        c       :       array [1..3] of integer = (1,1,0);

Var     n,k,res,tt     :       longint;
        qx1,qy1,qx2,qy2 : array [0..1,1..maxn*maxn] of longint;
        r1,r2     : array [0..1] of longint;
        a       :       array [0..maxn,0..maxn] of integer;
        free,dd    :       array [1..maxn,1..maxn] of boolean;
        stop    :       boolean;

{***************************************************************************}
procedure nhap;
var i,j,u,v : longint;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            readln(n,k);
            for i := 1 to k do
              begin
                  readln(u,v); a[u,v] := 1;
              end;
        end;
{***************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
             for j := 0 to n+1 do
              begin
                  a[0,j] := 1; a[n+1,j] := 1;
              end;
             for i := 0 to n+1 do
              begin
                  a[i,0] := 1; a[i,n+1] := 1;
              end;
             tt := 0;
             r1[0] := 1; r2[0] := 1;
             qx1[0,1] := 1; qy1[0,1] := 1;
             qx2[0,1] := 1; qy2[0,1] := n;
        end;
{***************************************************************************}
procedure BFSR1;
var i,j,l1,k,u,v : longint;
        begin
            r1[1-tt] := 0;
            fillchar(free,sizeof(free),true);
            for l1 := 1 to r1[tt] do
              begin
                  i := qx1[tt,l1]; j := qy1[tt,l1];
                  for k := 1 to 3 do
                   begin
                      u := i+h[k]; v := j+c[k];
                      if (a[u,v]=0) and (free[u,v]) then
                       begin
                           free[u,v] := false; inc(r1[1-tt]);
                           dd[u,v] := false;
                           qx1[1-tt,r1[1-tt]] := u;
                           qy1[1-tt,r1[1-tt]] := v;
                       end;
                   end;
              end;
        end;
{***************************************************************************}
procedure BFSR2;
var i,j,l2,k,u,v : longint;
        begin
            r2[1-tt] := 0;
            fillchar(free,sizeof(free),true);
            for l2 := 1 to r2[tt] do
             begin
                 i := qx2[tt,l2]; j := qy2[tt,l2];
                 for k := 1 to 3 do
                  begin
                      u := i+h[k]; v := j-c[k];
                      if (a[u,v]=0) then
                       if dd[u,v] = false then
                        begin
                            stop :=  true;
                            exit;
                        end else
                       if free[u,v] then
                        begin
                            free[u,v] := false; inc(r2[1-tt]);
                            qx2[1-tt,r2[1-tt]] := u;
                            qy2[1-tt,r2[1-tt]] := v;
                        end;
                  end;
             end;
        end;
{***************************************************************************}
procedure main;
var i,j : longint;
        begin
            khoitao;
            repeat
                inc(res);
                stop := false;
                fillchar(dd,sizeof(dd),true);
                BFSR1;
                BFSR2;
                tt := 1-tt;
            until stop;
            writeln(res);
        end;
{***************************************************************************}
begin
    nhap;
    if (n = 1) then write(0)
     else if n=2 then write(1)
      else main;
end.