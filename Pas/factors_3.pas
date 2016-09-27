Var     oo,n,k,res,dem   :  qword;
        mu,p      :       array [0..20] of qword;
        id,st     :       array [1..1000000] of qword;
        c       : array [0..63,0..63] of qword;
        top     :longint;

procedure khoitao;
var i,j : longint;
        begin
            mu[0] := 63;
            p[1] := 2; p[2] := 3; p[3] := 5; p[4] := 7; p[5] := 11;
            p[6] := 13; p[7] := 17; p[8] := 19; p[9] := 23; p[10] := 29;
            p[11] := 31; p[12] := 37; p[13] := 41; p[14] := 43;
            p[15] := 47; p[16] := 53; p[17] := 59; p[18] := 61;
            For i := 0 to 63 do c[0,i] := 1;
            For i := 1 to 63 do c[i,0] := 0;

            For i := 1 to 63 do
               For j := i to 63 do
                  c[i,j] := (c[i-1,j-1] + c[i,j-1]);
            c[0,0] := 0;
            oo := 1;
            for i := 1 to 63 do oo := oo*2;
            res := oo;
            dec(oo);
        end;

procedure swap(var xx,yy : qword);
var temp : qword;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,k : longint;
    k1,k2 : qword;
        begin
            if l >= h then exit;
            i := l; j := h; k := l+random(h-l+1);
            k1 := id[k]; k2 := st[k];
            repeat
                while (id[i] < k1) or ((id[i] = k1) and (st[i] < k2)) do inc(i);
                while (id[j] > k1) or ((id[j] = k1) and (st[j] > k2)) do dec(j);
                if i <= j then
                  begin
                      if i < j then
                        begin
                            swap(id[i],id[j]);
                            swap(st[i],st[j]);
                        end;
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

procedure xuly(i : longint;k : qword);
var j,tong,luu : longint;
    sum : int64;
        begin
            sum := 1;
            luu := mu[i];
            tong := 0;
            for j := 1 to i-1 do tong := tong + mu[j];
            for j := i-1 downto 1 do
              begin
                 if oo div sum >= c[mu[j],tong] then
                 sum := sum*c[mu[j],tong]
                 else exit;
                 tong := tong - mu[j];
              end;
            inc(top); id[top] := sum; st[top] := k;
        end;

procedure duyet(i : longint; k : int64);
var j : longint;
        begin
             if i > 17 then exit;
             if i > 1 then xuly(i,k);
             for j := 1 to mu[i-1] do
               begin
                   if oo div k >= p[i] then
                     begin
                         if j > 0 then
                         k := k*p[i];
                         mu[i] := j;
                         if k <= oo then duyet(i+1,k);
                     end;
               end;
        end;

function find(n : qword) : qword;
var d,mid,c : longint;
    res : qword;
        begin
            d := 1; c := top;
            while d <= c do
              begin
                  mid := (d+c) shr 1;
                  if id[mid] = n then
                    begin
                       res := st[mid];
                       c := mid - 1;
                    end
                  else if id[mid] > n then c := mid-1
                   else d := mid + 1;
              end;
            exit(res);
        end;

begin
      assign(input,'factors.inp'); reset(input);
      assign(output,'factors.out'); rewrite(output);
      khoitao;
      fillchar(mu,sizeof(mu),0); k := 1;
      mu[0] := 63;
      res := oo+1;
      duyet(1,k);
      sort(1,top);
      while not eof(input) do
        begin
            readln(n);
            writeln(n,' ',find(n));
        end;
end.
