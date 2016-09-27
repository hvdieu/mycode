program lem1;
uses math;
const
        fi      =       'lem1.inp';
        fo      =       'lem1.out';
        maxn    =       10010;
var
        f:text;
        n:longint;
        a:array[1..maxn] of real;
        s:real;
{       -       -       }
procedure nhap;
var i:longint;
  begin
    assign(f,fi);
    reset(f);
    read(f,n);
    for i:=1 to n do
      begin
        read(f,a[i]);
        s:=s+a[i];
      end;
    close(f);
  end;
{       -       -       }
function goc(t,t1,t2:real):real;
  begin
    goc:=arccos((sqr(t1)+sqr(t2)-sqr(t))/(2*t1*t2));
  end;
{       -       -       }
function check(mid:real):real;
var
        g:real;
        i:longint;
  begin
    g:=0;
    for i:=1 to n-1 do
      g:=g+goc(a[i]+a[i+1],a[i]+mid,a[i+1]+mid);
    g:=g+goc(a[1]+a[n],a[1]+mid,a[n]+mid);
    check:=g-2*pi;
  end;
{       -       -       }
function find(d,c:real):real;
var
        t,mid:real;
  begin
    while d<=c do
      begin
        mid:=(d+c)/2;
        t:=check(mid);
        if abs(t)<0.00001 then exit(mid)
        else if t<0 then d:=mid+0.00001
                    else c:=mid-0.00001;
      end;
  end;
{       -       -       }
procedure xuat;
  begin
    assign(f,fo);
    rewrite(f);
    write(f,find(0,s):1:3);
    close(f);
  end;
{       -       -       }
BEGIN
  nhap;
  xuat;
END.
