uses math;
Const   maxn = 10001;
        p = 26;
        p1 = 1000000007;
Var     n,m,hash     :       longint;
        s1,s2   :       string;
        mu,h,ht   :       array [0..maxn] of longint;

procedure nhap;
var i : longint;
        begin
             assign(input,'neck.inp'); reset(input);
             assign(output,'neck.out'); rewrite(output);
             readln(s1); readln(s2);
             n := length(s1); m := length(s2);
             mu[0] := 1;
             for i := 1 to n do mu[i] := (int64(mu[i-1])*p) mod p1;
             for i := 1 to m do hash := (int64(hash)*26 + ord(s2[i]) - ord('a')) mod p1;
        end;

function xuly(s : string) : longint;
var i,x,dem,d,c,temp,vt,j : longint;
    t,st : string;
        begin
             if length(s) = m then
              if s = s2 then exit(1) else exit(0);
             if length(s) < m then exit(0);
             for i := 1 to length(s) do
              h[i] := (int64(h[i-1]) * p + ord(s[i]) - ord('a')) mod p1;
             dem := 0;
             for i := 1 to length(s) - m + 1 do
              begin
                x := (h[i+m-1] - int64(h[i-1])*mu[m] + int64(p1)*p1) mod p1;
                if x = hash then inc(dem);
              end;
             if dem=0 then exit(0);
             temp := maxlongint;
             for i := 1 to length(s) do
               begin
                   dem := 0;
                   t := s;
                   delete(t,i,1);
                   for j := 1 to length(t) do
                    ht[j] := (int64(ht[j-1])*p + ord(t[j]) - ord('a')) mod p1;
                   for j := 1 to length(t)-m+1 do
                    begin
                        x := (ht[j+m-1] - int64(ht[j-1]*mu[m]) *int64(p1)*p1) mod p1;
                        if x = hash then inc(dem);
                    end;
                   if dem < temp then
                     begin
                         temp := dem; vt := i; st := t;
                     end;
               end;
            exit(1 + xuly(st));
        end;

begin
     nhap;
     xuly(s1);
end.


