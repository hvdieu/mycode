Uses math;
Const   maxn = 21;
        max1 = 1048578;
        maxw = 999999999;
Var     n,i,j,t,st     :       longint;
        a       :       array [1..maxn,1..maxn] of longint;
        f,g       :       array [0..max1] of int64;
        bit     :       array [0..max1] of longint;

function lay(x,i : longint) : longint;
        begin
             exit((x shr i) and 1);
        end;

function bat(x,i : longint) : longint;
        begin
             exit(x or (1 shl i));
        end;

procedure khoitao;
var i,j,dem : longint;
        begin
            for i := 0 to 1 shl 16-1 do
             begin
                 dem := 0;
                 for j := 0 to 16-1 do
                  if lay(i,j) = 1 then inc(dem);
                 bit[i] := dem;
             end;
        end;

procedure main;
var i,j,tt,k,x : longint;
        begin
             fillchar(f,sizeof(f),0);
             for tt := 0 to 1 shl n-1 do
               begin
                    k := bit[tt];
                    for i := 1 to n do
                     if lay(tt,i-1) = 0 then
                       begin
                           x := bat(tt,i-1);
                           if f[x] = f[tt] + a[i,k+1] then
                           else if f[x] < f[tt] + a[i,k+1] then
                                 f[x] := f[tt] + a[i,k+1];
                       end;
               end;
             writeln(f[1 shl n-1]);
        end;

begin
     // assign(input,'MAUGIAO.INP'); reset(input);
    //  assign(output,'MAUGIAO.OUT') ;rewrite(output);
      readln(t);
      khoitao;
      for st := 1 to t do
        begin
            write('Case ',st,': ');
            readln(n);
            for i := 1 to n do
              for j := 1 to n do read(a[i,j]);
            main;
        end;
end.