
const
  tfi ='heapsort.inp';
  tfo ='heapsort.out';
type
  arr = array[1..100000] of longint;
var
  a: arr;
  i,n: longint;
  fi,fo: text;

procedure nhap;

        begin
            assign(fi,tfi);
            reset(fi);
            readln(fi,n);
            for i:=1 to n do read(fi,a[i]);
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
     var i,j,key: longint;
      begin
          i:=l;
          j:=r;
          key:= a[ l+ random(r-l+1) ];
          repeat
               while a[i] < key do inc(i);
               while a[j] > key do dec(j);
               if i<=j then
                begin
                    if i < j then doicho(a[i],a[j]);
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
            for i:=1 to n do write(fo,a[i], ' ');
            close(fo);
        end;

 begin
    nhap;
    randomize;
    qsort(1,n);
    inkq;
end.
