{$H+}
Var     s       :       string;
        n,d,c,mid,k,i,res       :       longint;
        dem,t,kq     :       array ['a'..'z'] of integer;
        ch      :    char;

function check(x : longint) : boolean;
var i,tg,tt : longint;
    ch : char;
        begin
            tg := 0;
            fillchar(t,sizeof(t),0);
            for ch := 'a' to 'z' do
              begin
                  if dem[ch] > 0 then
                    begin
                        tt := dem[ch] div x;
                        if dem[ch] mod x <> 0 then inc(tt);
                        t[ch] := tt;
                        inc(tg,tt);
                    end;
              end;
            if tg <= n then exit(true)
             else exit(false);
        end;

begin
    // assign(input,'asd.inp'); reset(input);
    // assign(output,'asd.out'); rewrite(output);
     readln(s);
     read(n);
     for i := 1 to length(s) do
       begin
         if dem[s[i]] = 0 then inc(k);
         inc(dem[s[i]]);
       end;
     if n < k then write(-1)
      else
        begin
             d := 1; c := 1000;
             while d <= c do
               begin
                   mid := (d+c) shr 1;
                   if check(mid) then
                     begin
                         kq := t;
                         res := mid;
                         c := mid - 1
                     end
                   else d := mid + 1;
               end;
             writeln(res);
             k := 0;
               for ch := 'a' to 'z' do
                 begin
                    for i := 1 to kq[ch] do
                      begin
                       write(ch);
                       inc(k);
                      end;
                 end;
               for i := 1 to n-k do write('a');
        end;
end.