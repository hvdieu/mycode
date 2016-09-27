Program RF;
const fi            = 'RF.inp';
      fo            = 'RF.out';
      oo            = 2001;
type  arr           = array[1..oo] of int64;
      bignum        = ansistring;
var   f             : text;
      a,b           : arr;
      P,q           : ansistring;
     //P,Q            : int64;
      m,n           : longint;
(***************)
Procedure input;
var i:longint;
begin
  assign(F,fi);
  reset(F);
  Readln(f,m,n);
  For i:=1 to m do read(f,a[i]);
  For i:=1 to n do Read(f,b[i]);
  close(F);
end;
(***************)
Function NhanMin(a:BigNum;b:Longint):BigNum;
Var s:Bignum;
    i,t:Longint;
Begin
  s:=''; t:=0;
  For i:=length(a) downto 1 do
    Begin
      t:=t+(ord(a[i])-48)*b;
      s:=chr(t mod 10 + 48)+s;
      t:=t div 10;
    End;
  If t>0 then s:=chr(t+48)+s;
  While (length(s)>1) and (s[1]='0') do Delete(s,1,1);
  Exit(s);
End;
(***************)
Function Cong(a,b:BigNum):BigNum;
Var s:BigNum;
    i,t:Longint;
Begin
  While length(a)<length(b) do a:='0'+a;
  While length(b)<length(a) do b:='0'+b;
  s:=''; t:=0;
  For i:=length(a) downto 1 do
    Begin
      t:=t+ord(a[i])+ord(b[i])-96;
      s:=chr(t mod 10 + 48)+s;
      t:=t div 10;
    End;
  If t>0 then s:=chr(t+48)+s;
  Exit(s);
End;
(***************)
Function Nhan(a,b:BigNum):BigNum;
Var s,st:BigNum;
    i,j:Longint;
Begin
  s:='0';
  For i:=length(b) downto 1 do
    Begin
      st:=NhanMin(a,ord(b[i])-48);
      For j:=1 to length(b)-i do st:=st+'0';
      s:=Cong(s,st);
    End;
  While (length(s)>1) and (s[1]='0') do Delete(s,1,1);
  Exit(s);
End;
(***************)
Function UCLN(a,b:int64):int64;
begin
  If (b=0) then exit(a)
   else exit(ucln(b,a mod b));
end;
(***************)
Procedure process;
var j,i:longint;
  tg:int64;
  u:bignum;
begin
  For i:=1 to m do
    For j:=1 to n do
      begin
        tg:=UCLN(a[i],B[j]);
        a[i]:=a[i] div tg;
        b[j]:=b[j] div tg;
      end;
    P:='1';
    Q:='1';
    for i:=1 to m do
        begin
          str(a[i],u);
          P:=nhan(P,u);
        end;
    For i:=1 to n do
        begin
          str(b[i],u);
          Q:=nhan(Q,u);
        end;
end;
(***************)
PRocedure output;
begin
  assign(f,fo);
  rewrite(f);
  Process;
   WRiteln(f,P);
   WRiteln(f,Q);
  close(f);
end;
(***************)
begin
  input;
  output;
end.
