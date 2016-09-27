Const   maxn = 21;
Var     gt      :       array [0..maxn] of qword;
        n,t,st,m,i       :       longint;
        dem     :       array ['a'..'z'] of longint;
        s,res       :       string;
        ch      :       char;
        bound,con       :       qword;

procedure khoitao;
var i : longint;
        begin
            gt[0] := 1;
            for i := 1 to 20 do gt[i] := gt[i-1]*i;
        end;

procedure main;
var i,j : longint;
    ch,c1 : char;
        begin
            m := length(s);
            bound := gt[m];
            fillchar(dem,sizeof(dem),0);
            for i := 1 to m do inc(dem[s[i]]);
            for ch := 'a' to 'z' do bound := bound div gt[dem[ch]];
            if n > bound then
              begin
                  writeln('Impossible');
                  exit;
              end;
            res := '';
            for i := 1 to m do
              begin
                  for ch := 'a' to 'z' do
                   if dem[ch] > 0 then
                     begin
                         con := gt[m-i];
                         for c1 := 'a' to 'z' do
                          if c1 = ch then con := con div gt[dem[c1]-1]
                           else con := con div gt[dem[c1]];
                         if n > con then n := n-con
                          else
                            begin
                                res := res + ch;
                                dec(dem[ch]);
                                break;
                            end;
                     end;
              end;

            for ch := 'a' to 'z' do if dem[ch] > 0 then res := res + ch;
            writeln(res);
        end;

begin
      assign(input,'1060.inp'); reset(input);
      assign(output,'1060.out'); rewrite(output);
      readln(t);
      khoitao;
      for st := 1 to t do
        begin
            write('Case ',st,': ');
            s := '';
            read(ch);
            repeat
               s := s + ch;
               read(ch);
            until ch = ' ';
            readln(n);
            main;
        end;
end.