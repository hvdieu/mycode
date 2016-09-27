Const   inp = 'vikia.inp';
        out = 'vikia.out';
        maxn = 1001;
Var     fi,fo   :       text;
        f       :       array [0..maxn,0..maxn] of int64;
        free    :       array [0..maxn,0..maxn] of boolean;
        s,m,n,d :       longint;

procedure input;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,s,d,m,n);
        end;

function tinh(s,n : longint) : int64;
var i : longint;
    sum : int64;
        begin
            if s = 0 then exit(1);
            if n = 1 then exit(1);
            if free[s,n] then
            begin
            free[s,n] := false;
            if s - n >= 0 then
            f[s,n] := f[s,n] + tinh(s-n,n);
            for i := 1 to n do
               begin
                  if s - (n-i)*d >= 0 then
                  f[s,n] := f[s,n] + tinh(s-(n-i)*d,n-i);
               end;
            end;
            exit(f[s,n]);
        end;

procedure main;
var i,j,k :     longint;
        begin
            s := s - n*m;
            fillchar(free,sizeof(free),true);
            fillchar(f,sizeof(f),0);
            writeln(fo,tinh(s,n));
            close(fi); close(fo);
        end;


begin
     input;
     main;
end.