Const   maxn = 251;
        oo = 97654321;
Var     f       :       array [-1..maxn,-1..maxn,'A'..'z'] of int64;
        u,l,n,i,m,v,k   :       longint;
        a       :   array ['A'..'z','A'..'z'] of longint;
        c1,c2   :   char;
        res     :   int64;

procedure main;
var i,j : longint;
    c1,c2,ch  : char;
        begin
              for i := 0 to u do
               for j := 0 to l do
                if i+j > 2 then
                  begin
                      for c2 := 'A' to 'z' do
                        for c1 := 'A' to 'z' do
                         if a[c1,c2] > 0 then
                          begin
                              if c2 in ['a'..'z'] then f[i,j,c2] := (f[i,j,c2]+f[i-1,j,c1]*a[c1,c2]) mod oo
                               else f[i,j,c2] := (f[i,j,c2]+f[i,j-1,c1]*a[c1,c2]) mod oo;
                          end;
                  end;
              for ch := 'A' to 'z' do
                begin
                    res := res + f[u,l,ch];
                    res := res mod oo;
                end;
              writeln(res);
        end;

begin
     assign(input,'cowlpha.inp'); reset(input);
     assign(output,'cowlpha.out'); rewrite(output);
     readln(u,l,m);
     for i := 1 to m do
       begin
           readln(c1,c2);
           inc(a[c1,c2]);
           k := 0; v := 0;
           if c1 in ['a'..'z'] then inc(k)
            else inc(v);
           if c2 in ['a'..'z'] then inc(k)
            else inc(v);
           inc(f[k,v,c2]);
       end;
     main;
end.
