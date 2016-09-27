uses math;
Const   maxn = 1000001;
Var     n,dau,cuoi,mid,res       :       longint;
        d,t     :       array [1..maxn] of longint;

procedure nhap;
var i : longint;
        begin
            assign(input,'PROCRAS.INP'); reset(input);
            assign(output,'PROCRAS.OUT'); rewrite(output);
            readln(n);
            cuoi := maxlongint;
            for i := 1 to n do
              begin
                read(d[i],t[i]);
                cuoi := min(cuoi,t[i]);
              end;
        end;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,key : longint;
        begin
            if l >= h then exit;
            i := l; j := h;
            key := t[(l+h) div 2];
            repeat
                while t[i] < key do inc(i);
                while t[j] > key do dec(j);
                if i <= j then
                  begin
                      if i < j then
                        begin
                            swap(t[i],t[j]);
                            swap(d[i],d[j]);
                        end;
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

function check(x : longint) : boolean;
var i : longint;
        begin
            for i := 1 to n do
              begin
                  x := x + d[i];
                  if x > t[i] then exit(false);
              end;
            exit(true);
        end;

procedure main;
        begin
            dau := 0;
            sort(1,n);
            while dau <= cuoi do
              begin
                  mid := (dau+cuoi) shr 1;
                  if check(mid) then
                    begin
                        dau := mid+1;
                        res := mid;
                    end
                  else cuoi := mid-1;
              end;
            write(res);
        end;

begin
    nhap;
    main;
end.
