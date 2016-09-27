const
        tfi     =       'seq.inp';
        tfo     =       'seq.out';
type
        ARR     =       array[1..100000] of longint ;
var
        fi,fo   :       text;
        a       :       arr;
        n,k     :       longint;
procedure       nhap;
var i:longint;
        begin
            assign(fi,tfi);reset(fi);
             read(fi,n,k);
            for i:=1 to n do
            read(fi,a[i]);
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

function find(x:int64;l,r:longint):boolean;
 var
  mid :longint;
 begin
     while l<=r do
      begin
         mid:=(l+r)div 2;
         if a[mid]=x then exit(true)
         else if a[mid]>x then r:=mid-1
         else l:=mid+1;
      end;
    exit(false);
 end;
procedure xuly;
   var i,dd,x:longint;
        begin
         assign(fo,tfo);rewrite(fo);
           for i:=1 to n -1 do
           begin
               x:=2*k-a[i];
               if find(x,i+1,n)=true then
                 begin
                    dd:=1;
                     write(fo,'yes');
                     break;
                 end;

           end;
        if dd=0 then write(fo,'no');
          close(fo);
        end;
BEGIN
    nhap;
    qsort(1,n);
    xuly;

END.