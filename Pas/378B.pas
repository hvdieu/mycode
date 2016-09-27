
Const   maxn = 200001;
        inp = '';
        out = '';
Type    arr     = array [0..maxn] of longint;

Var     n,i,k,m,j : longint;
        a,b,c,id,pos,tt,t,f : arr;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint; var k : arr);
var i,j,key : longint;
        begin
            if l >= h then exit;
            i := l; j := h; key := k[l+random(h-l+1)];
            repeat
               while k[i] < key do inc(i);
               while k[j] > key do dec(j);
               if i <= j then
                 begin
                     if i < j then
                       begin
                         swap(k[i],k[j]);
                         swap(id[i],id[j]);
                       end;
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j,k); sort(i,h,k);
        end;

procedure update(i,val : longint);
        begin
            while i <= 2*n do
             begin
                 inc(t[i],val);
                 inc(i,i and (-i));
             end;
        end;

function get(i : longint) : longint;
var s : longint;
        begin
            s := 0;
            while i > 0 do
              begin
                 inc(s,t[i]);
                 dec(i,i and (-i));
              end;
            exit(s);
        end;

function find(k : longint) : longint;
var d,c,mid,ans,x : longint;
        begin
             d := 1; c := 2*n;
             ans := 0;
             while d <= c do
              begin
                  mid := (d+c) shr 1;
                  x := get(mid);
                  if x = k then exit(mid)
                   else if x > k then c := mid-1
                    else d := mid+1;
              end;
             exit(ans);
        end;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(n);
     for i := 1 to n do readln(a[i],b[i]);
     for i := 1 to n do
       begin
           id[i] := i; c[i] := a[i];
           id[i+n] := i+n; c[i+n] := b[i];
       end;
     sort(1,2*n,c);
     for i := 1 to 2*n do pos[id[i]] := i;
     for i := 1 to 2*n do update(i,1);
     inc(f[1]); dec(f[n+1]);
     for k := 1 to n div 2 do
       begin
          inc(f[pos[k]]); dec(f[pos[k]+1]); inc(f[pos[k+n]]); dec(f[pos[k+n]+1]);
          update(pos[k],-1); update(pos[k+n],-1);
          j := find(n-2*k);
          inc(f[1]); dec(f[j+1]);
       end;

     for i := 1 to 2*n do
     begin
       f[i] := f[i-1]+f[i];
       if f[i] > 0 then tt[id[i]] := 1;
     end;
     for i := 1 to n do write(tt[i]); writeln;
     for i := n+1 to 2*n do write(tt[i]);
end.