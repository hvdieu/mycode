Const   maxn = 100005;
Var     a,pos,kq1,kq2   :       array [1..maxn] of longint;
        n,i,d,t       :       longint;
        ok      :   boolean;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,ka,kp,k : longint;
        begin
             if l >= h then exit;
             i := l; j := h;
             k := l + random(h-l+1);
             ka := a[k]; kp := pos[k];
             repeat
               while (a[i] < ka) or ((a[i]=ka) and (pos[i] < kp)) do inc(i);
               while (a[j] > ka) or ((a[j]=ka) and (pos[j] > kp)) do dec(j);
               if i <= j then
                 begin
                    if i < j then
                      begin
                          swap(a[i],a[j]);
                          swap(pos[i],pos[j]);
                      end;
                    inc(i); dec(j);
                 end;
             until i > j;
             sort(l,j); sort(i,h);
        end;

begin
    // assign(input,'b.inp'); reset(input);
    // assign(output,'b.out'); rewrite(output);
     read(n);
     for i := 1 to n do
      begin
          read(a[i]);
          pos[i] := i;
      end;
     a[n+1] := maxlongint;
     sort(1,n);
     i := 1;
     while i <= n do
       begin
           if a[i] <> a[i+1] then
            begin
               inc(t);
               kq1[t] := a[i];
               kq2[t] := 0;
            end
            else
           begin
               d := pos[i+1] - pos[i];
               inc(i);
               ok := true;
               while (i < n) and (a[i] = a[i+1]) do
                begin

                        if d <> pos[i+1] - pos[i] then ok := false;
                        inc(i);
                end;
               if ok then
                begin
                   inc(t);
                   kq1[t] := a[i];
                   kq2[t] := d;
                end;
           end;
          inc(i);
       end;
       writeln(t);
       for i := 1 to t do writeln(kq1[i],' ',kq2[i]);
end.