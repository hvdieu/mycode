Const   inp = '';
        out = '';
        maxn = 51;
        h    : array [1..4] of integer = (-1,0,1,0);
        c    : array [1..4] of integer = (0,1,0,-1);
Type    dinh = record
        x,y,truoc,tren,phai : integer;
        end;
        dinh2 = record
        x,y   : longint;
        end;
Var     fi,fo  :  text;
        d,vt      :  array [1..maxn,1..maxn,1..6,1..6,1..6] of longint;
        w      :  array [1..maxn,1..maxn] of longint;
        free   :  array [0..maxn,0..maxn,1..6,1..6,1..6] of boolean;
        pos      :  array [1..maxn*maxn*216] of dinh;
        heap  :  array [1..maxn*maxn*216] of longint;
        x1,x2,y1,y2,nheap,m,n,res     :   longint;

procedure input;
var i,j : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,m,n);
             for i := 1 to m do
                for j := 1 to n do
                   begin
                     read(fi,w[i,j]);
                   end;
             read(fi,x1,y1,x2,y2);
        end;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
             temp := xx; xx := yy; yy := temp;
        end;

procedure dc(var xx,yy : dinh);
var temp : dinh;
        begin
             temp := xx; xx := yy; yy := temp;
        end;

procedure upheap(i,j,truoc1,tren1,phai1 : longint);
var cha,con : longint;
        begin
             con := vt[i,j,truoc1,tren1,phai1];
             if con = 0 then
               begin
                 inc(nheap); heap[nheap] := d[i,j,truoc1,tren1,phai1];
                 vt[i,j,truoc1,tren1,phai1] := nheap;
                 con := nheap;
                 with pos[nheap] do
                    begin
                        x := i; y := j;
                        truoc := truoc1;
                        tren := tren1;
                        phai := phai1;
                    end;
               end;
             repeat
                  cha := con div 2;
                  if (cha=0) or (heap[cha] <= heap[con]) then break;
                  swap(heap[cha],heap[con]);
                  dc(pos[cha],pos[con]);
                  with pos[cha] do
                     begin
                         vt[x,y,truoc,tren,phai] := cha;
                     end;
                  with pos[con] do
                     begin
                         vt[x,y,truoc,tren,phai] := con;
                     end;
                  con := cha;
             until false;
        end;

procedure downheap(i,j,truoc1,tren1,phai1 : longint);
var cha,con : longint;
        begin
             cha := vt[i,j,truoc1,tren1,phai1];
             repeat
                  con := cha*2;
                  if (con<nheap) and (heap[con] > heap[con+1]) then inc(con);
                  if (con>nheap) or (heap[cha] <= heap[con]) then break;
                  swap(heap[cha],heap[con]);
                  dc(pos[cha],pos[con]);
                  with pos[cha] do
                     begin
                         vt[x,y,truoc,tren,phai] := cha;
                     end;
                  with pos[con] do
                     begin
                         vt[x,y,truoc,tren,phai] := con;
                     end;
                  cha := con;
             until false;
        end;

procedure pop;
          begin
               heap[1] := heap[nheap];
               pos[1] := pos[nheap];
               with pos[1] do
                  begin
                      vt[x,y,truoc,tren,phai] := 1;
                  end;
               dec(nheap);
               with pos[1] do
                  downheap(x,y,truoc,tren,phai);
          end;

procedure bentren(i,j,k,truoc1,tren1,phai1 : longint);
var u,v,x,m1,m2,m3 : longint;
        begin
          u := i+h[k]; v := j+c[k];
          m1 := 7 - tren1; m2 := truoc1; m3 := phai1;
          x := d[i,j,truoc1,tren1,phai1] + w[u,v] * (7 - truoc1);
          if free[u,v,m1,m2,m3] and (d[u,v,m1,m2,m3] > x) then
             begin
               d[u,v,m1,m2,m3] := x;
               upheap(u,v,m1,m2,m3);
             end;

        end;

procedure benphai(i,j,k,truoc1,tren1,phai1 : longint);
var u,v,x,m1,m2,m3 : longint;
        begin
            u := i+h[k]; v := j+c[k];
            m1 := truoc1; m2 := 7 - phai1; m3 := tren1;
            x := d[i,j,truoc1,tren1,phai1] + w[u,v] * phai1;
            if free[u,v,m1,m2,m3] and (d[u,v,m1,m2,m3] > x) then
               begin
                 d[u,v,m1,m2,m3] := x;
                 upheap(u,v,m1,m2,m3);
               end;
        end;

procedure benduoi(i,j,k,truoc1,tren1,phai1 : longint);
var u,v,x,m1,m2,m3 : longint;
        begin
            u := i+h[k]; v := j+c[k];
            m1 := tren1; m2 := 7-truoc1; m3 := phai1;
            x := d[i,j,truoc1,tren1,phai1] + w[u,v]*truoc1;
            if free[u,v,m1,m2,m3] and (d[u,v,m1,m2,m3] > x) then
               begin
                 d[u,v,m1,m2,m3] := x;
                 upheap(u,v,m1,m2,m3);
               end;
        end;

procedure bentrai(i,j,k,truoc1,tren1,phai1 : longint);
var u,v,x,m1,m2,m3 : longint;
        begin
            u := i+h[k]; v := j+c[k];
            m1 := truoc1; m2 := phai1; m3 := 7 - tren1;
            x := d[i,j,truoc1,tren1,phai1] + w[u,v]*(7-phai1);
            if free[u,v,m1,m2,m3] and (d[u,v,m1,m2,m3] > x) then
               begin
                 d[u,v,m1,m2,m3] := x;
                 upheap(u,v,m1,m2,m3);
               end;
        end;

procedure dij;
var i,j,k,m1,m2,m3 : longint;
        begin
             repeat
                   i := pos[1].x; j := pos[1].y;
                   m1 := pos[1].truoc; m2 := pos[1].tren;
                   m3 := pos[1].phai;
                   free[i,j,m1,m2,m3] := false;
                   if (i=x2) and (j=y2) then
                    begin
                       res := heap[1];
                       break;
                    end;
                   pop;
                   for k := 1 to 4 do
                       begin
                         if k = 1 then bentren(i,j,k,m1,m2,m3);
                         if k = 2 then benphai(i,j,k,m1,m2,m3);
                         if k = 3 then benduoi(i,j,k,m1,m2,m3);
                         if k = 4 then bentrai(i,j,k,m1,m2,m3);
                       end;
             until false;
        end;

procedure main;
var i,j,m1,m2,m3 : longint;
        begin
           for i := 1 to m do
              for j := 1 to n do
                 for m1 := 1 to 6 do
                    for m2 := 1 to 6 do
                       for m3 := 1 to 6 do
                          begin
                               d[i,j,m1,m2,m3] := 9999999;
                               free[i,j,m1,m2,m3] := true;
                          end;
           d[x1,y1,1,2,3] := w[x1,y1]*5;
           inc(nheap); heap[nheap] := d[x1,y1,1,2,3];
           vt[x1,y1,1,2,3] := 1;
           pos[1].x := x1; pos[1].y := y1;
           pos[1].truoc := 1; pos[1].tren := 2; pos[1].phai := 3;
           dij;
           writeln(fo,res);
           close(fi); close(fo);
        end;

begin
     input;
     main;
end.
