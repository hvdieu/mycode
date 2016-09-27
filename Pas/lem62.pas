//{$H+}
uses math ;
{========================================}
const
        tfi     =       'LEM6.INP';
        tfo     =       'LEM6.OUT';
        Nmax    =       1001;
        p       =       1000000000000000000 ;
type
        arr0    =       array[0..20] of int64 ;
        node    =       record
                len:longint;
                x:arr0;
                end;
        arr1    =       array[0..Nmax] of string ;
        arr2    =       array[0..Nmax] of node ;
var
        fi,fo   :       text;
        n,m,time     :       longint;
        f,l       :       arr2;
        a       : array[0..Nmax] of longint ;
        res     : node ;
{========================================}
procedure Nhap;
var
        i,j,k:longint;
begin
        Read(fi,n,m);
        for i := 1 to m do read(fi,a[i]);
end;
{========================================}
function Tong(a,b:string):string;
var
        i,j,k,nho,sa,sb:longint;
        res:string;
        ch:char;
begin
        while length(a)<length(b) do a:='0'+a;
        while length(b)<length(a) do b:='0'+b;
        nho:=0;
        res:=a;
        for i:=length(a) downto 1 do
          begin
              sa:=ord(a[i])-48;
              sb:=ord(b[i])-48;
              k:=sa+sb+nho;
              nho:=k div 10;
              k:=k mod 10;
              ch:=chr(k+48);
              res[i]:= ch;
          end;
        if nho>0 then res:=chr(nho+48)+res;
        exit(res);
end;
function Add(a,b:node):node;
var
        i,j:longint;
        k :int64 ;
begin
      //  fillchar(add.x,sizeof(add.x),0);
        add.len := max(a.len,b.len);
        k := 0 ;
        For i := 1 to add.len do
          begin
                K := k + (a.x[i]) * ord(i <= a.len) + b.x[i] * ord(i <= b.len) ;;
                Add.x[i]  := k mod p;
                K := k div p;
          end;
        if k <> 0 then
          begin
                inc(Add.len);
                Add.x[Add.len] := k;
          end;
      //  writeln(add.len);
end;
{========================================}
procedure init;
var
        i,j,k :longint;
begin
        for i := 1 to n do
         begin
          if i - a[1] + 1 > 0 then F[i].x[1] := 1 else
             f[i].x[1] := 0;
           F[i].len := 1;
         end;
end;
{========================================}
{========================================}
procedure xuly;
var
        i,j,k:longint;
begin
        L[0].x[1] := 0;
        L[0].len := 1;
        for i := 2 to m do
          begin
                For j := 1 to n do L[j] := Add(L[j-1] , F[j]);
                For j := 1 to n do
                 begin
                        k := j - a[i] - 1;
                        if k > 0 then F[j] := L[k] else
                          begin
                               F[j].len := 1 ;
                               F[j].x[1] := 0;
                          end;
                 end;
          end;
end;
{========================================}
procedure inkq;
var
        i,j,k:longint;
        s:string ;
begin
        For i := 1 to n do res := add(res,F[i]);
        For i := res.len downto 1 do
          begin
                 str(res.x[i],s);
                 if i <> res.len then
                 while length(s) < 18 do s := '0' + s ;
                 For j := 1 to  length(s)do write(fo,s[j]);
          end;
end;
procedure Make;
var
        i,j,k:longint;
begin
        assign(fi,tfi);rewrite(fi);
                 randomize;
                 n := 1000 ;
                 m := 250;//random(Nmax div 2);
                 writeln(fi,n,' ',m);
                 for i := 1 to m do write(fi,random(1)+1,' ');
        close(fi);
end;
{========================================}
begin
      //  make ;
      //  time := gettickcount ;
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
        Nhap;
        init;
        xuly;
        inkq;
       // writeln(((gettickcount-time)/1000):0:4);
        close(fi);
        close(fo);
end.
{========================================}



