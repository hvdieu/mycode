{$INLINE ON}
uses math ;
const
        tfi     =       'input.txt';
        tfo     =       'output.txt';
        Nmax    =       1001;
        vc=100000000000000000 ;
        e=1e-8;
type
        arr1    =       array[0..Nmax] of longint ;
var
        fi,fo   :       text;
        n,m     :       longint;
        xi:array[0..nmax,0..Nmax] of extended;
        ai,bi:array[0..Nmax,0..nmax] of int64 ;
        f,f2:array[0..Nmax,0..nmax] of int64 ;
        a,b,top,top1,sa,sb      :       arr1 ;
        res:   int64;
function Gd(a1: longint;b1:int64;a2:longint;b2:int64) :extended; inline ;
begin
        Gd := (b1-b2)/(a2-a1+e) ;
       // if a1 = a2 then
         //  writeln(a1,' ',b1,' ',a2,' ',b2);
end ;
procedure Push(a: longint;b:int64 ;i :longint) ; inline ;
var
        x:extended;
begin
        x := -vc  ;
        while top[i] > 0 do
         begin
                x := Gd(ai[i,top[i]],bi[i,top[i]],a,b) ;
                if x > xi[i,top[i]] + e then break ;
                dec(top[i]) ;
         end;
        if top[i] = 0 then x := 0 ;
        inc(top[i]) ;
        ai[i,top[i]] := a ;
        bi[i,top[i]] := b ;
        xi[i,top[i]] := x ;
        if top1[i] = 0 then top1[i] := 1;
        if top1[i] > top[i] then top1[i] := top[i] ;
end;
function Get(i,x:longint) :int64; inline;
begin
        if top1[i] = 0 then inc(top1[i]) ;
        while (top1[i] < top[i]) and (x >= xi[i,top1[i]+1]+e ) do inc(top1[i]) ;
        Get := int64(x)*ai[i,top1[i]] + bi[i,top1[i]] ;
end;
procedure process;
var
        i,j,k: longint;
        u,v:int64 ;
begin
        read(fi,n) ;
        for i := 1 to n do read(fi,a[i]) ;
        for i := 1 to n do read(fi,b[i]) ;
        for i := 1 to n do
         begin
                sa[i] := sa[i-1] + a[i];
                sb[i] := sb[i-1] + b[i];
         end;
        for i := 1 to n do
        begin
                f[i,1] := a[i] * b[1] - sqr(int64(sa[i-1]));
                f[1,i] := a[1] * b[i] - sqr(int64(sb[i-1]));
                Push(2*sa[1],f[1,i]-sqr(int64(sa[1])),i) ;
        end ;
        for i := 2 to n do
        begin
            top[0] := 0; top1[0] := 0 ;
            for j := 2 to n do
            begin
                 Push(2*Sb[j-1],F[i-1,j-1]-Sqr(int64(Sb[j-1])),0) ;
                 u := Get(0,Sb[j-1])-sqr(int64(sb[j-1])) ;
                 v := Get(j-1,sa[i-1])-sqr(int64(sa[i-1])) ;
                 f[i,j] := max(u,v) + a[i] * b[j] ;
            end ;
            For j := 1 to n do Push(2*sa[i],f[i,j]-sqr(int64(sa[i])),j) ;
        end;
        res := 0 ;
        for i := 1 to n do
        for j := 1 to n do res := max(res,f[i,j] - sqr(int64(sa[n]-sa[i]))-sqr(int64(sb[n]-sb[j]))) ;
        writeln(fo,res) ;
     {  for i := 1 to n do
        begin
                f2[i,1] := a[i] * b[1] - sqr(int64(sa[i-1]));
                f2[1,i] := a[1] * b[i] - sqr(int64(sb[i-1]));
        end ;
       for i := 2 to n do for j := 2 to n do
       begin
        f2[i,j] := -vc;
        for k := j -1 downto 1 do f2[i,j] := max(f2[i,j],f2[i-1,k] + a[i]*b[j] - sqr(int64(sb[j-1]-sb[k]))) ;
        for k := i -1 downto 1 do f2[i,j] := max(f2[i,j],f2[k,j-1] + a[i]*b[j] - sqr(int64(sa[i-1]-sa[k]))) ;
       end;
        res := 0 ;
        for i := 1 to n do for j := 1 to n do res := max(res,f2[i,j] - sqr(int64(sa[n]-sa[i]))-sqr(int64(sb[n]-sb[j]))) ;
        writeln(fo,res) ;
        for i := 1 to n do for j := 1 to n do if f[i,j] <> f2[i,j] then
         writeln(i,' ',j) ;}
end;
procedure make;
var
        i,j,k:longint;
begin
        assign(fi,tfi);rewrite(fi) ;
                   randomize;
                   n := 10 ;
                   writeln(fi,n);
                   for i := 1 to 2*n do writeln(fi,random(1001)) ;
        close(fi) ;
end;
begin
        make ;
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
                process ;
        close(fi);
        close(fo) ;
end.


