Var     oo,n,k,res,dem   :  qword;
        mu,p      :       array [0..20] of qword;
        c       : array [0..63,0..63] of qword;

procedure khoitao;
var i,j : longint;
        begin
            mu[0] := 63;
            p[1] := 2; p[2] := 3; p[3] := 5; p[4] := 7; p[5] := 11;
            p[6] := 13; p[7] := 17; p[8] := 19; p[9] := 23; p[10] := 29;
            p[11] := 31; p[12] := 37; p[13] := 39; p[14] := 41;
            p[15] := 43; p[16] := 47;
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
            if (sum = n) and (k < res) then res := k;
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

begin
      assign(input,'factors.inp'); reset(input);
      assign(output,'factors.out'); rewrite(output);
      khoitao;
      while not eof(input) do
        begin
            readln(n);
            write(n,' ');
            fillchar(mu,sizeof(mu),0); k := 1;
            mu[0] := 63;
            res := oo+1;
            duyet(1,k);
            writeln(res);
        end;
end.
