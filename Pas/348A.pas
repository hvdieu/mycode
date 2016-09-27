uses math;
Const   maxn = 100005;
Var     a       :       array [0..maxn] of longint;
        b       :       array [0..maxn] of int64;
        n,i,m       :       longint;
        res       :       int64;

function check(x : int64) : boolean;
var sum : int64;
        begin
          sum := 0;
          for i := 1 to n do b[i] := 0;
          for i := 1 to n do
           begin
               inc(b[i+1],x - a[i]);
               dec(b[n+1],x - a[i]);
               if i > 1 then
                 begin
                     inc(b[1],x-a[i]);
                     dec(b[i],x-a[i]);
                 end;
           end;
          for i := 1 to n do
           begin
               b[i] := b[i-1] + b[i];
               if b[i] < a[i] then exit(false);
           end;
          exit(true);
        end;

procedure find;
var d,c,mid : int64;
        begin
            d := m; c := 1 shl 40;
            while d <= c do
              begin
                  mid := (d+c) shr 1;
                  if check(mid) then
                    begin
                        res := mid;
                        c := mid-1;
                    end
                  else d := mid + 1;
              end;
        end;

begin
   //  assign(input,'mafia.inp'); reset(input);
   //  assign(output,'mafia.out'); rewrite(output);
     readln(n);
     for i := 1 to n do
      begin
        read(a[i]);
        m := max(a[i],m);
      end;
     find;
     write(res);
end.