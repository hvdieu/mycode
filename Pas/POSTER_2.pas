Const   maxn = 250001;
Var     i,n,x,top,res     :       longint;
        a,id,st,r       :       array [0..maxn] of longint;
        free    :       array [1..maxn] of boolean;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy ; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,k,k1,k2 : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := l+random(h-l+1);
            k1 := a[k]; k2 := id[k];
            repeat
                while (a[i] < k1) or ((a[i] = k1) and (id[i] < k2)) do inc(i);
                while (a[j] > k1) or ((a[j] = k1) and (id[j] > k2)) do dec(j);
                if i <= j then
                  begin
                      if i < j then
                        begin
                            swap(a[i],a[j]);
                            swap(id[i],id[j]);
                            swap(r[i],r[j]);
                        end;
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

procedure main;
var i,j  : longint;
        begin
             top := 1; st[1] := n; r[n] := 1; st[0] := n+1;
             for i := n-1 downto 1 do
               if a[i] > a[i+1] then
                begin
                    r[i] := 1; inc(top); st[top] := i;
                end
               else begin
                      while (top > 0) and (a[st[top]] >= a[i]) do dec(top);
                      r[i] := abs(i-st[top]);
                      inc(top); st[top] := i;
                    end;

             sort(1,n);
             fillchar(free,sizeof(free),true);
             for i := 1 to n do
              if free[i] then
               begin
                   inc(res);
                   for j := i+1 to n do
                    if (a[i] = a[j]) and (id[j] <= id[i]+r[i]-1) then free[j] := false
                     else break;
               end;
             writeln(res);
        end;

begin
     assign(input,'POSTER.INP'); reset(input);
     assign(output,'POSTER.OUT'); rewrite(output);
     readln(n);
     for i := 1 to n do
      begin
        readln(x,a[i]);
        id[i] := i;
      end;
     main;
end.