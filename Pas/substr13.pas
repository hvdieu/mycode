Const   maxn = 211;
Var     f       :       array [1..maxn,0..maxn,0..maxn] of int64;
        next    :       array [1..2,0..maxn,'a'..'z'] of longint;
        pos     :       array ['a'..'z'] of longint;
        m,n,k,res   :       longint;
        a,b,s     :       string;

procedure khoitao(s : string;t : longint);
var i : longint;
    ch : char;
        begin
            fillchar(pos,sizeof(pos),0);
            for ch:= 'a' to 'z' do
                begin
                        next[t,length(s)+1,ch]:=length(s)+1;
                        pos[ch]:=length(s)+1;
                end;

            for i := length(s) downto 1 do
              begin
                  for ch := 'a' to 'z' do next[t,i,ch] := pos[ch];
                  pos[s[i]] := i;
              end;

            For ch := 'a' to 'z' do next[t,0,ch] := pos[ch];
        end;

procedure init;
var i,j,k : longint;
        begin
             for i := 1 to 210 do
              for j := 0 to 210 do
               for k := 0 to 210 do f[i,j,k] := -1;
        end;

function duyet(i,u,v : longint) : longint;
var res : longint;
    ch : char;
        begin
            if f[i,u,v] > -1 then exit(f[i,u,v]);
            if i > n then
              begin
                  if (u <= length(a)) and (v > length(b)) then
                    begin
                        f[i,u,v] := 1;
                        exit(1);
                    end
                  else
                    begin
                        f[i,u,v] := 0;
                        exit(0);
                    end;
              end;

            res := 0;
            for ch := 'a' to 'z' do
            begin
              res := res + duyet(i+1,next[1,u,ch],next[2,v,ch]);
              res := res mod k;
            end;
            f[i,u,v] := res;
            exit(res);
        end;

function check(s : string) : boolean;
var u,v,i : longint;
        begin
            u := 0; v := 0;
            for i := 1 to length(s) do
              begin
                  u := next[1,u,s[i]];
                  v := next[2,v,s[i]];
              end;
            if (u <= length(a)) and (v > length(b)) then exit(true)
             else exit(false);
        end;

procedure truyvet(i,u,v : longint);
var ch : char;
        begin
            if i > n then
              begin
                  res := res + f[i,u,v];
                  res := res mod k;
                  exit;
              end;
            for ch := 'a' to s[i] do
             if ch < s[i] then
              begin
                res := res + duyet(i+1,next[1,u,ch],next[2,u,ch]);
                res := res mod k;
              end
              else
               begin
                 res := res + duyet(i+1,next[1,u,ch],next[2,u,ch]);
                 res := res mod k;
                 exit;
               end;
        end;

begin
     assign(input,'substr13.inp'); reset(input);
     assign(output,'substr13.out'); rewrite(output);
     readln(m,n,k);
     readln(a); readln(b);
     khoitao(a,1); khoitao(b,2);
     init;
     duyet(1,0,0);
     while m > 0 do
       begin
           dec(m);
           readln(s);
           if check(s) then
            begin
              res := 0;
              truyvet(1,0,0);
              writeln(res);
            end
            else writeln(-1);
       end;
end.
