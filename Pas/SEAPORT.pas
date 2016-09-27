Const   maxn = 200001;
Var     n,m,i,nn,top,nheap,res     :       longint;
        a,s,f       :       array [1..maxn] of double;
        id,dd,st,pos,heap,kq   :       array [1..maxn] of longint;

procedure dc(var xx,yy : double);
var temp : double;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j : longint;
    k   : double;
        begin
            if l >= h then exit;
            i := l; j := h; k := a[l+random(h-l+1)];
            repeat
                while a[i] < k do inc(i);
                while a[j] > k do dec(j);
                if i <= j then
                  begin
                      if i < j then
                        begin
                            dc(a[i],a[j]);
                            swap(id[i],id[j]);
                            swap(dd[i],dd[j]);
                        end;
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

procedure upheap(i : longint);
var cha,con : longint;
        begin
             con := pos[i];
             repeat
                  cha := con div 2;
                  if (cha = 0) or (f[heap[cha]] >= f[heap[con]]) then break;
                  swap(heap[cha],heap[con]);
                  pos[heap[cha]] := cha; pos[heap[con]] := con;
                  con := cha;
             until false;

        end;

procedure downheap(i : longint);
var cha,con : longint;
        begin
             cha := pos[i];
             repeat
                  con := cha*2;
                  if (con < nheap) and (f[heap[con]] < f[heap[con+1]]) then inc(con);
                  if (con > nheap) or (f[heap[cha]] >= f[heap[con]]) then break;
                  swap(heap[cha],heap[con]);
                  pos[heap[cha]] := cha; pos[heap[con]] := con;
                  cha := con;
             until false;
        end;

procedure push(i : longint);
var temp : longint;
        begin
             inc(nheap); heap[nheap] := i; pos[i] := nheap;
             upheap(i);
        end;

procedure main;
var i,j : longint;
        begin
             sort(1,nn);
             top := m;
             for i := 1 to top do st[i] := i;
             for i := 1 to nn do
               begin
                    if dd[i] = 0 then
                      begin
                          if top > 0 then
                            begin
                                kq[id[i]] := st[top];
                                dec(top);
                                push(id[i]);
                            end
                          else
                            begin
                                if f[heap[1]] > f[id[i]] then
                                  begin
                                       kq[id[i]] := kq[heap[1]];
                                       kq[heap[1]] := 0;
                                       heap[1] := id[i];
                                       pos[id[i]] := 1;
                                       downheap(id[i]);
                                  end;
                            end;
                      end
                    else begin
                              if kq[id[i]] <> 0 then
                                begin
                                    inc(top); st[top] := kq[id[i]];
                                end;
                         end;
               end;
             for i := 1 to n do if kq[i] <> 0 then inc(res);
             writeln(res);
             for i := 1 to n do write(kq[i],' ');
        end;


begin
     assign(input,'SEAPORT.INP'); reset(input);
     assign(output,'SEAPORT.OUT'); rewrite(output);
     readln(m,n);
     for i := 1 to n do
       begin
           read(s[i],f[i]);
           inc(nn); a[nn] := s[i]+0.1; dd[nn] := 0; id[nn] := i;
           inc(nn); a[nn] := f[i]; dd[nn] := 1; id[nn] := i;
       end;
     main;
end.