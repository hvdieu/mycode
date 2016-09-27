Const   maxn = 101;
Var     n,i,j,p       :       longint;
        res     :   array [1..maxn] of longint;
        hang,cot  :       array [1..maxn] of boolean;
        c1,c2     :       array [-maxn..2*maxn] of boolean;
        ok      :       boolean;

procedure khoitao;
        begin
            fillchar(hang,sizeof(hang),true);
            fillchar(cot,sizeof(cot),true);
            fillchar(c1,sizeof(c1),true);
            fillchar(c2,sizeof(c2),true);
            fillchar(res,sizeof(res),0);
            ok := false;
        end;

procedure print;
var i : longint;
        begin
             for i := 1 to n do write(res[i],' ');
             writeln;
        end;

procedure ql(i : longint);
var j,vt,temp,k,dem : longint;
        begin
             if ok then exit;
             if i > p then
               begin
                   print;
                   ok := true;
                   exit;
               end;
             temp := maxlongint; vt := 0;
             for j := 1 to n do
              if hang[j] then
               begin
                   dem := 0;
                   for k := 1 to n do
                    if cot[k] and c1[j+k] and c2[j-k] then inc(dem);
                   if dem < temp then
                     begin
                         temp := dem;
                         vt := j;
                     end;
               end;
             if temp = 0 then exit;
             for j := 1 to n do
              if cot[j] and c1[vt+j] and c2[vt-j] then
                begin
                    hang[vt] := false;
                    res[vt] := j;
                    cot[j] := false;
                    c1[vt+j] := false;
                    c2[vt-j] := false;
                    ql(i+1);
                    hang[vt] := true;
                    cot[j] := true;
                    c1[vt+j] := true;
                    c2[vt-j] := true;
                end;
        end;

begin
      assign(input,'NQUEEN.INP'); reset(input);
      assign(output,'NQUEEN.OUT'); rewrite(output);
      while not seekeof(input) do
        begin
            read(n);
            khoitao;
            p := 0;
            for i := 1 to n do
              begin
                  read(j);
                  if j <> 0 then
                    begin
                        hang[i] := false;
                        cot[j] := false;
                        c1[i+j] := false;
                        c2[i-j] := false;
                    end
                  else inc(p);
                  res[i] := j;
              end;
           ql(1);
        end;
end.
