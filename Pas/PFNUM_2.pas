Const   maxn = 9;
Var     f       :       array [1..19,0..1,0..1,-1..9,-1..9] of int64;
        a,b,res     :       int64;
        n       :longint;
        s   :       string;

procedure khoitao;
var i,j,k,t,h : longint;
        begin
            for i := 1 to 19 do
             for j := 0 to 1 do
              for k := 0 to 1 do
               for t := -1 to 9 do
                for h := -1 to 9 do f[i,j,k,t,h] := -1;
        end;

function tinh(i,ok1,ok2,cs1,cs2 : longint) : int64;
var j,x : longint;
    res : int64;
        begin
             if f[i,ok1,ok2,cs1,cs2] > -1 then exit(f[i,ok1,ok2,cs1,cs2]);
             if i > n then
               begin
                   f[i,ok1,ok2,cs1,cs2] := 1;
                   exit(1);
               end;
             res := 0; val(s[i],x);
             if ok1 = 0 then
               begin
                   if ok2 = 0 then
                     begin
                         res := res + tinh(i+1,1,0,-1,-1);
                         for j := 1 to x-1 do
                          if (j <> cs1) and (j <> cs2) then
                           res := res + tinh(i+1,1,1,cs2,j);
                         if (x <> cs1) and (x <> cs2) then
                           res := res + tinh(i+1,0,1,cs2,x);
                     end
                   else
                      begin
                          for j := 0 to x-1 do
                           if (j <> cs1) and (j <> cs2) then
                            res := res + tinh(i+1,1,1,cs2,j);
                          if (x <> cs1) and (x <> cs2) then
                           res := res + tinh(i+1,0,1,cs2,x);
                      end;
               end
             else begin
                      if ok2 = 0 then
                        begin
                            res := res + tinh(i+1,1,0,-1,-1);
                            for j := 1 to 9 do
                             if (j <> cs1) and (j <> cs2) then
                              res := res + tinh(i+1,1,1,cs2,j);
                        end
                      else begin
                              for j := 0 to 9 do
                               if (j <> cs1) and (j <> cs2) then
                                res := res + tinh(i+1,1,1,cs2,j);
                           end;
                  end;
             f[i,ok1,ok2,cs1,cs2] := res;
             exit(res);
        end;

begin
     assign(input,'PFNUM.INP'); reset(input);
     assign(output,'PFNUM.OUT'); rewrite(output);
     readln(a,b);
     str(b,s); n := length(s);
     khoitao;
     res := tinh(1,0,0,-1,-1);
     str(a-1,s); n := length(s);
     khoitao;
     res := res - tinh(1,0,0,-1,-1);
     writeln(res);
end.