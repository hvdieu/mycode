program castle;
const
        vt      :       array[0..15] of string = ('','w','n','wn','e','we','ne','wne','s','ws','ns','wns','es','wes','nes','wnes');
        fi      =       'castle.inp';
        fo      =       'castle.oup';
        maxn    =       51;
        maxm    =       51;
var
        f:text;
        ni,m,dem,i,j,max,kq1,kq2,max1:integer;
        kq3:char;
        e,n,w,s:array[1..maxm,1..maxn] of boolean;
        kt:array[0..maxm,0..maxn] of boolean;
        xet,a:array[1..maxm,1..maxn] of integer;
        demsoo:array[0..maxn*maxm] of integer;
{------------------------}
procedure lam(a:integer);
var k:integer;
  begin
    for k:=1 to length(vt[a]) do
      begin
        case vt[a][k] of
          'w': w[i,j]:=true;
          'e': e[i,j]:=true;
          'n': n[i,j]:=true;
          's': s[i,j]:=true;
        end;
      end;
  end;
{------------------------}
procedure nhap;
  begin
    assign(f,fi);
    reset(f);
    read(f,m,ni);
    fillchar(kt,sizeof(kt),true);
    for i:=1 to m do
      for j:=1 to ni do
        begin
          kt[i,j]:=false;
          read(f,a[i,j]);
          lam(a[i,j]);
        end;
    close(f);
  end;
{------------------------}
procedure loang(i,j:integer);
var t:integer;
  begin
    inc(demsoo[xet[i,j]]);
    if demsoo[xet[i,j]]>max then max:=demsoo[xet[i,j]];
    kt[i,j]:=true;
    if (not n[i,j]) and (not kt[i-1,j]) then
      begin
        xet[i-1,j]:=xet[i,j];
        loang(i-1,j);
      end;
    if (not e[i,j]) and (not kt[i,j+1]) then
      begin
        xet[i,j+1]:=xet[i,j];
        loang(i,j+1);
      end;
    if (not s[i,j]) and (not kt[i+1,j]) then
      begin
        xet[i+1,j]:=xet[i,j];
        loang(i+1,j);
      end;
    if (not w[i,j]) and (not kt[i,j-1]) then
      begin
        xet[i,j-1]:=xet[i,j];
        loang(i,j-1);
      end;
  end;
{------------------------}
procedure xuli;
var i,j:integer;
  begin
    for i:=1 to m do
      for j:=1 to ni do
        begin
          if not kt[i,j] then
            begin
              inc(dem);
              xet[i,j]:=dem;
              loang(i,j);
            end;
        end;
    for i:=1 to m do
      for j:=1 to ni do
        begin
          if (xet[i,j]<>xet[i,j+1]) and (demsoo[xet[i,j]]+demsoo[xet[i,j+1]]>max1)
            then
              begin
                max1:=demsoo[xet[i,j]]+demsoo[xet[i,j+1]];
                kq1:=i;
                kq2:=j;
                kq3:='E';
              end;
          if (xet[i,j]<>xet[i+1,j]) and (demsoo[xet[i,j]]+demsoo[xet[i+1,j]]>max1)
            then
              begin
                max1:=demsoo[xet[i,j]]+demsoo[xet[i+1,j]];
                kq1:=i;
                kq2:=j;
                kq3:='S';
              end;
        end;
  end;
{------------------------}
procedure xuat;
  begin
    assign(f,fo);
    rewrite(f);
    writeln(f,dem);
    writeln(f,max);
    writeln(f,max1);
    write(f,kq1,' ',kq2,' ',kq3);
    close(f);
  end;
{------------------------}
BEGIN
  nhap;
  xuli;
  xuat;
END.
