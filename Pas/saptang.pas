const
  tfi ='saptang.inp';
  tfo ='saptang.out';
type
  arr = array[1..100000] of longint;
var
  a,b: arr;
  i,n: longint;
  fi,fo: text;

procedure nhap;

        begin
            assign(fi,tfi);
            reset(fi);
            readln(fi,n);
            for i:=1 to n do readln(fi,a[i],b[i]);
            close(fi);
        end;

procedure doicho ( var x,y: longint);
     var tg: longint;
      begin
          tg:=x;
          x:=y;
          y:=tg;
      end;

procedure qsort ( l,r: longint);
     var i,j,key1,key2,mid: longint;
      begin
          i:=l;
          j:=r;
          mid:=l+  random(r-l+1);
          key1:=a[mid];
          key2:= b[mid];
          repeat
               while (a[i] < key1) or ((a[i]=key1) and (b[i]<key2)) do inc(i);
               while (a[j] > key1) or ((a[j]=key1) and (b[j]>key2)) do dec(j);
               if i<=j then
                begin
                    doicho(a[i],a[j]); doicho(b[i],b[j]);
                    inc(i); dec(j);
                end;
          until i >= j;
    if l < j then qsort(l,j);
    if i < r then qsort(i,r);
     end;


procedure inkq;

        begin
            assign(fo,tfo);
            rewrite(fo);
            for i:=1 to n do writeln(fo,a[i], ' ',b[i]);
            close(fo);
        end;
BEGIN
    NHAP;
    randomize;
    qsort(1,n);
    inkq;
END.