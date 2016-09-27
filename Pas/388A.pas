Var     n,sl,i,j       :       longint;
        x,dem       :       array [0..1000] of longint;
        ok : boolean;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,key : longint;
        begin
            if l >= h then exit;
            i := l; j := h; key := x[l+random(h-l+1)];
            repeat
               while x[i] < key do inc(i);
               while x[j] > key do dec(j);
               if i <= j then
                 begin
                     if i < j then swap(x[i],x[j]);
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j); sort(i,h);
        end;


begin
     //
     readln(n);
     for i := 1 to n do read(x[i]);
     sort(1,n);
     sl := 1; dem[1] := 1;
     for i := 2 to n do
       begin
           ok := false;
           for j := 1 to sl do
            if x[i] >= dem[j] then
              begin
                  ok := true;
                  inc(dem[j]);
                  break;
              end;
            if ok = false then
             begin
                 inc(sl); dem[sl] := 1;
             end;
       end;
     write(sl);
end.
