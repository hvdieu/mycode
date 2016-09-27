CONST
        tfi     ='';
        tfo     ='';
        nmax    =200;
        oo      =(1 shl 62)-1;
TYPE
        arr     =array [1..nmax] of longint;
        arr1    =array [-nmax..nmax] of longint;
        arr2    =array [1..nmax] of int64;
VAR
        fi,fo   :text;
        head,pos,h:arr;
        ke,next,ts:arr1;
        d       :arr2;
        n,m,c,t,u,nheap:longint;
        res     :int64;
 (******************************************************************)
Procedure nhap;
      Var
        i,x,y,z :longint;
      Begin
        read(fi,n,m,c);
        for i:=1 to n do head[i]:=0;
        for i:=1 to m do
          begin
            read(fi,x,y,z);
            ke[i]:=y;
            next[i]:=head[x];
            head[x]:=i;
            ts[i]:=z;
            ke[-i]:=x;
            next[-i]:=head[y];
            head[y]:=-i;
            ts[-i]:=z;
          end;
      End;
 (*******************************************************************)
Procedure doicho(var x,y:longint);
      Var
        tg      :longint;
      Begin
        tg:=x;
        x:=y;
        y:=tg;
      End;
 (******************************************************************)
Procedure upheap(i:longint);
      Begin
        if (i=1) or (d[h[i div 2]]<=d[h[i]]) then exit;
        doicho(h[i],h[i div 2]);
        doicho(pos[h[i div 2]],pos[h[i]]);
        upheap(i div 2);
      End;
 (*******************************************************************)
Procedure downheap(i:longint);
      Var
        j       :longint;
      Begin
        j:=2*i;
        if j>nheap then exit;
        if (j<nheap) and (d[h[j]]>d[h[j+1]]) then inc(j);
        if d[h[j]]<d[h[i]] then
          begin
            doicho(h[i],h[j]);
            doicho(pos[h[i]],pos[h[j]]);
            downheap(j);
          end;
      End;
 (*******************************************************************)
Procedure push(x:longint);
      Begin
        inc(nheap);
        h[nheap]:=x;
        pos[x]:=nheap;
        upheap(nheap);
      End;
 (*******************************************************************)
Procedure pop;
      Begin
        u:=h[1];
        h[1]:=h[nheap];
        pos[h[1]]:=1;
        dec(nheap);
        downheap(1);
      End;
 (********************************************************************)
Function find(x:int64;y:longint):int64;
      Var
        k       :int64;
      Begin
        if c<y then exit(oo);
        if (c=y) and (x<>0) then exit(oo);
        if x=0 then exit(y);
        if c-y>=x then exit(x+y);
        if c<=2*y then exit(oo);
        k:=(x-c+y) div (c-2*y);
        if (x-c+y) mod (c-2*y)<>0 then inc(k);
        find:=2*y*k+y;
        find:=find+x;
      End;
 (********************************************************************)
Procedure lam;
      Var
        j,i     :longint;
        y       :int64;
      Begin
        fillchar(pos,sizeof(pos),0);
        nheap:=0;
        for i:=1 to n do d[i]:=oo;
        d[n]:=0;
        push(n);
        Repeat
          pop;
          if u=1 then
            begin
              res:=d[1];
              exit;
            end;
          j:=head[u];
          while j<>0 do
            begin
              y:=find(d[u],ts[j]);
              if y<d[ke[j]] then
                begin
                  d[ke[j]]:=y;
                  if pos[ke[j]]=0 then push(ke[j])
                  else upheap(pos[ke[j]]);
                end;
              j:=next[j];
            end;
        Until false;
      End;
 (************************************************************************)
Procedure inkq;
      Begin
        writeln(fo,res);
      End;
 (************************************************************************)
BEGIN
  assign(fi,tfi);reset(fi);
  assign(fo,tfo);rewrite(fo);
        read(fi,t);
        while t<>0 do
          begin
            nhap;
            lam;
            inkq;
            dec(t);
          end;
  close(fi);
  close(fo);
END.

