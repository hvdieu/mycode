{$INLINE ON}
uses math,windows ;
var
        n,m,vmax,umax,time: longint;
        kq,ad,next,t,head:array[0..30010] of longint;
procedure up(i,j: longint); inline ;
begin
   while i>0 do
    begin
      t[i] := max(t[i],j);
      i := i - i and (-i);
    end;
end;
function get(i:longint) :longint; inline ;
begin
   get := 0;
   while i <= vmax do
    begin
      get := max(get,t[i]);
      i := i + i and (-i);
    end;
end ;
procedure process;
var i,j,k,u,v:longint;
begin
   read(n);
   for i := 1 to n do
    begin
      read(u,v);
      ad[i] := v;next[i] := head[u];head[u] := i ;
      umax := max(umax,u) ;
      vmax := max(vmax,v) ;
    end;
    for i := 1 to umax do if head[i]<>0 then
     begin
      j:= head[i];
      while j <> 0 do
      begin
         kq[j] := get(ad[j]+1)+1;
         j := next[j];
      end ;
      j := head[i];
      while j <> 0 do
       begin
         up(ad[j],kq[j]) ;
         j := next[j];
       end;
     end ;
     for i := 1 to n do writeln(kq[i]) ;
end;
begin
        time := gettickcount;
        assign(input,'bietthu.inp') ;reset(input);
        assign(output,'SKWLTH1.out') ; rewrite(output) ;
        process;
       // write('Time= ',gettickcount-time);
end .
