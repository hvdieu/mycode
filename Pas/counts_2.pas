Const   maxn = 41;
Var     n,i,m,s,top     :       longint;
        a,b     :       array [1..maxn] of longint;
        x       :       array [0..maxn] of longint;
        st       :       array [0..1048580] of longint;
        res     :       int64;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,k : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := st[l+random(h-l+1)];
            repeat
                while st[i] < k do inc(i);
                while st[j] > k do dec(j);
                if i <= j then
                  begin
                      if i < j then
                        begin
                            swap(st[i],st[j]);
                        end;
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

procedure ql(i,k : longint;sum : longint);
var j : longint;
        begin
             if sum > s then exit;
             for j := x[i-1]+1 to m-k+i do
               begin
                   x[i] := j;
                   if i = k then
                    begin
                       if sum + a[j] <= s then
                         begin
                             inc(top);
                             st[top] := sum+a[j];
                         end;
                       if sum + a[j] = s then inc(res);
                    end
                    else ql(i+1,k,sum+a[j]);
               end;
        end;

function find1(key : longint) : longint;
var d,c,mid,ans : longint;
        begin
             d := 1; c := top; ans := 0;
             while d <= c do
               begin
                   mid := (d+c) shr 1;
                   if st[mid] = key then
                     begin
                         ans := mid;
                         c := mid-1;
                     end
                   else if st[mid] > key then c := mid-1
                    else d := mid+1;
               end;
             exit(ans);
        end;

function find2(key : longint) : longint;
var d,c,mid,ans : longint;
        begin
             d := 1; c := top; ans := 0;
             while d <= c do
               begin
                    mid := (d+c) shr 1;
                    if st[mid] = key then
                      begin
                         ans := mid;
                         d := mid+1;
                      end
                    else if st[mid] > key then c := mid-1
                     else d := mid+1;
               end;
             exit(ans);
        end;

procedure xuly(sum : longint);
var i,j,key : longint;
        begin
             if sum > s then exit;
             if sum = s then inc(res);
             key := s - sum;
             i := find1(key);
             j := find2(key);
             if (i=0) or (j=0) then exit;
             inc(res,j-i+1);
        end;

procedure sinh(i,k,sum : longint);
var j : longint;
        begin
             if sum > s then exit;
             for j := x[i-1]+1 to n-k+i do
               begin
                   x[i] := j;
                   if i = k then xuly(sum+b[j])
                    else sinh(i+1,k,sum+b[j]);
               end;
        end;

procedure main;
var i,k : longint;
        begin
             fillchar(x,sizeof(x),0);
             for k := 1 to m do
               ql(1,k,0);
             sort(1,top);
             fillchar(x,sizeof(x),0);
             for k := 1 to n do
              sinh(1,k,0);
             writeln(res);
        end;

begin
      assign(input,'counts.inp'); reset(input);
      assign(output,'counts.out'); rewrite(output);
      readln(n);
      m := n div 2;
      n := n-m;
      for i := 1 to m do read(a[i]);
      for i := 1 to n do read(b[i]);
      read(s);
      main;
end.