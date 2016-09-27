Uses crt;
Const   inp = 'jednakost.out.10';
        out = 'asd.out';

Var     dem : longint;
        ch : char;

begin
     clrscr;
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     while not eoln(input) do
       begin
           read(ch);
           if ch = '+' then inc(dem);
       end;
     readln(input);
     writeln(dem);
     readln;
end.
