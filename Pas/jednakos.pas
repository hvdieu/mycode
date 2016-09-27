{$H+}
uses math;
Const   inp = 'JEDNAKOST.IN.8';
        out = 'JEDNAKOS.OUT';
        maxn = 1001;
        maxs = 5001;
        maxw = 999999999;

Var     n,sum,i       :       longint;
        s       :       string;
        f       :       array [0..maxn,0..maxs] of longint;
        mu      :       array [1..4] of longint;

{***************************************************************************}
procedure nhap;
var i,dem : longint;
    ch,prev : char;
        begin
            assign(input,inp); reset(input);
            assign(output,out); rewrite(output);
            read(ch); dem := 0; s := '';
            while ch <> '=' do
              begin
                  if ch = '0' then inc(dem)
                   else dem := 0;
                  if (ch <> '0') or ((ch='0') and (dem <= 3)) then s := s + ch;
                  prev := ch; read(ch);
              end;
            if (prev = '0') and (dem > 3) then  s:= s + '0';
            read(sum); n := length(s);
        end;
{***************************************************************************}
procedure main; inline;
var i,j,num,k,t,st : longint;
        begin
             for i := 1 to n do
              for j := 0 to sum do f[i,j] := maxw;
             f[0,0] := -1;
             for i := 1 to n do
               begin
                 for t := 0 to sum do
                    for j := i downto max(1,i-3) do
                      begin
                          num := 0;
                          for k := j to i do
                            begin
                                val(s[k],st);
                                num := num*10+st;
                            end;
                          if (num <= t) and (num <> 0) then
                           f[i,t] := min(f[i,t],f[j-1,t-num]+1)
                           else if (num <= t) and (num = 0) then
                            f[i,t] := min(f[i,t],f[j-1,t]);
                      end;
               end;
             i := n;
             while s[i] = '0' do dec(i);
             if (i < n) and (f[i,sum] = f[n,sum]) then inc(f[n,sum]);
             writeln(f[n,sum]);
        end;
{****************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
            for i := 1 to n do
              for j := 0 to sum do f[i,j] := -1;

            mu[1] := 1; mu[2] := 10; mu[3] := 100; mu[4] := 1000;
        end;
{****************************************************************************}
function tinh(i,sum : longint) : longint;
var j,count,num,x,res : longint;
        begin
            if (i = 0) then
             if sum = 0 then exit(-1) else exit(maxw);
            if f[i,sum] <> -1 then exit(f[i,sum]);
            count := 0; num := 0; res := maxw;
            for j := i downto max(1,i-3) do
              begin
                  inc(count); val(s[j],x);
                  num := mu[count]*x+num;
                  if num <= sum then
                   if num = 0 then res := min(res,tinh(j-1,sum))
                    else res := min(res,tinh(j-1,sum-num)+1);
              end;
            f[i,sum] := res;
            exit(res);
        end;
{****************************************************************************}
begin
     nhap;
     khoitao;
    // main;
     tinh(n,sum);
     i := n;
     while (s[i] = '0') and (f[i,sum] = f[n,sum]) do dec(i);
     if (i < n) then inc(f[n,sum]);
     write(f[n,sum]);
end.



