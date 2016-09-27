{$n+}  uses crt;  const  fi=’fibo.inp’';  go=’fibo.out’;   
var S,R,S1,S2,X,SA,SB,YA,YB :string;  a :array[1..200] of extended;  n,dem :integer;  f,g :text;   
procedure Openf;  begin  assign(f,fi);  reset(f);  assign(g,go);  rewrite(g);  end;   
procedure Closef;  begin  close(f);  close(g);  end;   
procedure Swap(var A,B:string);  var T:string;  begin  T:=A;  A:=B;  B:=T;  end;  
 procedure Solve;  begin  readln(f,S);  readln(f,n);  S1:='b';S2:='á;  dem:=2;  while length(S1) begin  inc(dem);  R:=S2;  S2:=S2+S1;  S1:=R;  end;  if pos(S,S1)<>0 then a[dem-1]:=1;  if pos(S,S2)<>0 then a[dem]:=1;  end;   
procedure Main;  var i,k:integer;  begin  k :=length(S);  SA:=copy(S1,1,k-1);YA:=copy(S1,length(S1)-k+2,k-1);  SB:=copy(S2,1,k-1);YB:=copy(S2,length(S2)-k+2,k-1);  for i:=dem+1 to n do  begin  a[i]:=a[i-1]+a[i-2];  X:=SB+SA;  if pos(S,X)<>0 then a[i]:=a[i]+1;  SA:=YB;  Swap(SB,YA);  end;  writeln(g,a[n]:0:0);  end;   
begin  clrscr;  Openf;  Solve;  Main;  Closef;  end.  