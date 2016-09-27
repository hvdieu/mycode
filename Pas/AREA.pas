Const   inp = '';
        out = '';
        max = 30000;
Var     n          :    integer;
        d          :    array [1..max,1..max] of boolean;
        fi,fo      :    text;
        x1,x2,y1,y2 : longint;
        min1,min2,max1,max2,i,j,k : longint;
        dem     :       int64;
{*      *       *       *}
BEGIN
    dem:=0;
    fillchar(d,sizeof(d),false);
    assign(fi,inp);reset(fi);
    readln(fi,n);
    min1:=maxint;
    min2:=maxint;
    For k:=1 to n do
      BEGIN
          readln(fi,x1,y1,x2,y2);
          if x1<min1 then min1:=x1;
          if y1<min2 then min2:=y1;
          if x2>max1 then max1:=x2;
          if y2>max2 then max2:=y2;
          For i:=y1 to y2-1 do
            For j:=x1 to x2-1 do
              d[i,j]:=true;
      END;
    For i:=min2 to max2 do
      For j:=min1 to max1 do
        if d[i,j] then inc(dem);
    assign(fo,out);rewrite(fo);
    write(fo,dem);
    close(fi);
    close(fo);

END.
