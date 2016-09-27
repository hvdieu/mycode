Const   inp = '';
        out = '';
Var     fi,fo   :       text;
        d       :       array [0..25000*30+1,'a'..'z'] of longint;
        min1,min2       :       array [0..25000*30+1] of string[31];
        s       :       string[31];
        count,t   :       longint;

procedure push(s : string);
var i,t : longint;
        begin
             t := 0;
             for i := length(s) downto 1 do
                if d[t,s[i]] = 0 then
                  begin
                       inc(count);
                       d[t,s[i]] := count;
                       t := count;
                       min1[t] := s;
                  end
                else
                  begin
                       t := d[t,s[i]];
                       if (s < min1[t]) or (length(min1[t])=0) then
                          begin
                              min2[t] := min1[t];
                              min1[t] := s;
                          end
                       else if (s < min2[t]) or (length(min2[t]) = 0) then
                              min2[t] := s;
                  end;
        end;

procedure input;
var i : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             repeat
               begin
                    readln(fi,s);
                    if s < 'a' then break;
                    push(s);
               end;
             until false;
        end;

procedure main;
var i,j : longint;
    min : string[31];
        begin
             while not eof(fi) do
                begin
                     readln(fi,s);
                     t := 0;
                     min := '';
                     for i := length(s) downto 1 do
                        begin
                            if d[t,s[i]] <> 0 then
                              begin
                                t := d[t,s[i]];
                                if (min1[t] <> s) and (length(min1[t]) > 0)
                                 then min := min1[t]
                                else
                                 if (min2[t] <> s) and (length(min2[t]) > 0)
                                   then min := min2[t];
                              end
                             else break;
                        end;
                     if min<> '' then writeln(fo,min);
                end;
             close(fi); close(fo);
        end;

begin
      input;
      main;
end.
