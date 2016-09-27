const fi='nknumpre.inp';
      fo='nknumpre.out';
type max=1..30000;
var a,b,i : longint;
    d:longint;
function dao(x:longint):longint;
         var st,st2:string;
             c,n,i:longint;
         begin
             str(x,st);
             st2:='';
             for i:=length(st) downto 1 do st2:=st2+st[i];
             val(st2,n,c);
             dao:=n;
         end;
function ucln(a,b:longint):longint;
         var r:longint;
         begin
              while b<>0 do
                    begin
                         r:=a mod b;
                         a:=b;
                         b:=r;
                    end;
              ucln:=a;
         end;
begin
     assign(input,fi); reset(input);
     assign(output,fo); rewrite(output);
     read(a,b);
     d:=0;
     for i:=a to b do
     if ucln(i,dao(i))=1 then d:=d+1;
     write(d);
     readln;
end.
