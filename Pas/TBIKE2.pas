{$INLINE ON}
Uses math;
{========================================}
const
        tfi     =       'TBIKE.INP';
        tfo     =       'TBIKE.OU1';
        Nmax    =       2001;
        vc      =       1000000001;
type
        arr1    =       array[0..Nmax] of longint ;
        arr2    =       array[0..Nmax,0..Nmax] of longint ;
var
        fi,fo   :       text;
        n,m,hieu,dem     :       longint;
        a,f     :       arr1;
        g1,g2,c :       arr2;
{========================================}
procedure Nhap;
var
        i,j,k:longint;
begin
           read(fi,n);
           for i := 1 to n do Read(fi,a[i]);
end;
{========================================}
{========================================}
procedure init;
var
        i,j,k :longint;
begin
        for i := 1 to n do
          begin
                G1[i,i] := 0;
                G2[i,i] := vc;
          end;
        For i := 2 to n do
          For j := i - 1 downto 1 do
             begin
                if (G1[j+1,i]< a[j]) and (a[j]<=a[i]) then
                  G1[j,i] := a[j] else G1[j,i] := G1[j+1,i];
                if (G2[j+1,i]>a[j]) and (a[j]>=a[i]) then
                  G2[j,i] := a[j] else G2[j,i] := G2[j+1,i];
             end;
end;
procedure Push(i,j:longint);inline ;
begin
        if j - i <= hieu then
         begin
              if j - i < hieu then dem := 1 else
                dem := dem + 1;
                hieu := j - i;
         end;
end;
{========================================}
procedure init2;
var
        i,j,k:longint;
begin
        for i := 1 to n do
          begin
             hieu := vc;
             dem := 0;
             C[i,i] := 1;
             For j := i + 1 to n do
               begin
                    if G1[i,j] <> 0 then
                        Push(G1[i,j],a[j]);
                    if G2[i,j] <> vc then
                        Push(a[j],G2[i,j]);
                    if (dem >= j - i) and (hieu<>0) then
                     begin
                      C[i,j] := 1;
                    //  writeln(i,' ',j);
                     end;
               end;
          end;
end;
{========================================}
procedure xuly;
var
        i,j,k:longint;
begin
        for i := 1 to n do
         begin
          f[i] := vc;
          for j := 1 to i do if c[j,i] = 1 then
            F[i] := min(F[i],F[j-1] + 1);
         end;
end;
{========================================}
procedure inkq;
var
        i,j,k:longint;
begin
        write(fo,F[n]);
end;
{========================================}
begin
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
        Nhap;
        init;
        init2;
        xuly;
        inkq;
        close(fi);
        close(fo);
end.
{========================================}








