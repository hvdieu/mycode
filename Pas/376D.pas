Uses math;
Const   maxn = 5001;
        inp = '376d.inp';
        out = '376d.out';
Var     h,a       :       array [0..maxn,0..maxn] of longint;
        d,l,r,st       :       array [0..maxn] of longint;
        m,n,res,i,j,top     :       longint;
        ch      :       char;

{************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
            for j := 1 to n do if a[1,j] = 1 then h[1,j] := 1;
            for i := 2 to m do
             for j := 1 to n do
              if a[i,j] = 1 then h[i,j] := h[i-1,j]+1;
        end;

procedure main;
var i,j : longint;
        begin
             for i := 1 to m do
               begin
                    fillchar(l,sizeof(l),0); fillchar(r,sizeof(r),0);
                    top := 1; l[1] := 1; st[1] := 1; st[0] := 0;
                    for j := 2 to n do
                      begin
                          if h[i,j] > h[i,j-1] then
                            begin
                                l[j] := 1;
                                inc(top); st[top] := j;
                            end
                          else
                            begin
                                while (top > 0) and (h[i,j] <= h[i,st[top]]) do dec(top);
                                l[j] := j - st[top];
                                inc(top); st[top] := j;
                            end;
                      end;

                    top := 1; r[n] := 1; st[0] := n+1; st[1] := n;
                    for j := n-1 downto 1 do
                      begin
                          if h[i,j] > h[i,j+1] then
                            begin
                                r[j] := 1;
                                inc(top); st[top] := j;
                            end
                          else
                            begin
                                while (top > 0) and (h[i,j] <= h[i,st[top]]) do dec(top);
                                r[j] := abs(j-st[top]);
                                inc(top); st[top] := j;
                            end;
                      end;

                    for j := 1 to n do res := max(res,h[i,j]*(l[j]+r[j]-1));
               end;
             write(res);

        end;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(m,n);
     for i := 1 to m do
       begin
           for j := 1 to n do
             begin
                 read(ch);
                 if ch = '1' then inc(d[i]);
             end;
           readln;
       end;
     for i := 1 to m do
       begin
           for j := 1 to d[i] do a[i,j] := 1;
           for j := d[i]+1 to n do a[i,j] := 0;
       end;
     khoitao;
     main;

end.
