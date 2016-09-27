Const   maxn = 19;
Var     a,b,s     :       string;
        f       :       array [1..maxn,0..1,0..1,-1..9,-1..9] of int64;
        sa,sb   :       int64;
        n       :       longint;

function tinh(i,ok1,ok2,cs1,cs2 : longint) : int64;
var j,x : longint;
    dem : int64;
        begin
             if (i = n+1) then exit(1);
             if f[i,ok1,ok2,cs1,cs2] <> -1 then exit(f[i,ok1,ok2,cs1,cs2]);
             val(s[i],x);
             dem := 0;
             if ok1 = 1 then
               begin
                    if ok2=0 then
                      begin
                          if 0 <> cs2 then
                          dem := dem + tinh(i+1,1,0,0,cs1);
                          for j := 1 to 9 do if j <> cs2 then
                           dem := dem + tinh(i+1,1,1,j,cs1);
                      end
                    else
                     for j := 0 to 9 do if j <> cs2 then
                      dem := dem + tinh(i+1,1,1,j,cs1);
               end
             else
               begin
                   if ok2 = 0 then
                     begin
                         for j := 0 to x do
                           begin
                               if (j < x) and (j = 0) and (0 <> cs2)
                                 then dem := dem + tinh(i+1,1,0,0,cs1)
                               else
                               if (j = x) and (j = 0) and (0 <> cs2 ) then
                                dem := dem + tinh(i+1,0,0,0,cs1) else
                               if (j < x) and (j <> 0) and (j <> cs2) then
                                dem := dem + tinh(i+1,1,1,j,cs1) else
                                if (j = x) and (j <> cs2) then
                                dem := dem + tinh(i+1,0,1,j,cs1);
                           end;
                     end
                   else
                     begin
                         for j := 0 to x do
                           begin
                                if (j < x) and (j <> cs2) then
                                 dem := dem + tinh(i+1,1,1,j,cs2)
                                else if (j = x) and (j <> cs2) then
                                 dem := dem + tinh(i+1,0,1,j,cs2);
                           end;
                     end;
               end;
             f[i,ok1,ok2,cs1,cs2] := dem;
             exit(dem);
        end;

procedure khoitao;
var i,j,k,t,h : longint;
        begin
            for i := 1 to 19 do
             for j := 0 to 1 do
              for k := 0 to 1 do
               for t := -1 to 9 do
                for h := -1 to 9 do f[i,j,k,t,h] := -1;
        end;


begin
     assign(input,'PFNUM.INP'); reset(input);
     assign(output,'PFNUM.OUT'); rewrite(output);
     readln(b);
     s := b;
     n := length(b);
     khoitao;
     sa := tinh(1,0,0,-1,-1);
end.