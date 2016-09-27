Const   inp = 'airlines.inp';
        out = 'airlines.out';
        maxn = 101;
        maxw = 999999999;

type    dinh = record
        x,y : longint;
        end;
        dinh1 = record
        x1,y1,k1 : longint;
        end;

Var     fi,fo   :       text;
        a    :       array [1..maxn,1..maxn,1..16] of boolean;
        d,pos       :       array [1..maxn,1..16] of longint;
        trace       :       array [1..maxn,1..16] of dinh;
        kq      :   array [1..maxn*maxn] of dinh1;
        free        :       array [1..maxn,1..16] of boolean;
        heapi,heapj     :       array [1..maxn*16] of longint;
        m,n,c,t,s,f,nheap,u,v,res,rx,ry     :       longint;

procedure input;
var i,j,u,v,k : longint;
        begin
              assign(fi,inp); reset(fi);
              assign(fo,out); rewrite(fo);
              readln(fi,n,m,c,t,s,f);
              for i := 1 to m do
                begin
                     read(fi,u,v);
                     while not eoln(fi) do
                       begin
                            read(fi,k);
                            a[u,v,k] := true;
                            a[v,u,k] := true;
                       end;
                end;
        end;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure update(cha,con : longint);
        begin
            swap(heapi[cha],heapi[con]);
            swap(heapj[cha],heapj[con]);
            pos[heapi[cha],heapj[cha]] := cha;
            pos[heapi[con],heapj[con]] := con;
        end;

procedure upheap(i,j : longint);
var cha,con : longint;
        begin
             con := pos[i,j];
             if con = 0 then
               begin
                    inc(nheap); heapi[nheap] := i;
                    heapj[nheap] := j;
                    pos[i,j] := nheap; con := nheap;
               end;

             repeat
                   cha := con div 2;
                   if (cha=0) or (d[heapi[cha],heapj[cha]] <= d[heapi[con],heapj[con]]) then break;
                   update(cha,con);
                   con := cha;
            until false;
        end;

procedure downheap(i,j : longint);
var cha,con : longint;
        begin
            cha := pos[i,j];
            repeat
               con := cha * 2;
               if (con<nheap) and (d[heapi[con],heapj[con]] > d[heapi[con+1],heapj[con+1]]) then inc(con);
               if (con>nheap) or (d[heapi[cha],heapj[cha]] <= d[heapi[con],heapj[con]]) then break;
               update(cha,con);
               cha := con;
            until false;
        end;

procedure pop;
        begin
            u := heapi[1]; v := heapj[1];
            heapi[1] := heapi[nheap];
            heapj[1] := heapj[nheap];
            dec(nheap);
            pos[heapi[1],heapj[1]] := 1;
            downheap(heapi[1],heapj[1]);
        end;

procedure Dij;
var i,j,k : longint;
        begin
             for i := 1 to n do
              for k := 1 to 16 do d[i,k] := maxw;
              fillchar(free,sizeof(free),true);
             for k := 1 to 16 do
              free[s,k] := false;
             for i := 1 to n do
              for k := 1 to 16 do
              if a[s,i,k] = true then
               begin
                   d[i,k] := c;
                   trace[i,k].x := s;
                   trace[i,k].y := k;
                   upheap(i,k);
               end;

             repeat
                   pop;
                   if u = f then
                    begin
                      res := d[u,v];
                      rx := u; ry := v;
                      break;
                    end;
                   free[u,v] := false;
                   for i := 1 to n do
                    for k := 1 to 16 do
                     if free[i,k] and a[u,i,k] then
                        begin
                            if (k = v) and (d[i,k] > d[u,v] + c) then
                             begin
                                 d[i,k] := d[u,v] + c;
                                 trace[i,k].x := u;
                                 trace[i,k].y := v;
                                 upheap(i,k);
                             end
                            else if (k <> v) and (d[i,k] > d[u,v] + c + t) then
                                 begin
                                    d[i,k] := d[u,v] + c + t;
                                    trace[i,k].x := u;
                                    trace[i,k].y := v;
                                    upheap(i,k);
                                 end;
                        end;
             until false;
        end;

procedure output;
var i,j,dem,u,v : longint;
        begin
             i := rx; j := ry;
             dem := 0;
             writeln(fo,res);
             repeat
                 inc(dem);
                 kq[dem].x1 := trace[i,j].x;
                 kq[dem].y1 := i;
                 kq[dem].k1 := j;
                 u := i; v := j;
                 i := trace[u,v].x;
                 j := trace[u,v].y;
             until i = s;
             for i := dem downto 1 do
              with kq[i] do
               writeln(fo,x1,' ',y1,' ',k1);
        end;

procedure main;
        begin
             dij;
             output;
             close(fi); close(fo);
        end;

begin
     input;
     main;
end.