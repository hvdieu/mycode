Const   inp = '';
        out = '';
        maxn = 10001;
        maxl = 10001;
        oo = 1000000;
        a : array ['A'..'Z'] of string[4] = ('.-','-...','-.-.','-..','.','..-.','--.','....','..','.---','-.-','.-..','--','-.','---','.--.','--.-','.-.','...','-','..-','...-','.--','-..-','-.--','--..');

Var     fi,fo   :       text;
        d       :       array [0..100000,0..1] of longint;
        f       :       array [0..100000] of longint;
        l       : array [1..maxl] of longint;
        t,n,count,ntest     :       longint;
        s       :       ansistring;
        st      :       string[11];

procedure push(st : string);
var i,j,k : longint;
    tmp : string;
        begin
             t := 0;
             while st[length(st)] = ' ' do delete(st,length(st),1);
             for i := 1 to length(st) do
              begin
                  tmp := a[st[i]];
                  for j := 1 to length(tmp) do
                  begin
                   if tmp[j] = '.' then k := 0
                    else k := 1;
                   if d[t,k] = 0 then
                    begin
                        inc(count);
                        d[t,k] := count;
                        t := count;
                    end
                   else t := d[t,k];
                  if (i = length(st)) and (j = length(tmp)) then inc(f[t]);
                  end;
              end;
        end;

procedure main;
var i,j,k: longint;
        begin
             fillchar(l,sizeof(l),0);
             while s[length(s)] = ' ' do delete(s,length(s),1);
             n := length(s);
             l[n+1] := 1;
             for i := n downto 1 do
               begin
                   t := 0;
                   for j := i to n do
                    begin
                       if s[j] = '.' then k :=0
                        else k := 1;
                       t := d[t,k];
                       if t = 0 then break;
                       l[i] := (l[i] + l[j+1]*f[t]) mod oo;
                    end;
               end;
             writeln(fo,l[1]);
        end;

procedure input;
var i : longint;
        begin
              assign(fi,inp); reset(fi);
              assign(fo,out); rewrite(fo);
              ntest := 1;
              while ntest > 0 do
              begin
              dec(ntest);
              readln(fi,s);
              readln(fi,n);
              count := 0;
              for i := 1 to n do
               begin
                   readln(fi,st);
                   push(st);
               end;
              main;
              end;
              close(fi); close(fo);
        end;

begin
     input;
end.