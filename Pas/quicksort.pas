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
                     if i < j then swap(k[i],k[j]);
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j,k); sort(i,h,k);
        end;