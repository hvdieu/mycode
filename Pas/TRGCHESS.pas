Const   maxn = 10;
        hma     :       array [1..8] of integer = (-2,-2,-1,-1,1,1,2,2);
        cma     :       array [1..8] of integer = (-1,1,-2,2,-2,2,-1,1);
        hvua : array [1..8] of integer = (-1,-1,-1,0,1,1,1,0);
        cvua : array [1..8] of integer = (-1,0,1,1,1,0,-1,-1);
Var     free    :       array [-1..maxn,-1..maxn] of boolean;
        a       :       array [1..maxn,1..maxn] of integer;
        ch      :       char;
        s       :       string;
        res     :       longint;

procedure tuong(i,j : longint);
var k : longint;
        begin
                                       for k := 1 to 7 do
                                         if (i+k <= 8) and (j+k <=8) and (a[i+k,j+k]=0) then free[i+k,j+k] := false
                                          else break;
                                       for k := 1 to 7 do
                                         if (i+k <= 8) and (j-k >=1) and (a[i+k,j-k]=0) then free[i+k,j-k] := false
                                          else break;
                                       for k := 1 to 7 do
                                         if (i-k>=1) and (j+k <= 8) and (a[i-k,j+k]=0) then free[i-k,j+k] := false
                                          else break;
                                       for k := 1 to 7 do
                                         if (i-k>=1) and (j-k>=1) and (a[i-k,j-k]=0) then free[i-k,j-k] := false
                                          else break;
        end;

procedure xe(i,j : longint);
var k : longint;
        begin

                                      for k := 1 to 7 do
                                        if (i+k <= 8) and (a[i+k,j] = 0) then free[i+k,j] := false
                                         else break;
                                       for k := 1 to 7 do
                                        if (i-k >=1) and (a[i-k,j] = 0) then free[i-k,j] := false
                                         else break;
                                        for k := 1 to 7 do
                                         if (j+k <= 8) and (a[i,j+k]=0) then free[i,j+k] := false
                                          else break;
                                        for k := 1 to 7 do
                                         if (j-k >= 1) and (a[i,j-k]=0) then free[i,j-k] := false
                                          else break;
        end;

procedure nhap;
var i,j,num,k,u,v,st : longint;
        begin
           //  assign(input,'chess.inp'); reset(input);
          //   assign(output,'chess.out'); rewrite(output);
             fillchar(free,sizeof(free),true);
             read(s);
             i := 1; j := 1;
             for st := 1 to length(s) do
               begin
                  if s[st] = '/' then
                    begin
                        inc(i);
                        j := 1;
                    end
                  else if s[st] in ['0'..'9'] then
                    begin
                       val(s[st],num);
                       j := j + num;
                    end
                  else begin
                           a[i,j] := 1;
                           inc(j);
                       end;
               end;
            i := 1; j := 1;
            for st := 1 to length(s) do
               begin
                   ch := s[st];
                   if ch = '/' then
                    begin
                        inc(i);
                        j := 1;
                    end
                   else begin
                            if ch in ['0'..'9'] then
                              begin
                                   val(ch,num);
                                   inc(j,num);
                              end
                            else
                              begin
                                  free[i,j] := false;
                                  a[i,j] := 1;
                                  if ch = 'P' then
                                    begin
                                        free[i-1,j-1] := false;
                                        free[i-1,j+1] := false;
                                    end;
                                  if ch = 'p' then
                                    begin
                                        free[i+1,j-1] := false;
                                        free[i+1,j+1] := false;
                                    end;
                                  if (ch = 'N') or (ch = 'n') then
                                    begin
                                        for k := 1 to 8 do
                                          free[i+hma[k],j+cma[k]] := false;
                                    end;
                                  if (ch = 'B') or (ch = 'b') then tuong(i,j);
                                  if (ch='R') or (ch='r') then xe(i,j);
                                  if (ch='Q') or (ch='q') then
                                    begin
                                        tuong(i,j);
                                        xe(i,j);
                                    end;
                                  if (ch='K') or (ch='k') then
                                   for k := 1 to 8 do free[i+hvua[k],j+cvua[k]] := false;
                                  inc(j);
                              end;
                        end;
               end;
        for i := 1 to 8 do
         for j := 1 to 8 do
           if free[i,j] then inc(res);
        write(res);
        end;

begin
     nhap;
end.