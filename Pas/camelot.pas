{
PROG: camelot
LANG: PASCAL
ID: pynhp9x1
}
uses math;
Const   inp = 'camelot.in';
        out = 'camelot.out';
        maxn = 32;
        hvua : array [1..8] of integer = (-1,-1,-1,0,1,1,1,0);
        cvua : array [1..8] of integer = (-1,0,1,1,1,0,-1,-1);
        hma     :       array [1..8] of integer = (-2,-2,-1,-1,1,1,2,2);
        cma     :       array [1..8] of integer = (-1,1,-2,2,-2,2,-1,1);

Type    arr = array [1..maxn,1..maxn] of longint;
        ma1 = record
        d   : arr;
        end;

Var     fi,fo   :       text;
        m,n,xvua,yvua,xma,yma,dem,i,j   :       longint;
        left,right,px,py,k,tx,ty,res,x,y : longint;
        dvua,ddich    :       arr;
        tongma  :       array [1..maxn,1..maxn] of longint;
        ma              :       array [1..maxn*maxn] of ma1;
        gt              :       array ['A'..'Z'] of integer;
        ch              :       char;
        qx,qy           :       array [1..maxn*maxn] of longint;
        free    :       array [-1..maxn,-1..maxn] of boolean;
        s       :       string;

procedure bfsvua(x,y : longint; var d : arr);
        begin
            fillchar(free,sizeof(free),false);
            for i := 1 to m do
             for j := 1 to n do free[i,j] := true;
            left := 0; right := 1;
            qx[1] := x; qy[1] := y;
            free[x,y] := false;
            while left < right do
             begin
                 inc(left);
                 px := qx[left]; py := qy[left];
                 free[px,py] := false;
                 for k := 1 to 8 do
                  if free[px+hvua[k],py+cvua[k]] then
                    begin
                         tx := px + hvua[k]; ty := py + cvua[k];
                         free[tx,ty] := false;
                         d[tx,ty] := d[px,py]+1;
                         inc(right);
                         qx[right] := tx; qy[right] := ty;
                    end;
             end;
        end;

procedure bfsma(x,y : longint; var d : arr);
        begin
            fillchar(free,sizeof(free),false);
            for i := 1 to m do
             for j := 1 to n do
              begin
                free[i,j] := true;
                d[i,j] := 99999999;
              end;
            d[x,y] := 0;
            left := 0; right := 1;
            qx[1] := x; qy[1] := y;
            free[x,y] := false;
            while left < right do
             begin
                 inc(left); px := qx[left]; py := qy[left];
                 for k := 1 to 8 do
                  if free[px+hma[k],py+cma[k]] then
                   begin
                       tx := px + hma[k]; ty := py + cma[k];
                       free[tx,ty] := false;
                       d[tx,ty] := d[px,py] + 1;
                       inc(right);
                       qx[right] := tx; qy[right] := ty;
                   end;
             end;
        end;

procedure input;
var i : longint;
    ch,ch2 : char;
    tt : string;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,m,n);
             i := 0;
             for ch := 'A' to 'Z' do
              begin
                  inc(i);
                  gt[ch] := i;
              end;
             readln(fi,ch,xvua);
             yvua := gt[ch];
             bfsvua(xvua,yvua,dvua);
             while not eof(fi) do
               begin
                   readln(fi,s);
                   i := 1;
                   while i <= length(s) do
                    begin
                        inc(dem);
                        begin
                        y := gt[s[i]];
                        if (s[i+2] in ['0'..'9']) and (i+3 <= length(s)) and (s[i+3] in ['0'..'9']) then
                         begin
                             tt := s[i+2] + s[i+3];
                             i := i + 5;
                         end
                        else  begin
                                  tt := s[i+2];
                                  i := i + 4;
                              end;
                        val(tt,x);
                        with ma[dem] do
                        bfsma(x,y,d);
                        end;
                    end;
               end;
        end;

procedure main;
var i,j,temp,t,xhen,yhen,xdich,ydich,x1,x2,y1,y2 : longint;
        begin
            res := maxlongint;
            x1 := max(xvua - 2,1); y1 := max(yvua - 2,1);
            x2 := min(xvua + 2,m); y2 := min(yvua + 2,n);
            for i := 1 to m do
             for j := 1 to n do
             begin
              for t := 1 to dem do with ma[t] do
               inc(tongma[i,j],d[i,j]);
               res := min(res,tongma[i,j] + dvua[i,j]);
             end;
             for xhen := x1 to x2 do
              for yhen := y1 to y2 do
               begin
                    bfsma(xhen,yhen,ddich);
                    for i := 1 to m do
                     for j := 1 to n do
                      begin
                           for t := 1 to dem do with ma[t] do
                             begin
                                 temp := tongma[i,j] - d[i,j] + dvua[xhen,yhen] + d[xhen,yhen] + ddich[i,j]; res := min(res,temp);
                             end;
                      end;
               end;
             writeln(fo,res);
             close(fi); close(fo);

        end;

begin
      input;
      main;
end.
