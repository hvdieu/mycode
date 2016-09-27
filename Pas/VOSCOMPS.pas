Uses math;
Const
    inp = 'VOSCOMPS.INP';
    out = 'VOSCOMPS.OU1';
    maxn = 100001;

Var
    n,q,i,u,v,top,last,temp,r1,r2,k : longint;
    x,y,root : array [1..maxn] of longint;

function getroot(u : longint) : longint;
begin
    if u<>root[u] then root[u] := getroot(root[u]);
    exit(root[u]);
end;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
    read(n,q);
    last := 0;
    while q > 0 do
     begin
         dec(q);
         readln(k,u,v);
         if (u>v) then
           begin
               temp := u; u := v; v := temp;
           end;
         if k=1 then
           begin
               inc(top);
               x[top] := u; y[top] := v;
           end
         else if k=2 then
          begin
              for i := 1 to top do
               if (x[i]=u) and (y[i]=v) then
                begin
                    x[i] := 0; y[i] := 0;
                    break;
                end;
          end
         else begin
             for i := 1 to n do root[i] := i;
             for i := 1 to top do
              if x[i]<>0 then
               begin
                   r1 := getroot(x[i]); r2 := getroot(y[i]);
                   if r1<>r2 then root[r1] := root[r2];
               end;
             r1 := getroot(u); r2 := getroot(v);
             if r1=r2 then writeln(1) else writeln(0);
         end;
     end;
end.
