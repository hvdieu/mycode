{$M 128000000}
{$INLINE ON}
uses math ;
{========================================}
const
        tfi     =       'asd.inp';
        tfo     =       'lem4.out';
        Nmax    =       10001;
type
        NODE    =       record
                x,y:longint;
                end ;
        arr1    =       array[0..4*Nmax] of node ;
var
        fi,fo   :       text;
        n,m     :       longint;
        t1,t2   :       arr1;
{========================================}
procedure Nhap;
var
        i,j,k:longint;
begin
        Read(fi,n,m);
end;
{========================================}
procedure Init(i,lo,hi:longint);
var
        mid:longint;
begin
        t1[i].y := -1;
        t2[i].y := -1;
        if lo = hi then
          begin
                if lo = 1 then T1[i].x := n;
                t2[i].x := 1;
                exit ;
          end ;
        mid := (lo+hi) shr 1;
        init(i*2,lo,mid);
        init(i*2+1,mid+1,hi);
        t1[i].x:= max(T1[i*2].x,T1[i*2+1].x);
end;
procedure dondl1(i:longint);inline ;
var
        j,k,x:longint;
begin
        j := i * 2;
        k := j + 1;
        x := t1[i].y ;
        T1[j].x := x ;
        T1[k].x := x;
        T1[j].y := x;
        t1[k].y := x;
        t1[i].y := -1;
end;
procedure dondl2(i:longint);inline ;
var
        j,k,x:longint;
begin
        j := i * 2;
        k := j + 1;
        x := t2[i].y ;
        T2[j].x := x ;
        T2[k].x := x;
        T2[j].y := x;
        t2[k].y := x;
        t2[i].y := -1;
end;
{========================================}
procedure Update1(i,lo,hi,u,v,x:longint);inline ;
var
        mid:longint;
begin
        if (u>hi) or (v<lo) then exit;
        if (u<=lo) and (hi<=v) then
          begin
            t1[i].x := x;
            t1[i].y := x;
            exit ;
          end;
          if t1[i].y <> -1 then dondl1(i);
        mid := (lo+hi) shr 1;
        Update1(i*2,lo,mid,u,v,x) ;
        Update1(i*2+1,mid+1,hi,u,v,x);
        T1[i].x := max(T1[i*2].x,T1[i*2+1].x);
end;
procedure Update2(i,lo,hi,u,v,x:longint);inline ;
var
        mid:longint;
begin
        if (u>hi) or (v<lo) then exit;
        if (u<=lo) and (hi<=v) then
          begin
            t2[i].x := x;
            t2[i].y := x;
            exit ;
          end;
          if t2[i].y <> -1 then Dondl2(i);
        mid := (lo+hi) shr 1;
        Update2(i*2,lo,mid,u,v,x) ;
        Update2(i*2+1,mid+1,hi,u,v,x);
        T2[i].x := max(T2[i*2].x,T2[i*2+1].x);
end;
function Qr1(i,lo,hi,u:longint):longint;
var
        mid,l,r:longint;
begin
        if (u>hi) or (u<lo) then exit(0);
        if lo = hi then exit(t1[i].x);
        if t1[i].y <> -1 then dondl1(i);
        mid := (lo+hi) shr 1;
        qr1 := max(qr1(i*2,lo,mid,u),qr1(i*2+1,mid+1,hi,u));
end;
function Qr2(i,lo,hi,u:longint):longint;
var
        mid,l,r:longint;
begin
        if (u>hi) or (u<lo) then exit(0);
        if lo = hi then exit(t2[i].x);
        if t2[i].y <> -1 then dondl2(i);
        mid := (lo+hi) shr 1;
        qr2 := max(qr2(i*2,lo,mid,u),qr2(i*2+1,mid+1,hi,u));
end;
function findr(i:longint):longint;
var
        j:longint;
begin
        if i = n + 1 then exit(n);
        j := Qr2(1,1,n,i);
        if j = 0 then exit(i-1) else
          exit(j - 1 + Qr1(1,1,n,j));
end ;
function Findl(i:longint):longint;
var
        j:longint;
begin
        if i = 0 then exit(1);
        j := qr2(1,1,n,i);
        if j = 0 then exit(i+1) else exit(j);
end;
{========================================}
procedure xuly;
var
        i,j,k,ok,x,y,l,r:longint;
begin
        for i := 1 to m do
          begin
               REad(fi,ok);
               if ok = 3 then writeln(fo,T1[1].x) else
               begin
                    Read(fi,x,y);
                    if ok = 1 then
                      begin
                          l := findl(x-1);
                          r := findr(y+1);
                          Update1(1,1,n,l,r,0);
                          Update1(1,1,n,l,l,r-l+1);
                          Update2(1,1,n,l,r,l);
                      end else
                      begin
                          l := findl(x-1);
                          r := findr(y+1);
                          Update1(1,1,n,x,y,0);
                          Update2(1,1,n,x,y,0);
                          if r <> y then
                            begin
                                Update1(1,1,n,y+1,y+1,r-y);
                                Update2(1,1,n,y+1,r,y+1);
                            end;
                          if l <> x then
                            begin
                                Update1(1,1,n,l,l,x-l);
                            end;
                      end;
               end;
          end;
end;
{========================================}
procedure inkq;
var
        i,j,k:longint;
begin
end;
{========================================}
begin
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
        Nhap;
        init(1,1,n);
        xuly;
        inkq;
        close(fi);
        close(fo);
end.
{========================================}



