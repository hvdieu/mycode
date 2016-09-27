Const   maxn = 10001;
        maxw = 999999999;
Var     f       :       array [0..maxn] of longint;
        g       :       array [0..maxn] of string;
        cong    :       array [1..maxn] of boolean;
        n,k     :       longint;
        st      :       string;

procedure khoitao;
var i : longint;
        begin
            for i := 1 to maxn do f[i] := maxw;
        end;

procedure tinh(x : longint);
var i,j,a,b : longint;
        begin
            if f[x] <> maxw then exit;
            if x <= k then
              begin
                  str(x,st); f[x] := length(st);
                  g[x] := st;
                  cong[x] := false;
                  exit;
              end;
            for j := 1 to k do
             begin
                 tinh(j); tinh(x-j);
                 if f[j] + f[x-j] < f[x] then
                   begin
                       f[x] := f[j] + f[x-j] + 1;
                       g[x] := g[j] + '+' + g[x-j];
                   end;
                 cong[x] := true;
             end;

            for j := 2 to x-1 do
             if x mod j = 0 then
               begin
                   a := j; b := x div j;
                   tinh(a); tinh(b);
                   if cong[a] and cong[b] then
                    begin
                     if f[x] >= f[a]+f[b]+5 then
                       begin
                         f[x] := f[a]+f[b]+5;
                         g[x] := '('+g[a]+')'+'*'+'('+g[b]+')';
                         cong[x] := false;
                       end;
                    end
                   else if (cong[a] = false) and (cong[b] = false) then
                     begin
                         if f[x] >= f[a]+f[b]+1 then
                           begin
                               f[x] := f[a]+f[b]+1;
                               g[x] := g[a] + '*' + g[b];
                               cong[x] := false;
                           end;
                     end
                   else if (cong[a] = false) and (cong[b] = true) then
                     begin
                         if f[x] >= f[a]+f[b]+3 then
                           begin
                               f[x] := f[a]+f[b]+3;
                               g[x] := g[a]+'*'+'('+g[b]+')';
                               cong[x] := false;
                           end;
                     end
                   else if (cong[a] = true) and (cong[b] = false) then
                     begin
                         if f[x] >= f[a]+f[b]+3 then
                           begin
                               f[x] := f[a]+f[b]+3;
                               g[x] := '('+g[a]+')'+'*'+g[b];
                               cong[x] := false;
                           end;
                     end;
               end;

        end;

begin
     assign(input,'EXP.INP'); reset(input);
     assign(output,'EXP.OUT'); rewrite(output);
     readln(n,k);
     khoitao;
     tinh(n);
     writeln(f[n]);
     writeln(g[n]);
end.
