Uses math;
Const   maxn = 150;
        maxw = 999999999;
Var     n,k,j,x,y,vt,m,i       :       longint;
        f,nuoc,tangluc,g               :       array [0..maxn] of longint;

procedure main;
var i,j,cp,q : longint;
        begin
            for i := 1 to n do
              begin
                  f[i] := maxw; g[i] := maxw;
              end;
            for i := 0 to n do
              begin
                  if f[i+1] > f[i]+1 then
                    begin
                        f[i+1] := f[i]+1;
                        g[i+1] := g[i];
                    end
                  else if (f[i+1] = f[i]+1) and (g[i+1] > g[i]) then g[i+1] := g[i];

                  if nuoc[i] > 0 then
                    for q := 1 to nuoc[i] do
                     if i+q <= n then
                      if f[i+q] > f[i]+1 then
                        begin
                            f[i+q] := f[i]+1;
                            g[i+q] := g[i];
                        end
                      else if (f[i+q]=f[i]+1) and (g[i+q] > g[i]) then g[i+q] := g[i];

                  if tangluc[i] > 0 then
                   for q := 2 to 2*tangluc[i] do
                    if i + q <= n then
                      begin
                       cp := q div 2; if q mod 2 = 1 then inc(cp);
                       if f[i+q] > f[i]+1 then
                        begin
                           f[i+q] := f[i]+1;
                           g[i+q] := g[i]+cp;
                        end
                       else if (f[i+q]=f[i]+1) and (g[i+q] > g[i]+cp) then g[i+q] := g[i]+cp;
                      end;
              end;
            writeln(f[n],' ',g[n]);
        end;


begin
      assign(input,'SCARA.INP'); reset(input);
      assign(output,'SCARA.OUT'); rewrite(output);
      readln(n);
      readln(k);
      for i := 1 to k do
        begin
            read(vt,x); nuoc[vt] := x;
        end;
      readln(m);
      for i := 1 to m do
        begin
            read(vt,y); tangluc[vt] := y;
        end;
      main;

end.
