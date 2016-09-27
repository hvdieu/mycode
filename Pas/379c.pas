Const   maxn = 300001;


Var     n,i,last : longint;
        a,b,id : array [1..maxn] of longint;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,key : longint;
        begin
            if l >= h then exit;
            i := l; j := h; key := a[l+random(h-l+1)];
            repeat
               while a[i] < key do inc(i);
               while a[j] > key do dec(j);
               if i <= j then
                 begin
                     if i < j then
                     begin
                       swap(a[i],a[j]);
                       swap(id[i],id[j]);
                     end;
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

begin
     readln(n);
     for i := 1 to n do
     begin
       read(a[i]);
       id[i] := i;
     end;
     readln;
     sort(1,n);
     b[id[1]] := a[1]; last := a[1];
     for i := 2 to n do
      begin
          if a[i]<=last then
           begin
               b[id[i]] := last+1; inc(last);
           end
          else begin
                    last := a[i]; b[id[i]] := last;
                end;
      end;
     for i := 1 to n do write(b[i],' ');
end.