Var     n,s,t,x,left,right,res       :       longint;
        free    :       array [0..33333333] of boolean;
        queue,d   :       array [1..70000] of longint;
        a,b       :       array [1..8] of longint;

procedure bfs;
var i,tt,j,l,u,vt : longint;
        begin
            fillchar(free,sizeof(free),true);
            right := 1; queue[1] := s; free[s] := false;
            if s = t then res := 0
             else
               begin
                    while left < right do
                      begin
                          inc(left); u := queue[left];
                          for i := n downto 1 do
                            begin
                                a[i] := u mod 10;
                                u := u div 10;
                            end;
                          for l := 1 to 8 do
                            for vt := 1 to n-l+1 do
                              begin
                                  tt := 0;
                                  for j := 1 to vt-1 do tt := tt*10+a[j];
                                  for j := vt to vt+l-1 do
                                    begin
                                        x := a[j]+1;
                                        if x = 4 then x := 0;
                                        tt := tt*10+x;
                                    end;
                                  for j := vt+l to n do tt := tt*10+a[j];
                                  if free[tt] then
                                    begin
                                        free[tt] := false;
                                        inc(right); queue[right] := tt;
                                        d[right] := d[left]+1;
                                        if tt = t then
                                          begin
                                              res := d[right];
                                              exit;
                                          end;
                                    end;
                              end;
                      end;
               end;
        end;

procedure sub1;
var i,tt,j,l : longint;
        begin
            for i := 1 to n do
              begin
                  read(x); s := s*10+x;
              end;
            for i := 1 to n do
              begin
                  read(x); t := t*10+x;
              end;
            bfs;
            writeln(res);
        end;

begin
     assign(input,'TETRIS.INP'); reset(input);
     assign(output,'TETRIS.OUT'); rewrite(output);
     readln(n);
     if n <= 8 then sub1;
end.
