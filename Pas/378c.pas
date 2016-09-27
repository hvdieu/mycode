Const   inp = '';
        out = '';
        maxn = 501;
        h : array [1..4] of integer = (-1,0,1,0);
        c : array [1..4] of integer = (0,1,0,-1);

Var     a       :       array [0..maxn,0..maxn] of char;
        free    :       array [0..maxn,0..maxn] of boolean;
        deg,pi,pj,pos     :       array [0..maxn,0..maxn] of longint;
        m,n,k,i,j,nheap,u,v,top   :       longint;
        hi,hj,si,sj   :       array [1..maxn*maxn] of longint;

procedure dfs(i,j : longint);
var k : longint;
        begin
            free[i,j] := false;
            for k := 1 to 4 do
              begin
                  u := i+h[k]; v := j+c[k];
                  if free[u,v] and (a[u,v]<> '#') then
                    begin
                        inc(deg[i,j]);
                        inc(deg[u,v]);
                        pi[u,v]:=i; pj[u,v] := j;
                        dfs(u,v);
                    end;
              end;
        end;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure upheap(i,j : longint);
var cha,con : longint;
        begin
            con := pos[i,j];
            repeat
              cha := con div 2;
              if (cha=0) or (deg[hi[cha],hj[cha]]<=deg[hi[con],hj[con]]) then break;
              swap(hi[cha],hi[con]); swap(hj[cha],hj[con]);
              pos[hi[cha],hj[cha]] := cha; pos[hi[con],hj[con]] := con;
              con:=cha;
            until false;
        end;

procedure pop;
var cha,con : longint;
        begin
            u := hi[1]; v := hj[1]; hi[1] := hi[nheap]; hj[1] := hj[nheap];
            pos[hi[1],hj[1]] :=1; dec(nheap); cha:= 1;
            repeat
                con :=cha*2;
                if (con<nheap) and (deg[hi[con],hj[con]]>deg[hi[con+1],hj[con+1]]) then inc(con);
                if (con>nheap) or (deg[hi[cha],hj[cha]]<=deg[hi[con],hj[con]]) then break;
                swap(hi[cha],hi[con]); swap(hj[cha],hj[con]);
              pos[hi[cha],hj[cha]] := cha; pos[hi[con],hj[con]] := con;
              cha:=con;
            until false;
        end;

procedure insert(i,j : longint);
        begin
            inc(nheap); hi[nheap] := i; hj[nheap] := j; pos[i,j] := nheap;
            upheap(i,j);
        end;

procedure main;
var i,j,x : longint;
        begin
           for i := 1 to m do
            for j := 1 to n do
             if a[i,j]<>'#' then insert(i,j);
           while k > 0 do
             begin
                 top := 0;
                 pop; a[u,v] := 'X'; x := deg[u,v]; dec(k);
                 if (pi[u,v]<>0) and (pi[u,v]<>0) then
                  begin
                     inc(top); si[top] := pi[u,v]; sj[top] := pj[u,v];
                  end;

                 while (k > 0) and (nheap > 0) and (deg[hi[1],hj[1]]=x) do
                   begin
                       pop; a[u,v] := 'X'; dec(k);
                       if (pi[u,v]<>0) and (pi[u,v]<>0) then
                           begin
                            inc(top); si[top] := pi[u,v]; sj[top] := pj[u,v];
                           end;
                   end;
                 for j := 1 to top do
                   begin
                      dec(deg[si[j],sj[j]]); upheap(si[j],sj[j]);
                   end;
             end;
           for i := 1 to m do
             begin
                 for j := 1 to n do write(a[i,j]);
                 writeln;
             end;
        end;



begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(m,n,k);
     for i := 1 to m do
      begin
          for j := 1 to n do read(a[i,j]);
          readln;
      end;
     for i := 1 to m do
      for j := 1 to n do free[i,j] := true;
     for i := 1 to m do
      for j := 1 to n do
       if free[i,j] and (a[i,j] <> '#') then
        dfs(i,j);
     main;
end.