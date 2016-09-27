Const   inp = 'equation.inp';
        out = 'equation.out';

Var     fi,fo   :       text;
        a,b,c,d,v,ts,ms,r1,r2       :       int64;


function ucln(a,b : int64) : int64;
        begin
             if b = 0 then exit(a)
               else exit(ucln(b,a mod b));
        end;

procedure main;
        begin
              ms := a - v*c;
              ts := v*d - b;
              if ms = 0 then
               begin
                    if ts <> 0 then writeln(fo,'NONE')
                     else writeln(fo,'MULTIPLE');
                    exit;
               end;
             write(fo,'X = ');
             r1 := ucln(abs(ts),abs(ms));
             if ts*ms < 0 then
               begin
                   writeln(fo,'-',abs(ts) div r1,'/',abs(ms) div r1);
                   exit;
               end
             else begin
                      writeln(fo,abs(ts) div r1,'/',abs(ms) div r1);
                      exit;
                  end;
        end;

procedure input;
var i : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             While not eof(fi) do
               begin
                   read(fi,a,b,c,d,v);
                   main;
               end;
             close(fi); close(fo);
        end;

begin
     input;
end.