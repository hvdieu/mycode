{========================================}
const
        tfi     =       'ntseq.inp';
        tfo     =       'nt.out';
        Nmax    =       100001;
        vc      =       1000000007;
type
        arr1    =       array[0..Nmax] of longint ;
        arr2    =       array[0..Nmax] of longint ;
var
        fi,fo   :       text;
        n,m,top,res     :       longint;
        a,f,st,vt,b,g,s,c,pos,dau,cuoi       :       arr1 ;
{========================================}
procedure Nhap;
var
        i,j,k:longint;
begin
         Read(fi,n);
         For i := 1 to n do Read(fi,a[i]);
end;
{========================================}
procedure doicho(var x,y:longint);
var
        tg:longint;
begin
        tg := x;
        x := y;
        y := tg;
end;
{========================================}
procedure sort(l,r:longint);
var
        i,j,k,k2:longint;
begin
        i := l;
        j := r;
        k := l+random(r-l+1);
        k2 := c[k];
        k := b[k];
        while i <= j do
          begin
                while (b[i] < k) or ((b[i]=k) and (c[i]<k2)) do inc(i);
                while (b[j] > k) or ((b[j]=k) and (c[j]>k2)) do dec(j);
                if i <= j then
                  begin
                        doicho(b[i],b[j]);
                        doicho(c[i],c[j]);
                        doicho(vt[i],vt[j]);
                        inc(i);
                        dec(j);
                  end;
          end;
          if i < r then sort(i,r);
          if j > l then sort(l,j);
end;
{========================================}
function Find(x:longint):longint ;
var
        l,r,mid,kq:longint;
begin
        kq := 0;
        l := 1;
        r := top;
        while l <= r do
         begin
                mid := (l+r) shr 1;
                if st[mid] >= x then
                  begin
                       kq := mid;
                       r := mid - 1;
                  end else l := mid + 1;
         end;
       exit(kq);
end;
{========================================}
procedure init;
var
        i,j,k :longint;
begin
        f[1] := 1;
        inc(top);
        st[top] := a[1];
        For i := 2 to n do if a[i] > st[top] then
         begin
                 f[i] := top + 1;
                 inc(top);
                 st[top] := a[i];
         end else
         begin
                j := Find(a[i]);
                F[i] := j;
                st[j] := a[i];
         end;
end;
{========================================}
procedure Ktao;
var
        i,j,k:longint;
begin
        For i := 1 to n do
         begin
                b[i] := F[i];
                c[i] := a[i];
                vt[i] := i;
         end;
       sort(1,n);
       For i := 1 to n do pos[vt[i]] := i;
       i := 1;
       while i <= n do
         begin
                j := i;
                while (j<=n) and (b[j]=b[i]) do inc(j);
                dau[b[i]] := i;
                cuoi[b[i]] := j-1;
                i := j ;
         end;
end;
{========================================}
procedure UPdate(i,J:longint);
begin
        while i <= n do
          begin
              S[i] := (S[i] + j) mod vc;
              i := i + (i and (-i));
          end;
end;
{========================================}
function QR(i:longint):longint;
begin
        qr := 0;
        while i > 0 do
          begin
                qr := (qr + s[i]) mod vc;
                i := i - (i and (-i));
          end;
end;
{========================================}
function SUm(i,j:longint):longint;
begin
        sum := ((qr(j)-qr(i-1)) mod vc+vc) mod vc;
end;
{========================================}
{========================================}
function Find2(l,r,x:longint):longint;
var
        mid,kq:longint;
begin
        kq := 0;
        while l <= r do
          begin
                mid := (l+r) shr 1;
                if c[mid] < x then
                  begin
                   kq := mid;
                   l := mid + 1;
                  end else r := mid - 1;
          end;
          exit(kq);
end;
procedure xuly;
var
        i,j,k:longint;
begin
        ktao;
        For i := 1 to n do
          begin
                if F[i] > 1 then
                 begin
                        j := Find2(dau[f[i]-1],cuoi[f[i]-1],a[i]);
                        G[i] := sum(dau[f[i]-1],j);
                 end else G[i] := 1;
                 UPdate(Pos[i],g[i]);
                 if F[i]=top then res := (res+G[i]) mod vc;
          end;
          writeln(fo,res);
end;
{========================================}
procedure xuly2;
var
        i,j,k:longint;
begin
        For i := 1 to n do if F[i] = 1 then G[i] := 1 else G[i] := 0;
        For i := 2 to n do
         For j := i-1 downto 1 do if (F[i] = F[j]+1) and (a[j]<a[i]) then
           G[i] := (G[i]+G[j]) mod vc;
        res := 0;
        For i := 1 to n do if F[i] = top then
           begin
                res := (res+g[i]) mod vc;
           end;
           writeln(fo,res);
end;
{========================================}
procedure inkq;
var
        i,j,k:longint;
begin
        write(fo,res);

end;
{========================================}
procedure make;
var
        i,j:longint;
begin
        assign(fi,tfi);rewrite(fi);
                  Randomize;
                  n := 5000;
                  writeln(fi,n);
             //     For i := 1 to n do write(fi,random(1000000000),' ');
                 For i := 1 to n div 2 do write(fi,'1 ');
                 For i := 1 to n div 2 do write(fi,'2 ');
        close(fi);
end;
{========================================}
begin
      //  make;
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
        Nhap;
        init;
        if n > 1000 then
          xuly else xuly2;
        close(fi);
        close(fo);
end.
{========================================}




















