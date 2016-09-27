{$H+}
Uses math;
Const   inp = 'vostr.inp';
        out = 'vostr.out';
        maxn = 1000001;
        p1 = 1000000007;
        p2 = 9999991;

Var     s1,s2   :       string;
        m,n,q,l,r,u,v     :       longint;
        h1,h2,mu   :       array [1..2,0..maxn] of int64;
        p       :  array [1..2] of int64;

{**************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
            p[1] := 1000000007; p[2] := 9999991;
            mu[1,0] := 1; mu[2,0] := 1;
            for i := 1 to max(m,n) do
             begin
              mu[1,i] := (int64(mu[1,i-1])*26) mod p1;
              mu[2,i] := (int64(mu[2,i-1])*26) mod p2;
             end;
            for i := 1 to m do
             begin
              h1[1,i] := (int64(h1[1,i-1])*26+ord(s1[i])-ord('a')+1) mod p1;
              h1[2,i] := (int64(h1[2,i-1])*26+ord(s1[i])-ord('a')+1) mod p2;
             end;
            for i := 1 to n do
             begin
              h2[1,i] := (int64(h2[1,i-1])*26+ord(s2[i])-ord('a')+1) mod p1;
              h2[2,i] := (int64(h2[2,i-1])*26+ord(s2[i])-ord('a')+1) mod p2;
             end;
        end;
{**************************************************************************}
function gethash1(k,i,j : longint) : longint;
        begin
            gethash1 := (h1[k,j]-(int64(h1[k,i-1])*mu[k,j-i+1]) mod p[k]+p[k]) mod p[k];
        end;
{**************************************************************************}
function gethash2(k,i,j : longint) : longint;
        begin
            gethash2 := (h2[k,j]-(int64(h2[k,i-1])*mu[k,j-i+1]) mod p[k]+p[k]) mod p[k];
        end;
{**************************************************************************}
function check(x : longint) : boolean;
        begin
            if (gethash1(1,l,l+x-1)=gethash2(1,u,u+x-1))
             and (gethash1(2,l,l+x-1)=gethash2(2,u,u+x-1)) then exit(true)
             else exit(false);
        end;
{**************************************************************************}
procedure main;
var d,c,mid,ans,l1,l2 : longint;
        begin
             l1 := r-l+1; l2 := v-u+1;
             d := 1; c := min(l1,l2);
             ans := 0;
             while d <= c do
              begin
                  mid := (d+c) shr 1;
                  if check(mid) then
                    begin
                        ans := mid;
                        d := mid+1;
                    end
                  else c := mid-1;
              end;
             if (l1=l2) and (ans=l1) then write('=')
              else if (ans=min(l1,l2)) and (l1<l2) then write('<')
               else if (s1[l+ans]<s2[u+ans]) then write('<')
                else write('>');
        end;
{**************************************************************************}
begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(m,n);
     readln(s1); readln(s2);
     khoitao;
     readln(q);
     while q > 0 do
      begin
          dec(q);
          readln(l,r,u,v);
          main;
      end;
end.
