uses math;
Const   inp = 'NKCNT1.INP';
        out = 'file.out';

Var m,n,i,j,num,k,u,v,t,i1,j1 : longint;
    s,h : array [0..21,0..21] of longint;
    x : char;

begin
     assign(input,inp) ;reset(input);
     assign(output,out); rewrite(output);
     readln(m,n);
     for i := 1 to m do
       begin
           for j := 1 to n do
             begin
                 read(x);
                 val(x,num);
                 s[i,j] := s[i-1,j]+s[i,j-1]-s[i-1,j-1]+num;
             end;
           readln;
       end;
    for i := 1 to m do
     for j := 1 to n do
       begin
           for k := 1 to min(i,j) do
            for i1 := k to i do
             for j1 := k to j do
            begin
                u:= i1 -k +1;
                v:= j1-k+1;
                t:= s[i1,j1] - s[u-1,j1] - s[i1,v-1] + s[u-1,v-1];
                if t <> 0 then inc(h[i,j]);
            end;
       end;
     for i :=1 to m do
       begin
           for j := 1 to n do write(h[i,j],' ');
           writeln;
       end;
end.