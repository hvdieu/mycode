program cbuying;
const
        fi      =       'CBUYING.INP';
        fo      =       'CBUYING.OUT';
        maxn    =       100010;
var
        f:text;
        a,b:array[1..maxn] of int64;
        n,i:longint;
        s,dem:int64;
{---------------------------}
procedure nhap;
  begin
    assign(f,fi);
    reset(f);
    readln(f,n,s);
    for i:=1 to n do
      begin
        readln(f,a[i],b[i]);
      end;
    close(f);
  end;
{---------------------------}
procedure swap(var a,b:int64);
var
        tg:int64;
  begin
    tg:=a;
    a:=b;
    b:=tg;
  end;
{---------------------------}
procedure sort(d,c:longint);
var
        i,j:longint;
        chot:int64;
  begin
    if d>=c then exit;
    i:=d;
    j:=c;
    chot:=a[(d+c) div 2];
    repeat
      while a[i]<chot do inc(i);
      while a[j]>chot do dec(j);
      if i<=j then
        begin
          if i<j then
            begin
              swap(a[i],a[j]);
              swap(b[i],b[j]);
            end;
          inc(i);
          dec(j);
        end;
    until i>j;
    sort(d,j); sort(i,c);
  end;
{--------------------------}
procedure xuli;
  begin
    sort(1,n);
    i:=1;
    while (s>=a[i]*b[i]) and (i<n) do
      begin
        s:=s-a[i]*b[i];
        dem:=dem+b[i];
        inc(i);
      end;
    dem:=dem+s div a[i];
  end;
{--------------------------}
procedure xuat;
  begin
    assign(f,fo);
    rewrite(f);
    write(f,dem);
    close(f);
  end;
{--------------------------}
BEGIN
  nhap;
  xuli;
  xuat;
END.
