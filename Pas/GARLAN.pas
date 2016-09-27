{$H+}
Uses math;
Const   maxn = 16;
        maxw = 999999999;
Var     s       :       array [0..maxn] of string;
        a       :       array [0..maxn,0..maxn] of longint;
        f       :       array [0..65537,0..maxn] of longint;
        n,m,i,res     :       longint;

procedure init;
var i,j,k,dem : longint;
    st : string;
        begin
             st := '';
             for i := 1 to n do st := st + '0';
             s[0] := st;
             for i := 0 to m-1 do
               for j := i+1 to m do
                begin
                    dem := 0;
                    for k := 1 to n do
                     if s[i][k] <> s[j][k] then inc(dem);
                    a[i,j] := dem; a[j,i] := dem;
                end;
             for i := 0 to 1 shl m -1 do
              for j := 0 to m do
                f[i,j] := maxw;

             for i := 1 to m do
              f[1 shl (i-1),i] := a[0,i];
        end;

function bat(x,i : longint) : longint;
        begin
            exit(x or (1 shl i));
        end;

function lay(x,i : longint) : longint;
        begin
            exit( (x shr i) and 1 );
        end;


procedure main;
var i,j,tt,x,k : longint;
        begin
             for tt := 1 to 1 shl m - 1 do
               begin
                   for i := 1 to m do
                    if f[tt,i] < maxw then
                      begin
                          for k := 1 to m do
                           if (i <> k) and (lay(tt,k-1) = 0) then
                             begin
                                 x := bat(tt,k-1);
                                 f[x,k] := min(f[tt,i] + a[i,k],f[x,k]);
                             end;
                      end;
               end;

             res := maxlongint;
             for i := 1 to m do
              if f[1 shl m-1,i] < res then res := f[1 shl m-1,i];
              write(res);
        end;

begin
     assign(input,'GARLAN.INP'); reset(input);
     assign(output,'GARLAN.OUT'); rewrite(output);
     readln(n,m);
     for i := 1 to m do readln(s[i]);
     init;
     main;
end.
