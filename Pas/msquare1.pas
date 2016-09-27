program msquare;
type
        arr     =       array[1..8] of integer;
const
        fi      =       'msquare.in3';
        fo      =       'msquare.out';
        maxn    =       1000;
var
        f:text;
        a:array[1..maxn] of arr;
        b:array[1..maxn] of integer;
        c:array[1..maxn] of char;
        kq:arr;
        i,l,r:integer;
{---------------------}
procedure nhap;
  begin
    assign(f,fi);
    reset(f);
    for i:=1 to 8 do read(f,kq[i]);
    for i:=1 to 4 do a[1][i]:=i;
    for i:=5 to 8 do a[1][i]:=9-(i-4);
    close(f);
  end;
{---------------------}
function ss(a:arr):boolean;
  begin
    ss:=true;
    for i:=1 to 7 do
      begin
        if a[i]<>kq[i] then ss:=false;
        exit;
      end;
  end;
{---------------------}
function tha(ma:arr):arr;
  begin
    for i:=1 to 4 do tha[i]:=ma[i+4];
    for i:=5 to 8 do tha[i]:=ma[i-4];
  end;
{---------------------}
function thb(ma:arr):arr;
  begin
    for i:=1 to 3 do
      begin
        thb[i+1]:=ma[i];
        thb[i+5]:=ma[i+1];
      end;
    thb[1]:=ma[4];
    thb[5]:=ma[8];
  end;
{---------------------}
function thc(ma:arr):arr;
  begin
    thc:=ma;
    thc[2]:=ma[6];
    thc[3]:=ma[2];
    thc[6]:=ma[7];
    thc[7]:=ma[3];
  end;
{---------------------}
procedure xuli;
  begin
    l:=0; r:=1;
    while (l<=r) do
      begin
        inc(l);
        inc(r);
        a[r]:=tha(a[l]);
        b[r]:=b[l]+1;;
        c[r]:='A';
        if ss(a[r]) then break;
        inc(r);
        a[r]:=thb(a[l]);
        b[r]:=b[l]+1;;
        c[r]:='B';
        if ss(a[r]) then break;
         inc(r);
        a[r]:=thc(a[l]);
        b[r]:=b[l]+1;
        c[r]:='C';
        if ss(a[r]) then break;
      end;
  end;
{---------------------}
procedure xuat;
  begin
    assign(f,fo);
    rewrite(f);
    write(f,b[r]);
    close(f);
  end;
{---------------------}
BEGIN
  nhap;
  xuli;
  xuat;
END.
