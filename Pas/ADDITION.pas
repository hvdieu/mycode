Const   inp = 'ADDITION.INP';
        out = 'ADDITION.OUT';

Var     fi,fo   :       text;
        dem     :       longint;
        kq,a      :   array [1..7] of int64;
        x       :   array [1..3] of integer;
        free    :   array [1..3] of boolean;

function add(x,y : int64) : string;
var i,t1,t2,c : longint;
    a,b,res,ch : string;
        begin
            str(x,a); str(y,b);
            while length(a) < length(b) do a := '0' + a;
            while length(b) < length(a) do b := '0' + b;
            res := '';
            for i := length(a) downto 1 do
              begin
                   val(a[i],t1);
                   val(b[i],t2);
                   c := t1 + t2;
                   str(c,ch);
                   res := ch + res;
              end;
            exit(res);
        end;

procedure xuly;
var i : longint;
    temp : string;
    k : int64;
    ok  :     boolean;
        begin
             temp := add(a[x[1]],a[x[2]]);
             ok := true;
             val(temp,k);
             temp := add(k,a[x[3]]);
             val(temp,k);
             for i := 1 to dem do
               if kq[i] = k then ok := false;
             if ok then
              begin
                  inc(dem);
                  kq[dem] := k;
              end;
        end;

procedure ql(i : integer);
var j : integer;
        begin
             for j := 1 to 3 do
              if free[j] then
               begin
                    free[j] := false;
                    x[i] := j;
                    if i = 3 then xuly
                     else ql(i+1);
                    free[j] := true;
               end;
        end;

procedure main;
var i,j,vt : longint;
    t : int64;
        begin
            fillchar(free,sizeof(free),true);
            ql(1);
            if dem = 1 then
              begin
                  writeln(fo,'NO');
                  writeln(fo,kq[1]);
              end
            else begin
                     writeln(fo,'YES');
                     j := 0;
                     repeat
                          inc(j);
                          t := 1 shl 62;
                          for i := 1 to dem do
                           if t > kq[i] then
                            begin
                                 t := kq[i];
                                 vt := i;
                            end;
                          writeln(fo,t);
                          kq[vt] := 1 shl 62;
                     until j = dem;
                 end;
            close(fi); close(fo);
        end;



begin
     assign(fi,inp); reset(fi);
     assign(fo,out); rewrite(fo);
     readln(fi,a[1],a[2],a[3]);
     main;
end.