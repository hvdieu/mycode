program search;
const
        fi      =       'search1.inp';
        fo      =       'search1.out';
        maxn    =       100010;
var
        f:text;
        a,b,c:array[0..maxn] of longint;
        kq,i,dem,d,max,m,n,p:longint;
        cx,ca,cb:array[0..maxn] of boolean;
{       -       -       }
procedure nhap;
  begin
    assign(f,fi);
    reset(f);
    read(m,n,p);
    for i:=1 to m do
      begin
        read(f,a[i]);
        if ca[a[i]]=false then
          begin
            ca[a[i]]:=true;
            inc(dem);
          end;
      end;
    for i:=1 to n do
      begin
        read(f,b[i]);
        cb[b[i]]:=true;
      end;
    for i:=1 to p do
      begin
        read(f,c[i]);
      end;
    c[p+1]:=b[1];
  end;
{       -       -       }
procedure xuli;
  begin
    cx:=ca;
    d:=dem;
    for i:=1 to p+1 do
      begin
        if cb[c[i]] then
          begin
            if (dem=0) and (kq>max) then max:=kq;
            dem:=d;
            ca:=cx;
            kq:=-1;
          end;
        if ca[c[i]] then
          begin
            dec(dem);
            ca[c[i]]:=true;
          end;
        inc(kq);
      end;
  end;
{       -       -       }
procedure xuat;
  begin
    assign(f,fo);
    rewrite(f);
    write(f,max);
    close(f);
  end;
{       -       -       }
BEGIN
  nhap;
  xuli;
  xuat;
END.