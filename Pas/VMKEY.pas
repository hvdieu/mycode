{$MODE OBJFPC}
Const   inp = '';
        out = '';
Var     fi,fo : text;
        s,st       :       ansistring;
        a       :       array [0..9,0..9] of integer;
        free    :       array [0..9] of boolean;
        x,vt    :       array [0..9] of integer;
        f       :       array [0..9,0..9] of longint;
        kq,best      :       int64;

Procedure input;
        BEGIN
              s := '';
              assign(fi,inp); reset(fi);
              While not eof(fi) do
                BEGIN
                     readln(fi,st);
                     s := s+st;
                END;
              close(fi);
        END;

Procedure init;
Var i,j,u,v,x1,x2 : integer;
        BEGIN
               for i := 0 to 9 do
                  For j := 0 to 9 do
                     if i = j then a[i,j] := 0
                        else
                           BEGIN
                               u := abs(i div 3 - j div 3);
                               v := abs(i mod 3 - j mod 3);
                               a[i,j] := u+v;
                           END;
               fillchar(f,sizeof(f),0);
               For i := 1 to length(s) - 1 do
                  BEGIN
                       val(s[i],x1);
                       val(s[i+1],x2);
                       inc(f[x1,x2]);
                       inc(f[x2,x1]);
                  END;

               fillchar(free,sizeof(free),true);
               best := maxlongint;
               kq :=0;
        END;

Procedure main;
Var u,v : integer;
        BEGIN
              kq := 0;
              For u := 0 to 9 do
                For v := 0 to u-1 do
                  kq := kq + f[v,u] * a[x[v],x[u]];
              if kq < best then best := kq;

        END;

Procedure ql(i : integer);
var j,k,x1,x2 : integer;
    gt  :       longint;
        BEGIN
              For j := 0 to 9 do
                 if free[j] then
                     BEGIN
                           free[j] := false;
                           x[i] := j;
                           if i=9 then main
                           else ql(i+1);
                           free[j] := true;
                     END;
        END;

Procedure output;
        BEGIN
              assign(fo,out); rewrite(fo);
              write(fo,best);
              close(fo);
        END;

BEGIN
     input;
     init;
     ql(0);
     output;
END.

