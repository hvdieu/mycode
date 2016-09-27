{$H+}
Const   inp = 'writing.inp';
        out = 'writing.out';
Var     fi,fo   :       text;
        m,n,res,t     :       longint;
        w,s     :       string;
        c       :       array [1..2,'A'..'z'] of longint;

procedure input;
var i,j : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,m,n);
             readln(fi,w); readln(fi,s);
        end;

procedure main;
var i,j : longint;
    ch  : char;
        begin
             fillchar(c,sizeof(c),0);
             for i := 1 to m do
              begin
               inc(c[1,w[i]]);
               inc(c[2,s[i]]);
              end;
             for ch := 'a' to 'z' do
              if c[2,ch] - c[1,ch] <> 0 then inc(t);
             for ch := 'A' to 'Z' do
              if c[2,ch] - c[1,ch] <> 0 then inc(t);
             if t = 0 then inc(res);
             for i := m+1 to n do
               begin
                   dec(c[2,s[i-m]]);
                   if c[2,s[i-m]] - c[1,s[i-m]] = 0 then dec(t)
                    else if c[2,s[i-m]] - c[1,s[i-m]] = -1 then inc(t);
                   inc(c[2,s[i]]);
                   if c[2,s[i]] - c[1,s[i]] = 0 then dec(t)
                    else if c[2,s[i]] - c[1,s[i]] = 1 then inc(t);
                   if t = 0 then inc(res);
               end;
             writeln(fo,res);
             close(fi); close(fo);
        end;

begin
     input;
     main;
end.