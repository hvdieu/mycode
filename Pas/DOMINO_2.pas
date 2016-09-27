Uses math;
Const   maxn = 100001;
Var     n,i     :       longint;
        x,h,id,z  :       array [1..maxn] of longint;
        t       :       array [1..4*maxn] of longint;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(d,c : longint);
var i,j,k : longint;
        begin
             if d >= c then exit;
             i := d; j := c; k := x[d+random(c-d+1)];
             repeat
                while x[i] < k do inc(i);
                while x[j] > k do dec(j);
                if i <= j then
                  begin
                       if i < j then
                         begin
                             swap(x[i],x[j]);
                             swap(h[i],h[j]);
                             swap(id[i],id[j]);
                         end;
                       inc(i); dec(j);
                  end;
             until i > j;
             sort(d,j); sort(i,c);
        end;

function find(i : longint) : longint;
var d,c,mid,key,ans : longint;
        begin
            d := i; c := n; key := x[i]+h[i]-1;
            while d <= c do
              begin
                  mid := (d+c) div 2;
                  if x[mid] > key then c := mid-1
                   else
                     begin
                         ans := mid;
                         d := mid+1;
                     end;
              end;
            exit(ans);
        end;

procedure update(i,lo,hi,u,x : longint);
var mid : longint;
        begin
              if (lo > u) or (hi < u) then exit;
              if (lo=u) and (hi=u) then
                begin
                    t[i] := x;
                    exit;
                end;
              mid := (lo+hi) shr 1;
              update(i*2,lo,mid,u,x); update(i*2+1,mid+1,hi,u,x);
              t[i] := max(t[i*2],t[i*2+1]);
        end;

function get(i,lo,hi,u,v : longint) : longint;
var mid,x,y : longint;
        begin
              if (v < lo) or (u > hi) then exit(-maxlongint);
              if (u <= lo) and (v >= hi) then exit(t[i]);
              mid := (lo+hi) shr 1;
              x := get(i*2,lo,mid,u,v);
              y := get(i*2+1,mid+1,hi,u,v);
              exit(max(x,y));
        end;

procedure main;
var i,j,temp : longint;
        begin
            sort(1,n); z[id[n]] := 1;
            update(1,1,n,n,n);
            for i := n-1 downto 1 do
              begin
                    j := find(i);
                    if j = i then
                      begin
                          z[id[i]] := 1;
                          update(1,1,n,i,i);
                      end
                    else begin
                             temp := get(1,1,n,i+1,j);
                             z[id[i]] := temp-i+1;
                             update(1,1,n,i,temp);
                         end;
              end;
            for i := 1 to n do write(z[i],' ');
        end;

begin
      assign(input,'DOMINO.INP'); reset(input);
      assign(output,'DOMINO.OUT'); rewrite(output);
      readln(n);
      for i := 1 to n do
       begin
         read(x[i],h[i]);
         id[i] := i;
       end;
      main;
end.
