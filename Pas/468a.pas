Uses math;
const
    inp = 'as.inp';
    out = 'asd.out';

Var
    n,i : longint;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
    readln(n);
    if (n<=4) then writeln('NO')
     else
      begin
         if n mod 2=1 then
           begin
               writeln('2 - 1 = 1');
               writeln('1 + 3 = 4');
               writeln('4 * 5 = 20');
               writeln('20 + 4 = 24');
               for i := 6 to n-1 do
                if i mod 2 = 0 then write(i+1,' - ',i,' = 1');
               if n <> 5 then for i := 1 to (n-6) div 2+1 do writeln('1 - 1 = 0');
           end else begin
               writeln('2 * 3 = 6');
               writeln('6 * 4 = 24 ');
               for i := 5 to n-1 do
                if i mod 2 = 1 then writeln(i+1,' - ',i,' = 1');
               if n <> 4 then for i := 1 to (n-5) div 2+1 do writeln('1 - 1 = 0');
           end;

      end;
end.