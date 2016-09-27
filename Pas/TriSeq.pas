Const   maxn = 20;
Var     n,i,j,k,h       :       longint;
        t,res       :       int64;
        f       :       array [1..maxn,0..maxn,0..maxn,0..maxn] of int64;
        a       :       array [1..maxn] of longint;

procedure init;
var i,j,k,t : longint;

        begin
            for i := 1 to n+1 do
             for j := 0 to n+1 do
              for k := 0 to n+1 do
               for t := 0 to n do
                f[i,j,k,t] := -1;
        end;

function tinh(i,min1,min2,max : longint) : int64;
var j,l1,l2,l3 : longint;
    dem : int64;
        begin
              if f[i,min1,min2,max] <> -1 then exit(f[i,min1,min2,max]);
              if min1 + min2 <= max then
                begin
                     f[i,min1,min2,max] := 0;
                     exit(0);
                end;
              if i > n then
                begin
                    if min1 + min2 > max then
                      begin
                          f[i,min1,min2,max] := 1;
                          exit(1);
                      end
                     else
                      begin
                          f[i,min1,min2,maxn] := 0;
                          exit(0);
                      end;
                end;
              dem := 0;
              for j := 1 to n do
                begin
                    l1 := min1; l2 := min2; l3 := max;
                    if j > max then max := j;
                    if j < min1 then
                      begin
                          min2 := min1; min1 := j;
                      end
                    else if (j >= min1) and (j < min2) then min2 := j;
                    dem := dem + tinh(i+1,min1,min2,max);
                    min1 := l1; min2 := l2; max := l3;
                end;
              f[i,min1,min2,max] := dem;
              exit(dem);
        end;

procedure truyvet(i,min1,min2,max : longint);
var j,l1,l2,l3 : longint;
        begin
              for j := 1 to n do
                begin
                    l1 := min1; l2 := min2; l3 := max;
                    if j > max then max := j;
                    if j < min1 then
                      begin
                          min2 := min1; min1 := j;
                      end
                    else if (j >= min1) and (j < min2) then min2 := j;
                    if f[i+1,min1,min2,max] < t then t := t - f[i+1,min1,min2,max]
                     else
                      begin
                          a[i] := j;
                          truyvet(i+1,min1,min2,max);
                          exit;
                      end;
                    min1 := l1; min2 := l2; max := l3;
                end;
        end;

procedure trace(i,min1,min2,max : longint);
var j,l1,l2,l3 : longint;
        begin
             if i > n then
               begin
                   t := t + f[i,min1,min2,max];
                   exit;
               end;
             for j := 1 to a[i] do
               begin
                    l1 := min1; l2 := min2; l3 := max;
                    if j > max then max := j;
                    if j < min1 then
                      begin
                          min2 := min1; min1 := j;
                      end
                    else if (j >= min1) and (j < min2) then min2 := j;
                    begin
                    if j < a[i] then t := t + f[i+1,min1,min2,max]
                     else
                      begin
                        trace(i+1,min1,min2,max);
                        exit;
                      end;
                    end;
                    min1 := l1; min2 := l2; max := l3;
               end;

        end;

begin
    assign(input,'triseq.inp'); reset(input);
    assign(output,'triseq.out'); rewrite(output);
    readln(n);
    init;
    res := tinh(1,n+1,n+1,0);
    for i := 1 to n+1 do
     for j := 0 to n+1 do
      for k := 0 to n+1 do
       for h := 0 to n do
        if f[i,j,k,h] = -1 then f[i,j,k,h] := 0;
    writeln(res);
    readln(t);
    truyvet(1,n+1,n+1,0);
    for i := 1 to n do write(a[i],' ');
    writeln;
    for i := 1 to n do read(a[i]);
    t := 0;
    trace(1,n+1,n+1,0);
    write(t);
end.