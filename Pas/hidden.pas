Const   maxn = 51;
        h       :       array [1..4] of integer = (-1,0,1,0);
        c       :       array [1..4] of integer = (0,1,0,-1);
Var     m,n,k,i,j,left,right   :       longint;
        a       :       array [1..maxn,1..maxn] of char;
        free    :       array [0..maxn,0..maxn,0..maxn] of boolean;
        qx,qy,qz   :       array [1..1000000] of longint;
        s       :       string;

function bfs(s : string) : boolean;
var i,j,px,py,k,now,pz : longint;
        begin
            fillchar(free,sizeof(free),false);
            for i := 1 to m do
             for j := 1 to n do
              for k := 1 to length(s) do
               free[i,j,k] := true;
            left :=0; right := 0;
            for i := 1 to m do
             for j := 1 to n do if a[i,j] = s[1] then
               begin
                   inc(right); qx[right] := i;
                   qy[right] := j; qz[right] := 1;
                   free[i,j,1] := false;
               end;

            if right = 0 then exit(false);
            j := 1;
            while j < length(s) do
              begin
                  inc(left);
                  inc(j); now := right;
                  for i := left to now do
                    begin
                        px := qx[i]; py := qy[i]; pz := qz[i];
                        for k := 1 to 4 do
                         if free[px+h[k],py+c[k],pz+1]
                          and (a[px+h[k],py+c[k]] = s[j]) then
                           begin
                               inc(right); qx[right] := px+h[k];
                               qy[right] := py+c[k]; qz[right] := pz+1;
							   free[px+h[k],py+c[k],pz+1] := false;
                           end;
                    end;
                  if right = now then exit(false);
                  left := now;
              end;
            exit(true);
        end;

begin
      assign(input,'HIDDEN.INP'); reset(input);
      assign(output,'HIDDEN.OUT'); rewrite(output);
      readln(m,n);
      for i := 1 to m do
        begin
             for j := 1 to n do read(a[i,j]);
             readln;
        end;
      readln(k);
      while k > 0 do
        begin
            dec(k); readln(s);
            if bfs(s) then writeln('Yes')
              else writeln('No');
        end;
end.
