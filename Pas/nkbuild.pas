{========================================}
const
        tfi     =       'nkbuild.inp';
        tfo     =       'output.txt';
        Nmax    =       10001;
        vc      =       10000000000 ;
type
        arr1    =       array[0..110] of longint ;
        arr2    =       array[-Nmax..Nmax] of longint ;
        arr3    =       array[0..101,0..130] of longint  ;
        arr4    =       array[0..101,0..130] of boolean ;
        arr5    =       array[0..101,0..130] of int64 ;
        arr6    =       array[0..13000] of longint ;
var
        fi,fo   :       text;
        n,m,p,nh,xi,yi     :       longint;
        a,next,ts:      arr2 ;
        head,dd:   arr1;
        pos     :       arr3;
        free    :       arr4 ;
        d       :       arr5 ;
        h,h2    :       arr6;
{========================================}
procedure Nhap;
var
        i,j,k,x,y,z:longint;
begin
        Read(fi,n,m,p);
        for i := 1 to p do
         begin
                Read(fi,x);
                dd[x] := 1 shl (i-1) ;
         end;
        for i := 1 to m do
          begin
              Read(fi,x,y,z);
              a[i] := y;
              next[i] := head[x];
              head[x] := i;
              a[-i] := x;
              next[-i] := head[y];
              head[y] := -i;
              ts[i] := z;
              ts[-i] := z;
          end;
end;
{========================================}
procedure Upheap(i:longint);
var
        u,v:longint;
begin
        u := h[i];
        v := h2[i];
        while (i>1) and (D[u,v] < D[h[i div 2],h2[i div 2]]) do
          begin
                H[i] := H[i div 2];
                H2[i] := H2[i div 2];
                Pos[H[i],H2[i]] := i;
                i := i div 2;
          end;
        H[i] := u ;
        H2[i] := v;
        Pos[u,v] := i;
end;
procedure downheap(i:longint);
var
        u,v,j:longint;
begin
        u := h[i];
        v := h2[i];
        while i * 2 <= nh do
         begin
             j := i *2;
             if (j<nh) and (D[h[j],h2[j]]>D[h[j+1],h2[j+1]]) then inc(j);
             if D[u,v] <= D[h[j],h2[j]] then break ;
             H[i] := H[j];
             H2[i] := H2[j];
             Pos[h[i],H2[i]] := i;
             i := j;
         end;
       H[i] := u ;
        H2[i] := v;
        Pos[u,v] := i;
end;
procedure Push(i,j:longint);
begin
        if pos[i,j] = 0 then
          begin
          inc(nh);
          H[nh] := i;
          H2[nh] := j;
          pos[i,j]:= nh;
          Upheap(nh);
          end else Upheap(pos[i,j]);
end;
procedure Pop;
begin
        xi := h[1];
        yi := h2[1];
        h[1] := H[nh];
        h2[1] := h2[nh];
        Pos[h[1],h2[1]] := 1;
        dec(nh);
        downheap(1);
end;
procedure Update;
var
        i,j,k,s,u,v:longint;
begin
        j := head[xi];
        while j <> 0 do
          begin
                k := a[j];
                if yi and dd[k] = 0 then
                  begin
                        s := yi or dd[k] ;
                        if free[k,s] and (d[k,s] > d[xi,yi] + ts[j]) then
                          begin
                                D[k,s] := D[xi,yi] + ts[j];
                                Push(k,s);
                          end ;
                  end ;
                j := next[j];
          end;
       For v := 0 to 1 shl p - 1 do
         begin
             s := yi or v;
             if free[xi,s] and (D[xi,s]>D[xi,yi] + D[xi,v]) then
                begin
                        D[xi,s] := D[xi,yi] + D[xi,v];
                        Push(xi,s);
                end;
         end;
end;
{========================================}
procedure init;
var
        i,j,k :longint;
begin
        for i := 1 to n do
          For j := 0 to 1 shl p - 1 do
            begin
              free[i,j] := true;
              d[i,j] := vc;
              pos[i,j] :=0;
            end ;
        nh := 0;
        for i := 1 to n do
          begin
                d[i][dd[i]] := 0;
                push(i,dd[i]);
          end;
end;
{========================================}
{========================================}
procedure xuly;
var
        i,j,k:longint;
begin
        k := 1 shl p - 1;
        while nh > 0 do
         begin
              pop;
              free[xi,yi] := false;
              if yi = k then exit ;
              Update ;
         end;
end;
{========================================}
procedure inkq;
var
        i,j,k:longint;
begin
        write(fo,D[xi,yi]);
end;
{==================================8======}
begin
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
        Nhap;
        init;
        xuly;
        inkq;
        close(fi);
        close(fo);
end.
{========================================}


