{$H+}
Const   maxn = 100001;
Var     a       :       array [1..maxn] of longint;
        n,i,m,x     :       longint;
        ch      : char;
        s,st,stt       :string;

procedure check(x,y : longint);
var i : longint;
        begin
            if x = y then exit;
            dec(m);
            repeat
                inc(m);
                a[m] := x;
                y := y-x;
                if y < x then break;
            until false;
            a[m] := x+y;
        end;

procedure main;
var i,j,x,y : longint;
        begin
             x := a[m-1]; y := a[m];
             inc(x); dec(y);
             if x > y then
               begin
                   dec(m); a[m] := x+y;
                   write(s,'=');
                   for i := 1 to m-1 do write(a[i],'+');
                   write(a[m]);
               end
             else
               begin
                   a[m-1] := x; a[m] := y;
                   check(x,y);
                   write(s,'=');
                   for i := 1 to m-1 do write(a[i],'+');
                   write(a[m]);
               end;
        end;

begin
      assign(input,'NEXT_M.INP'); reset(input);
      assign(output,'NEXT_M.OUT'); rewrite(output);
      read(stt); i := 2;
      s := stt[1]; ch := stt[2];
      stt := stt + '+';
       while ch <> '=' do
         begin
           s := s + ch;
           inc(i); ch := stt[i];
         end;
      while i <= length(stt)-1 do
        begin
           inc(i);
           st := stt[i];
           inc(i); ch := stt[i];
           while (ch <> '+') do
             begin
                 st := st+ch;
                 inc(i); ch := stt[i];
             end;
           val(st,x);
           inc(m); a[m] := x;
        end;
      if m = 1 then write('No solution')
       else main;
end.