USES
        math;
CONST
        tfi     =       '';
        tfo     =       '';
VAR
        fo,fi   :       text;
        n,m     :       longint;
        vt,b,d  :       array[0..100001] of longint;
        s,a,f     :       array[0..100001] of longint;
procedure doi(var q,w:longint);var t:longint;begin t:=q;q:=w;w:=t end;
procedure sort(l,r:longint);
  var i,j,k:longint;
  begin
       i:=l;j:=r;
       k:=b[random(r-l+1)+l];
       repeat
               while b[i]<k do inc(i);
               while b[j]>k do dec(j);
               if i<=j then
                 begin
                      doi(b[i],b[j]);
                      doi(d[i],d[j]);
                      inc(i);dec(j);
                 end;
       until i>j;
       if l<j then sort(l,j);
       if i<r then sort(i,r);
  end;
procedure nhap;
  var i : longint;
  begin
        assign(fi,tfi);reset(fi);
        assign(Fo,tfo);rewrite(fO);
          read(fi,n);
          for i:=1 to n do read(Fi,a[i]);
          s[1]:=a[1];
          for i:=2 to n do s[i]:=s[i-1]+a[i];
          read(fi,m);
          for i:=1 to m do read(Fi,b[i],d[i]);
  end;
procedure Init;
  var j,i:longint;
  begin
       sort(1,m);
       vt[b[1]]:=1;
       j:=1;
       for i:=b[1]+1 to n do
         begin
                if i=b[j+1] then begin vt[i]:=j+1;inc(j) end
                else vt[i]:=vt[i-1];
         end;
  end;
procedure Execute;
  var i,j:longint;
  begin

        for i:=b[1] to n do
          begin
                f[i]:=f[i-1];
                if b[vt[i]]+d[vt[i]]-1>=i then
                  begin
                        if i-d[vt[i]]>=b[vt[i]-1] then
                         f[i]:=max(f[i],f[i-d[vt[i]]]+s[i]-s[i-d[vt[i]]]);
                  end;
          end;
        write(fo,f[n]);
  end;
BEGIN
      nhap;
      Init;
      Execute;
      close(fo);
      close(Fi);
END.
