Const   inp = 'scode.in';
        out = 'scode.out';
        maxn = 101;

Var     s       :       string;
        st      :       array [1..maxn*maxn] of string;
        f       :       array [1..maxn*maxn] of int64;
        n,top       :       longint;

{***************************************************************************}
function ss(a,b : string;i,j,d : integer) : boolean;
var k : integer;
  begin
      for k := 0 to d-1 do
       if a[i+k] <> b[j+k] then exit(false);
      exit(true);
  end;
{***************************************************************************}
function tinh(s : string) : int64;
var i,j,n,mid : longint;
    a,b : string;
    res : int64;
  begin
      n := length(s);
      if (n=1) or (n mod 2=0) then exit(1);
      for i := 1 to top do
       if st[i]=s then exit(f[i]);
      a := ''; b := ''; mid := n div 2;
      for i := 1 to mid do a := a + s[i];
      for i := mid+1 to n do b := b+s[i];
      res := 1;
      if ss(a,b,1,1,mid) then res := res+tinh(b);
      if ss(a,b,1,2,mid) then res := res+tinh(b);
      a := ''; b := '';
      for i := 1 to mid+1 do a:=a+s[i];
      for i := mid+2 to n do b := b + s[i];
      if ss(a,b,1,1,mid) then res := res+tinh(a);
      if ss(a,b,2,1,mid) then res := res+tinh(a);
      inc(top); st[top] := s; f[top] := res;
      exit(res);
  end;
{***************************************************************************}
begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(s); n := length(s);
     if (n=1) or (n mod 2=0) then writeln(0)
     else writeln(tinh(s)-1);
end.
