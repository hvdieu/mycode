{========================================}
const
        tfi     =       'brick.inp';
        tfo     =       'asd.out';
type
        arr1    =       array[1..6] of int64 ;
        arr2    =       array[1..6,1..6] of int64 ;
var
        fi,fo   :       text;
        n,m     :       longint;
        xo      :       int64;
        c       :       arr2;
        b       :       arr1;
{========================================}
procedure Nhap;
var
        i,j,k:longint;
begin
        Read(fi,xo,n,m);
end;
function Nhan(c:arr1;d:arr2):arr1;
var
        i,j:longint;
        cc:arr1;
begin
        For i := 1 to 6 do
          begin
                CC[i] := 0;
                For j := 1 to 6 do
                 CC[i] := (CC[i] + c[j] * d[j,i]) mod m;
          end;
        exit (cc);
end;
function Nhan2(c,d:arr2):arr2;
var
        i,j,k:longint;
        cc:arr2;
begin
        for i := 1 to 6 do
            For j := 1 to 6 do
              begin
                Cc[i,j] := 0;
                For k := 1 to 6 do
                  CC[i,j] := (CC[i,j] + C[i,k] * d[k,j]) mod m;
              end;
             exit(cc);
end;
{========================================}
function Lt(c:arr2;y:longint):arr2;
var
        d:arr2;
begin
        if y = 1 then exit(c);
        d := Lt(c,y div 2);
        lt := Nhan2(d,d);
        if y mod 2 = 1 then Lt := Nhan2(Lt,c);
end;
{========================================}
procedure init;
var
        i,j,k :longint;
begin
        for i := 1 to 6 do
          For j := 1 to 6 do c[i,j] := 0;
        c[1,1] := (2 * xo) mod m;
        c[2,1] := -1 ;
        c[1,2] := 1;
        c[3,3] := (4 * xo * xo) mod m;
        c[4,3] := 1;
        c[5,3] := ((-4 * xo) mod m);
        c[3,4] := 1;
        c[3,5] := (2 * xo) mod m ;
        c[5,5] := -1;
        For i := 1 to 5 do C[i,6] := C[i,3];
        C[6,6] := 1;
        b[1] := xo mod m;
        b[2] := 1;
        b[3] := (xo * xo) mod m;
        b[4] := 1;
        b[5] := xo mod m;
        b[6] := (1 + xo * xo) mod m ;
end;
{========================================}
{========================================}
procedure xuly;
var
        i,j,k:longint;
begin
        if n > 2 then
          begin
                c := Lt(c,n-2);
                b := Nhan(b,c);
          end;
end;
{========================================}
procedure inkq;
var
        i,j,k:longint;
begin
        writeln(fo,(b[6]+m) mod m);
end;

procedure honganh ;
var
        i,j,k:longint;
        sum,x,x_1,p:int64 ;
begin
        x_1 := 1;
        x := xo;
        sum := (1 + x * x) mod m;
        For i := 3 to n do
          begin
             p := (2 * xo * x - x_1) mod m;
             sum := (sum + p * p) mod m;
             x_1 := x;
             x := p;
          end;
        writeln(fo,sum);
        writeln(fo);
end ;
procedure make_honganh;
var
        i,j,K:longint;
begin
        assign(fi,tfi);rewrite(fi);
                  randomize;
                  n := random(10);
                  writeln(fi,n);
                  for i := 1 to n do
                   begin
                     k := 1000000000 ;
                     writeln(fi,random(k),' ',random(600000),' ',random(k));
                   end;
        close(fi);
end;
procedure process;
var
        i,j,K:longint;
begin
        Readln(fi,k);
        for i := 1 to k do
           begin
                  Nhap;
                  init;
                  xuly;
                  inkq;
                 // honganh;
           end ;
end;
{========================================}
begin
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
                        process;

        close(fi);
        close(fo);
end.
{========================================}


