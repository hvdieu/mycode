Uses math;
Const   inp = '';
        out = '';
        maxn = 501;
        oo = 999999999999999999;
Var     n,i,j,k,u,v,l,kind,ntest,m : longint;
        c : array [1..maxn,1..maxn] of qword;
        mo : array [1..maxn] of boolean;


begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(n,m,ntest);
     for i := 1 to n do
      for j := 1 to n do
       if i=j then c[i,j] := 0 else c[i,j] := oo;

     for i := 1 to m do
      begin
         readln(u,v,l); c[u,v] := l;
      end;
     for i := 1 to ntest do
       begin
           read(kind);
           if kind=1 then
            begin
               read(k);
               if mo[k]=false then
                begin
                    mo[k] := true;
                    for u := 1 to n do
                     for v := 1 to n do
                      if c[u,v]>c[u,k]+c[k,v] then c[u,v] := c[u,k]+c[k,v];
                end;
            end
           else
            begin
                read(u,v);
                if c[u,v]=oo then writeln(-1) else writeln(c[u,v]);
            end;
       end;
end.
