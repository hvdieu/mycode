Const   inp = 'bflowers.inp';
        out = 'bflowers.out';
        maxn = 1001;
Var     fi,fo   :       text;
        n,l,best,sum,dem,time     :       longint;
        free    :       array [0..maxn] of boolean;
        x       :       array [0..maxn] of longint;

procedure input;
var i : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,n,l);
             for i := 1 to n do readln(fi,x[i]);
             best := maxlongint;
             fillchar(free,sizeof(free),true);
             sum := 0;
             time := 0;
             x[0] := l;
        end;

procedure try(i : longint);
var j : longint;
        begin
            for j := 1 to n do
             if free[j] then
               begin
                    free[j] := false;
                    inc(dem);
                    inc(time,abs(x[i]-x[j]));
                    sum := sum + time;
                    if dem = n then
                     begin
                        if sum < best then best := sum;
                     end
                    else
                    if sum + time*(n-dem) < best then try(j);
                    sum := sum - time;
                    free[j] := true;
                    dec(dem);
                    time := time - abs(x[i]-x[j]);
               end;
        end;

procedure make;
var i : longint;
        begin
             assign(fo,inp); rewrite(fo);
             writeln(fo,20,' ',1856);
             for i := 1 to 100 do writeln(fo,random(5000));
             close(fo);
        end;

begin
     input;
     if n <= 18 then try(0);
     writeln(fo,best);
     close(fi); close(fo);
    // make;
end.