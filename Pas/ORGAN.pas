Uses math;
Const   inp = 'ORGAN.INP';
        out = 'ORGAN.OUT';
        maxn = 201;
        oo = 1000000000;

Type    arr = array [0..50] of longint;
        arr1 = array [0..50] of int64;

Var     h,t      :       array [0..maxn] of int64;
        n,s,m,w,bmin,bmax,ntest  :  longint;
        g,f     :       array [0..maxn,0..maxn] of arr;
        d       :       array [1..maxn] of arr;

{***************************************************************************}
Function cong(a,b:arr):arr;
      Var
        i,nho,x :longint;
      Begin
        fillchar(cong,sizeof(cong),0);
        nho:=0;
        cong[0]:=max(a[0],b[0]);
        for i:=1 to cong[0] do
          begin
            x:=a[i]+b[i]+nho;
            cong[i]:=x mod oo;
            nho:=x div oo;
          end;
        if nho<>0 then
          begin
            inc(cong[0]);
            cong[cong[0]]:=nho;
          end;
      End;
(***********************************************************************)
Function nhan(a,b:arr):arr;
      Var
        i,j,nho       :longint;
        c       :arr1;
        x       :int64;
      Begin
        fillchar(c,sizeof(c),0);
        fillchar(nhan,sizeof(nhan),0);
        c[0]:=a[0]+b[0]-1;
        for i:=1 to a[0] do
          for j:=1 to b[0] do
            c[i+j-1]:=c[i+j-1]+int64(a[i])*int64(b[j]);
        nho:=0;
        for i:=1 to c[0] do
          begin
            x:=c[i]+nho;
            c[i]:=x mod oo;
            nho:=x div oo;
          end;
        if nho<>0 then
          begin
            inc(c[0]);
            c[c[0]]:=nho;
          end;
        nhan[0]:=c[0];
        for i:=1 to c[0] do nhan[i]:=c[i];
      End;

{***************************************************************************}
function maxx(a,b:arr) :arr;
var
        i:longint;
begin
        if a[0] < b[0] then exit(b) ;
        if a[0] > b[0] then exit(a) ;
        for i := a[0] downto 1 do
         begin
                if a[i] > b[i] then exit(a) ;
                if a[i] < b[i] then exit(b) ;
         end;
         exit(a) ;
end;
{***************************************************************************}
Procedure ghi(c:arr);
      Var
        i       :longint;
        s,ds    :string;
      Begin
        if (c[0]=1) and (c[1] = -1) then
          begin
              writeln(0);
              exit;
          end;
        ds:='';
        for i:=1 to c[0] do
          begin
            str(c[i],s);
            while length(s)<9 do s:='0'+s;
            ds:=s+ds;
          end;
        while ds[1]='0' do delete(ds,1,1);
        writeln(ds);
      End;
{***************************************************************************}
procedure khoitao;
var i,j : longint;
        begin
            fillchar(t,sizeof(t),0);
            fillchar(d,sizeof(d),0);
            for i := 1 to n do t[i] := t[i-1]+h[i];
            for i := 1 to n do d[i][0] := 1;
            for i := 1 to n do
             for j := 0 to w do
              d[i] := cong(d[i],f[i,j]);
            fillchar(g,sizeof(g),0);
            for i := 1 to n do
             if (t[i]*m >= bmin) and (t[i]*m <= bmax) then
              begin
                g[i,0] := d[i];
              end;
        end;
{***************************************************************************}
procedure main;
var i,j,k,l : longint;
    x : int64;
        begin
             khoitao;
             for i := 2 to n do
              for k := 1 to min(s-1,i-1) do
               for j := i downto k+1 do
                 begin
                     x := (t[i]-t[j-1])*m; l := i-j+1;
                     if (bmin <= x) and (x <= bmax) and (g[j-1,k-1][0] > 0) then
                       g[i,k] := maxx(g[i,k], cong(g[j-1,k-1],d[l]));
                 end;
             ghi(g[n,s-1]);
        end;
{**************************************************************************}
procedure init;
var i,j : longint;
    tmp : arr;
        begin
            f[1,0][0] := 1; f[1,0][1] := 1;
            for i := 2 to 200 do
             for j := 0 to i-1 do
             begin
                tmp[0] := 1; tmp[1] := j+1;
                if f[i-1,j][0] > 0 then
                f[i,j] := cong(f[i,j],nhan(f[i-1,j],tmp));
                tmp[1] := i-j;
                if (j > 0) and (f[i-1,j-1][0] > 0) then
                f[i,j] := cong(f[i,j],nhan(f[i-1,j-1],tmp));
             end;
        end;
{**************************************************************************}
procedure nhap;
var i,j : longint;
        begin
            //assign(input,inp); reset(input);
           // assign(output,out); rewrite(output);
            readln(ntest);
            init;
            while ntest > 0 do
              begin
                dec(ntest);
                readln(n,s,w,m,bmin,bmax);
                for i := 1 to n do read(h[i]);
                main;
              end;
        end;
{***************************************************************************}
begin
     nhap;
end.
