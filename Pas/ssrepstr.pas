{$H+}
Const   inp = 'ssrepstr.inp';
        out = 'ssrepstr.out';
        maxn = 1000001;
Var     fi,fo   :       text;
        hash,pow    :       array [0..maxn] of int64;
        n,l,res  :   longint;
        base    :       int64;
        s       :   string;

procedure input;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,n);
             readln(fi,s);
        end;

function gethash(i,j : longint) : int64;
        begin
             gethash := (hash[j] - hash[i-1]*pow[j-i+1] + base*base) mod base;
        end;

procedure main;
var i,st,temp,d,c : longint;
        begin
             pow[0] := 1; base := 1000000003;
             hash[0] := 0;
             for i := 1 to n do pow[i] := (pow[i-1]*26) mod base;
             for i := 1 to n do
              hash[i] := (hash[i-1] * 26 + ord(s[i]) - ord('a') ) mod base;
                  for l := 1 to n do
                    begin
                        if l = n then
                          begin
                               res := n;
                               exit;
                          end;
                        st := gethash(1,l);
                        d := l+1;
                        c := l+l;
                        if c > n then
                          begin
                               c := n;
                               st := gethash(1,1+c-d);
                          end;
                        repeat
                             temp := gethash(d,c);
                             if temp = st then
                               begin
                                   if c = n then
                                      begin
                                        res := l;
                                        exit;
                                      end;
                                   d := d+l;
                                   c := c+l;
                                   if c > n then
                                     begin
                                          c := n;
                                          st := gethash(1,1+c-d);
                                     end;
                               end
                             else break;
                        until false;
                    end;
        end;

procedure output;
        begin
             writeln(fo,res);
             close(fi); close(fo);
        end;

begin
      input;
      main;
      output;
end.