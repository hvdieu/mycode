uses math;
Const   inp = '';
        out = '';
        maxn = 100001;
        maxW = 99999999;
type    canh = record
          x,y,w : longint;
          selected : boolean;
        end;
Var     fi,fo  :      text;
        n,m,nheap,dem1,dem2,vmax,st,r,s    :      longint;
        num,h,cha,thoat,lab  :       array [1..maxn] of longint;
        e                      :       array [1..maxn] of canh;
        f,lmax                 :       array [1..maxn,0..20] of longint;
        a,w1           :       array [1..2*maxn] of longint;
        res            :       qword;

procedure input;
var i,u,v,l : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,n,m);
             for i := 1 to m do
              with e[i] do
              begin
                readln(fi,x,y,w);
                selected := false;
              end;
             for i := 1 to n do lab[i] := -1;
        end;

procedure swap(var xx,yy : canh);
var temp : canh;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure upheap(i : longint);
var cha,con : longint;
        begin
             con := i;
             repeat
                 cha := con div 2;
                 if (cha = 0) or (e[cha].w >= e[con].w) then break;
                 swap(e[cha],e[con]);
                 con := cha;
             until false;
        end;

procedure downheap( i : longint);
var cha,con : longint;
        begin
            cha := i;
            repeat
                 con := cha*2;
                 if (con < nheap) and (e[con].w < e[con+1].w) then inc(con);
                 if (con > nheap) or (e[cha].w >= e[con].w) then break;
                 swap(e[cha],e[con]);
                 cha := con;
            until false;
        end;

function getroot(u : longint) : longint;
          begin
              while lab[u] > 0 do u := lab[u];
              getroot := u;
          end;

procedure union(r1, r2 : longint);
var x : longint;
        begin
            x := lab[r1] + lab[r2];
            if lab[r1] > lab[r2] then
             begin
                lab[r1] := r2;
                lab[r2] := x;
             end
            else begin
                     lab[r1] := x;
                     lab[r2] := r1;
                 end;
        end;

procedure pop;
         begin
              swap(e[1],e[nheap]);
              dec(nheap);
              downheap(1);
         end;

procedure kruskal;
var i,u,v,k : longint;
        begin
            nheap := m;
            for i := m div 2 downto 1 do downheap(i);
            k := 0;
            while k < n-1 do
              begin
                   r := getroot(e[1].x);
                   s := getroot(e[1].y);
                   if r <> s then
                     begin
                         e[1].selected := true;
                         inc(k);
                         union(r,s);
                     end;
                   pop;
              end;
        end;

procedure dfs(u : longint);
var i,v,j : longint;
    begin
         inc(dem1); num[u] := dem1;
         for j := 1 to vmax do
           begin
               f[u,j] := f[f[u,j-1],j-1];
               lmax[u,j] := min(lmax[u,j-1], lmax[f[u,j-1],j-1]);
           end;
         for i := h[u] + 1 to h[u+1] do
           begin
               v := a[i];
               if cha[v] = 0 then
                  begin
                      cha[v] := u;
                      f[v,0] := u; lmax[v,0] := w1[i];
                      dfs(v);
                  end;
           end;
         inc(dem2); thoat[u] := dem2;
    end;

function check(u,v : longint) : boolean;
    begin
        if (num[u] <= num[v]) and (thoat[u] >= thoat[v]) then exit(true)
         else exit(false);
    end;

function lca(u,v : longint) : longint;
var i,u1,ma1 : longint;
    begin
        ma1 := maxlongint;
        if check(u,v) then
           begin
               for i := vmax downto 0 do
                 if check(f[v,i],u) = false then
                 begin
                     ma1 := min(ma1,lmax[v,i]);
                     v := f[v,i];
                 end;
               exit(min(ma1,lmax[v,0]));
           end;
       if check(v,u) then
          begin
              for i := vmax downto 0 do
               if check(f[u,i],v) = false then
                begin
                    ma1 := min(ma1,lmax[u,i]);
                    u := f[u,i];
                end;
              exit(min(ma1,lmax[u,0]));
          end;
       u1 := u;

       for i := vmax downto 0 do
        if check(f[u,i],v) = false then
        begin
           ma1 := min(ma1,lmax[u,i]);
           u := f[u,i];
        end;
      ma1 := min(ma1,lmax[u,0]);

       for i := vmax downto 0 do
        if check(f[v,i],u1) = false then
         begin
            ma1 := min(ma1,lmax[v,i]);
            v := f[v,i];
         end;
       ma1 := min(ma1,lmax[v,0]);
       exit(ma1);
    end;

procedure main;
var i,xx,u : longint;
        begin
            kruskal;
            for i := 1 to m do
              with e[i] do
               if selected then
                 begin
                     inc(h[x]); inc(h[y]);
                 end;
            for i := 2 to n do h[i] := h[i-1] + h[i];
            h[n+1] := 2*(n-1);
            for i := 1 to m do
               with e[i] do
                if selected then
                  begin
                      a[h[x]] := y; w1[h[x]] := w;
                      a[h[y]] := x; w1[h[y]] := w;
                      dec(h[x]); dec(h[y]);
                  end;
             vmax := round(ln(n)/ln(2));
             f[1,0] := 1; cha[1] := 1;
             dfs(1);
             for i := 1 to m do
              with e[i] do
               if selected = false then
               begin
                   xx := lca(x,y);
                   if xx > w then res := res + xx - w;
               end;
             writeln(fo,res);
             close(fi); close(fo);
        end;

begin
     input;
     main;
end.
