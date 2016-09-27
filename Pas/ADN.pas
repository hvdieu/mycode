{$H+}
Uses math;
Const   maxn = 18;
        maxm = 30005;
        p  =  26;
        p1 = 1000000007;
        maxw = 999999999;

Var     n,m,i,mm,n1,dem     :       longint;
        s,s1       :       array [0..maxn] of string;
        a       :       array [1..maxn,1..maxn] of longint;
        free    :       array [1..maxn] of boolean;
        f,trace       :       array [0..262145,1..maxn] of longint;
        kq      :     array [1..maxn] of longint;
        hash       :       array [1..maxn,0..maxm] of longint;
        mu      :       array [0..maxm] of longint;

function gethash(i,d,c : longint) : longint;
        begin
          gethash := (hash[i,c] - int64(hash[i,d-1])*mu[c-d+1] + int64(p1)*p1) mod p1;
        end;

procedure init;
var i,j,k,x1,x2,d,m1,m2 : longint;
        begin
             mu[0] := 1;
             for i := 1 to mm do mu[i] := (int64(mu[i-1])*p) mod p1;
             for i := 1 to n do
               begin
                 m := length(s[i]);
                 for j := 1 to m do
                  hash[i,j] := (int64(hash[i,j-1])*p + ord(s[i][j]) - ord('A')) mod p1;
               end;

              fillchar(free,sizeof(free),true);
              for i := 1 to n do
               for j := 1 to n do
                if (i<>j) and (length(s[i]) <= length(s[j])) and free[j] then
                 begin
                     m1 := length(s[i]); m2 := length(s[j]);
                     x1 := gethash(i,1,m1);
                     for k := 1 to m2-m1+1 do
                       begin
                           x2 := gethash(j,k,k+m1-1);
                           if x1 = x2 then
                            begin
                                free[i] := false;
                                break;
                            end;
                       end;
                 end;
              for i := 1 to n do
               if free[i] then
                 begin
                     inc(n1); s1[n1] := s[i];
                 end;
              n := n1;
              for i := 1 to n do s[i] := s1[i];
              for i := 1 to n do
               begin
                 m := length(s[i]);
                 for j := 1 to m do
                  hash[i,j] := (int64(hash[i,j-1])*p + ord(s[i][j]) - ord('A')) mod p1;
               end;
              for i := 1 to n do
              for j := 1 to n do
               if i <> j then
                begin
                   m1 := length(s[i]); m2 := length(s[j]);
                   d := min(length(s[i]),length(s[j]));
                   while d >= 0 do
                     begin
                         x1 := gethash(i,m1-d+1,m1);
                         x2 := gethash(j,1,d);
                         if x1 = x2 then break;
                         dec(d);
                     end;
                   a[i,j] := d;
                end;

              for i := 1 to 1 shl n -1 do
              for j := 1 to n do
                f[i,j] := maxw;
              for i := 1 to n do
               begin
                 f[1 shl (i-1),i] := length(s[i]);
                 trace[1 shl (i-1),i] := i;
               end;
        end;

function bat(x,i : longint) : longint;
        begin
            exit(x or (1 shl i));
        end;

function lay(x,i : longint) : longint;
        begin
            exit( (x shr i) and 1 );
        end;

function tat(x,i : longint) : longint;
        begin
            exit(x and (not (1 shl i)));
        end;

procedure main;
var i,j,tt,k,res,x,vt,d,c : longint;
        begin
             for tt := 1 to 1 shl n - 1 do
               for i := 1 to n do
                if (f[tt,i] < maxw) then
                 begin
                     for k := 1 to n do
                      if (lay(tt,k-1) = 0) then
                        begin
                            x := bat(tt,k-1);
                            if f[x,k] > f[tt,i] + length(s[k]) - a[i,k] then
                              begin
                                  f[x,k] := f[tt,i] + length(s[k]) - a[i,k];
                                  trace[x,k] := i;
                              end;
                        end;
                 end;
             res := maxlongint;
             for i := 1 to n do
              if f[1 shl n-1,i] < res then
                begin
                  res := f[1 shl n-1,i];
                  vt := i;
                end;
             dem := 0;
             tt := 1 shl n - 1;
              repeat
                  inc(dem);
                  kq[dem] := vt;
                  x := trace[tt,vt];
                  tt := tat(tt,vt-1);
                  vt := x;
              until tt = 0;
              s[0] := '';
             for i := dem downto 1 do
               begin
                   if i = dem then write(s[kq[i]]) else
                   begin
                       d := a[kq[i+1],kq[i]]+1;
                       c := length(s[kq[i]]);
                       for j := d to c do
                         write(s[kq[i]][j]);
                   end;

               end;
        end;

begin
      assign(input,'adn.in'); reset(input);
      assign(output,'adn.out'); rewrite(output);
      readln(n);
      for i := 1 to n do
       begin
         readln(s[i]);
         mm := max(mm,length(s[i]));
       end;
      init;
      main;
end.
