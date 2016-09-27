Const   maxn = 1001;
Var     n,i     :       longint;
        x,y     :       array [1..maxn] of longint;
        ok      :       boolean;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var k,k1,k2,i,j : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := l+random(h-l+1);
            k1 := y[k]; k2 := x[k];
            repeat
               while (y[i] < k1) or ((y[i]=k1) and (x[i] < k2)) do inc(i);
               while (y[j] > k1) or ((y[j]=k1) and (x[j] > k2)) do dec(j);
               if i <= j then
                 begin
                      if i < j then
                        begin
                            swap(x[i],x[j]);
                            swap(y[i],y[j]);
                        end;
                      inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

function check1 : boolean;
var i,j : longint;
        begin
             ok := true;
             for i := 1 to n-1 do
              if x[i] <> x[i+1] then
                begin
                  ok := false;
                  break;
                end;
             if ok then exit(true);
             ok := true;
             for i := 1 to n-1 do
              if y[i] <> y[i+1] then
                begin
                  ok := false;
                  break;
                end;
             if ok then exit(true);
             ok := true;
             for i := 1 to n-1 do
              if x[i]-y[i] <> x[i+1]-y[i+1] then
                begin
                   ok := false;
                   break;
                end;
             if ok then exit(true);
             ok := true;
             for i := 1 to n-1 do
              if x[i]+y[i] <> x[i+1]+y[i+1] then
                begin
                    ok := false;
                    break;
                end;
             if ok then exit(true);
             exit(false);
        end;

procedure sort2(l,h : longint);
var k,k1,k2,i,j : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := l+random(h-l+1);
            k1 := y[k]; k2 := x[k];
            repeat
               while (y[i] < k1) or ((y[i]=k1) and (x[i] > k2)) do inc(i);
               while (y[j] > k1) or ((y[j]=k1) and (x[j] < k2)) do dec(j);
               if i <= j then
                 begin
                      if i < j then
                        begin
                            swap(x[i],x[j]);
                            swap(y[i],y[j]);
                        end;
                      inc(i); dec(j);
                 end;
            until i > j;
            sort2(l,j); sort2(i,h);
        end;


function check2 : boolean;
var i,j,hs,xnext : longint;
        begin
            sort(1,n);
            ok := true;
            i := 1;
            repeat
                if i >= n then break;
                while (y[i] = y[i+1]) and (i < n) do inc(i);
                if i = n then break;
                hs := x[i]+y[i];
                xnext := hs-y[i+1];
                if xnext > x[i+1] then
                  begin
                      ok := false;
                      break;
                  end;
                inc(i);
            until false;
            if ok then exit(true);
            sort2(1,n);
            ok := true;
            i := 1;
            repeat
                if i >= n then break;
                while (y[i]=y[i+1]) and (i < n) do inc(i);
                if i = n then break;
                hs := x[i]-y[i];
                xnext := hs+y[i+1];
                if xnext < x[i+1] then
                  begin
                      ok := false;
                      break;
                  end;
                inc(i);
            until false;
            if ok then exit(true);
            exit(false);
        end;

begin
      assign(input,'CTRLK.INP'); reset(input);
      assign(output,'CTRLK.OUT'); rewrite(output);
      readln(n);
      for i := 1 to n do read(x[i],y[i]);
      if n = 1 then write(8) else
      if check1 then write(7)
       else if check2 then write(6)
        else write(5);
end.