uses math;
Const   maxn = 2001;
Var     a       :       array [1..maxn,1..maxn] of char;
        l,r,st     :       array [0..maxn] of longint;
        h       :       array [1..maxn,1..maxn] of longint;
        m,n,res,top     :       longint;

procedure nhap;
var i,j : longint;
        begin
            assign(input,'MAXRECT.INP'); reset(input);
            assign(output,'MAXRECT.OUT'); rewrite(output);
            readln(m,n);
            for i := 1 to m do
              begin
                  for j := 1 to n do read(a[i,j]);
                  readln;
              end;
        end;

procedure khoitao;
var i,j : longint;
        begin
            for j := 1 to n do if a[1,j] = '.' then h[1,j] := 1;
            for i := 2 to m do
             for j := 1 to n do
              if a[i,j] = '.' then h[i,j] := h[i-1,j]+1;
        end;

procedure main;
var i,j : longint;
        begin
             for i := 1 to m do
               begin
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
                                while (top > 0) and (h[i,j] >= h[i,st[top]]) do dec(top);
                                l[j] := j - st[top];
                                inc(top); st[top] := j;
                            end;
                      end;

                    top := 1; r[n] := 1; st[0] := n+1;
                    for j := n-1 downto 1 do
                      begin
                          if h[i,j] > h[i,j+1] then
                            begin
                                r[j] := 1;
                                inc(top); st[top] := j;
                            end
                          else
                            begin
                                while (top > 0) and (h[i,j] >= h[i,st[top]]) do dec(top);
                                r[j] := abs(j-st[top]);
                                inc(top); st[top] := j;
                            end;
                      end;

                    for j := 1 to n do res := max(res,h[i,j]*(l[j]+r[j]-1));
               end;
             write(res);

        end;

begin
    nhap;
    khoitao;
    main;
end.
