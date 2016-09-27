USES math;
CONST
   tfi='TFIELD.inp';
   tfo='TFIELD.out';
VAR
   x,y,x1,y1: array[1..1000,1..1000] of longint;
   c,t: array[0..1000] of longint;
   m,i,j,sl: longint;
   ok1,ok2: boolean;
   a,kq: array[0..20] of longint;
   res: extended;

procedure doicho(var x,y: longint);
   var tg: longint; begin tg:=x; x:=y; y:=tg; end;

procedure qs(l,r,v: longint);
   var i,j,k,k1,k2,p: longint;
   begin
      i:=l; j:=r; k:=l+random(r-l+1);
      k1:=y[k,1]; k2:=x[k,1];
      repeat
         while (y[i,1]<k1) or ((y[i,1]=k1) and (x[i,1]<k2)) do inc(i);
         while (y[j,1]>k1) or ((y[j,1]=k1) and (x[j,1]>k2)) do dec(j);
         if i<=j then
            begin
               for p:=1 to v do
                  begin
                     doicho(y[i,p],y[j,p]);
                     doicho(x[i,p],x[j,p]);
                  end;
               doicho(c[i],c[j]);
               doicho(t[i],t[j]);
               inc(i); dec(j);
            end;
      until i>j;
      if i<r then qs(i,r,v);
      if l<j then qs(l,j,v);
   end;

procedure sub1;
   var k,j,p,tg1,tg2,tg3: longint;
   begin
      for i:=1 to m do
         begin
            tg1:=y[i,1]; tg2:=x[i,1]; tg3:=1;
            for j:=1 to 4 do
               begin
                 if (y[i,j]>tg1) or ((y[i,j]=tg1) and (x[i,j]>tg2)) then
                    begin
                       tg1:=y[i,j]; tg2:=x[i,j]; tg3:=j;
                    end;
               end;
            x1[i]:=x[i]; y1[i]:=y[i];
            y[i,1]:=tg1; x[i,1]:=tg2;
            p:=1;
            for j:=tg3+1 to 4 do
               begin
                  inc(p); y[i,p]:=y1[i,j]; x[i,p]:=x1[i,j];
               end;
            for j:=1 to tg3-1 do
               begin
                  inc(p); y[i,p]:=y1[i,j]; x[i,p]:=x1[i,j];
               end;
         end;
      qs(1,m,4);
   end;

procedure sub2;
   var k,j,p,tg1,tg2,tg3: longint;
   begin
      for i:=1 to m do
         begin
            tg1:=y[i,1]; tg2:=x[i,1]; tg3:=1;
            for j:=1 to 3 do
               begin
                 if (y[i,j]>tg1) or ((y[i,j]=tg1) and (x[i,j]>tg2)) then
                    begin
                       tg1:=y[i,j]; tg2:=x[i,j]; tg3:=j;
                    end;
               end;
            x1[i]:=x[i]; y1[i]:=y[i];
            y[i,1]:=tg1; x[i,1]:=tg2;
            p:=1;
            for j:=tg3+1 to 3 do
               begin
                  inc(p); y[i,p]:=y1[i,j]; x[i,p]:=x1[i,j];
               end;
            for j:=1 to tg3-1 do
               begin
                  inc(p); y[i,p]:=y1[i,j]; x[i,p]:=x1[i,j];
               end;
         end;
      qs(1,m,3);
   end;

function kc(x1,y1,x2,y2: extended): extended;
   begin exit(sqrt(sqr(x1-x2)+sqr(y1-y2))); end;

function dientich(i: longint): extended;
   begin exit(kc(x[i,1],y[i,1],x[i,2],y[i,2])*kc(x[i,1],y[i,1],x[i,4],y[i,4])); end;

function tinh(i,j: longint): extended;
   begin if i<>0 then exit(dientich(j)-dientich(i)) else exit(dientich(j)); end;

procedure try1(i,s: longint);
   var j,l,k,mau: longint;
   begin
      if i=m+1 then
         begin
            for mau:=1 to m do
               begin
                  l:=1;
                  for j:=1 to m+1 do
                     if (a[j]=0) and ((a[j-1]=1) or (c[j-1]=mau)) and (c[j]<>mau) then res:=max(res,tinh(l-1,j-1))
                     else if ((a[j]=1) or (c[j]=mau)) and (a[j-1]=0) and (c[j-1]<>mau) then l:=j;
               end;
            exit;
         end;
      a[i]:=1;
      if s<sl then try1(i+1,s+1);
      a[i]:=0;
      try1(i+1,s);
   end;

function dientich1(i: longint): extended;
   var xa,xb,xc,ncv: extended;
   begin
      xa:=kc(x[i,1],y[i,1],x[i,2],y[i,2]);
      xb:=kc(x[i,2],y[i,2],x[i,3],y[i,3]);
      xc:=kc(x[i,1],y[i,1],x[i,3],y[i,3]);
      ncv:=(xa+xb+xc)/2;
      exit(sqrt(ncv*(ncv-xa)*(ncv-xb)*(ncv-xc)));
   end;

function tinh1(i,j: longint): extended;
   begin if i<>0 then exit(dientich1(j)-dientich1(i)) else exit(dientich1(j));  end;

procedure try2(i,s: longint);
   var j,l,k,mau: longint;
   begin
      if i=m+1 then
         begin
            for mau:=1 to m do
               begin
                  l:=1;
                  for j:=1 to m+1 do
                     if (a[j]=0) and ((a[j-1]=1) or (c[j-1]=mau)) and (c[j]<>mau) then
                        begin
                           if res<tinh1(l-1,j-1) then begin res:=max(res,tinh1(l-1,j-1)); kq:=a; end; end
                     else if ((a[j]=1) or (c[j]=mau)) and (a[j-1]=0) and (c[j-1]<>mau) then l:=j;
               end;
            exit;
         end;
      a[i]:=1;
      if s<sl then try2(i+1,s+1);
      a[i]:=0;
      try2(i+1,s);
   end;

procedure sub3;
   begin
   end;

procedure process;
   begin
      read(m,sl);
      if m>20 then begin ok1:=true; ok2:=true; end;
      for i:=1 to m do
         begin
            read(t[i],c[i]);
            if t[i]<>4 then ok1:=true;
            if t[i]<>3 then ok2:=true;
            for j:=1 to t[i] do read(x[i,j],y[i,j]);
         end;
      if not ok1 then
         begin
            sub1;
            try1(1,0);
            writeln(res:0:1);
         end
      else if not ok2 then
         begin
            sub2;
            try2(1,0);
            writeln(res:0:1);
         end
      else sub3;
   end;

BEGIN
   assign(input,tfi); reset(input);
   assign(output,tfo); rewrite(output);
      process;
END.
