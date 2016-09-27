CONST
        tfi     ='vmsincos.inp';
        tfo     ='vmsincos.ou2';
        nmax    =50001;
TYPE
        arr     =array [0..nmax] of real;
        arr1    =array [0..nmax] of longint;
        arr2    =array [0..nmax,0..6] of real;
VAR
        fi,fo   :text;
        n,m,root,e:longint;
        a,tt2,t :arr;
        l,r,con,pa,tt:arr1;
        hc,gc,hs,gs:arr2;
        res     :real;
 (********************************************************************)
Procedure doicho(var x,y:real);
      Var
        tg      :real;
      Begin
        tg:=x;
        x:=y;
        y:=tg;
      End;
 (*********************************************************************)
Procedure doicho2(var x,y:longint);
      Var
        tg      :longint;
      Begin
        tg:=x;
        x:=y;
        y:=tg;
      End;
 (*********************************************************************)
Procedure sub1;
      Var
        i,u,v,j :longint;
        ch      :char;
        x       :real;
      Begin
        for i:=1 to m do
          begin
            read(fi,ch);
            if (ch='S') or (ch='C') then
              begin
                read(fi,ch,ch);
                read(fi,u,v,x);
                res:=0;
                if ch='n' then
                  for j:=u to v do res:=res+sin(a[j]-x)
                else for j:=u to v do res:=res+cos(a[j]-x);
                writeln(fo,res:0:9);
              end
            else if ch='R' then
              begin
                read(fi,ch,ch,ch,ch,ch,ch);
                read(fi,u,v);
                while u<v do
                  begin
                    doicho(a[u],a[v]);
                    inc(u);
                    dec(v);
                  end;
              end
            else
              begin
                read(fi,ch);
                if ch='o' then
                  begin
                    read(fi,ch,ch,ch,ch,u,x);
                    a[u]:=x;
                  end
                else
                  begin
                    read(fi,ch,u,v,x);
                    for j:=u to v do a[j]:=a[j]*x;
                  end;
              end;
            readln(fi);
          end;
      End;
 (********************************************************************)
Procedure change(i:longint;x:real);
      Var
        j      :longint;
        v      :int64;
        k      :real;
      Begin
         k:=1;
         v:=1;
         hc[i,0]:=0;hs[i,0]:=0;
         for j:=1 to 6 do
           begin
             k:=k*x*x;
             v:=v*(2*j-1)*(2*j);
             hc[i,j]:=k/v;
             if j mod 2=1 then hc[i,j]:=-hc[i,j];
             hs[i,j]:=hc[i,j]*x/(2*j+1);
             hc[i,0]:=hc[i,0]+hc[i,j];
             hs[i,0]:=hs[i,0]+hs[i,j];
           end;
      End;
 (************************************************************************)
Procedure update(i:longint);
      Var
        j       :longint;
        u,v     :extended;
      Begin
        u:=1;v:=1;gc[i,0]:=0;gs[i,0]:=0;
        for j:=1 to 6 do
          begin
            u:=u*tt2[l[i]]*tt2[l[i]];
            v:=v*tt2[r[i]]*tt2[r[i]];
            gc[i,j]:=gc[l[i],j]*u+gc[r[i],j]*v+hc[i,j];
            gs[i,j]:=gs[l[i],j]*u*tt2[l[i]]+gs[r[i],j]*v*tt2[r[i]]+hs[i,j];
            gs[i,0]:=gs[i,0]+gs[i,j];
            gc[i,0]:=gc[i,0]+gc[i,j];
          end;
        t[i]:=t[l[i]]*tt2[l[i]]+t[r[i]]*tt2[r[i]]+a[i];
        con[i]:=con[l[i]]+con[r[i]]+1;
      End;
 (*********************************************************************)
Procedure setlink(i,j,ok:longint);
      Begin
        pa[j]:=i;
        if ok=1 then l[i]:=j else r[i]:=j;
      End;
 (*********************************************************************)
Procedure new(i:longint);
      Var
        j       :longint;
        u       :extended;
      Begin
        if tt[i]<>0 then
          begin
            doicho2(l[i],r[i]);
            tt[l[i]]:=1-tt[l[i]];
            tt[r[i]]:=1-tt[r[i]];
            tt[i]:=0;
            tt[0]:=0;
          end;
        if tt2[i]=1 then exit;
        a[i]:=a[i]*tt2[i];change(i,a[i]);t[i]:=t[i]*tt2[i];
        gc[i,0]:=0;gs[i,0]:=0;u:=1;
        for j:=1 to 6 do
          begin
            u:=u*tt2[i]*tt2[i];
            gc[i,j]:=gc[i,j]*u;
            gs[i,j]:=gs[i,j]*u*tt2[i];
            gc[i,0]:=gc[i,0]+gc[i,j];
            gs[i,0]:=gs[i,0]+gs[i,j];
          end;
        tt2[l[i]]:=tt2[l[i]]*tt2[i];
        tt2[r[i]]:=tt2[r[i]]*tt2[i];
        tt2[i]:=1;
      End;
 (**********************************************************************)
Function khoitao(l,r:longint):longint;
      Var
        mid     :longint;
      Begin
        if l>r then exit(0);
        mid:=(l+r) div 2;
        setlink(mid,khoitao(l,mid-1),1) ;
        setlink(mid,khoitao(mid+1,r),2);
        update(mid) ;
        exit(mid);
      End;
 (**********************************************************************)
Procedure uptree(i:longint);
      Var
        p,pp    :longint;
      Begin
        p:=pa[i];
        pp:=pa[p];
        if l[p]=i then
          begin
            setlink(p,r[i],1);
            setlink(i,p,2);
          end
        else
          begin
            setlink(p,l[i],2);
            setlink(i,p,1);
          end;
        update(p);
        update(i);
        if pp<>0 then
          begin
            if l[pp]=p then setlink(pp,i,1)
            else setlink(pp,i,2);
          end else pa[i]:=0;
      End;
 (***********************************************************************)
Procedure splay(i:longint);
      Var
        p,pp    :longint;
      Begin
        while pa[i]<>0 do
          begin
            p:=pa[i];
            pp:=pa[p];
            if pp<>0 then
              begin
                if (l[p]=i)=(l[pp]=p) then uptree(p) else uptree(i);
              end;
            uptree(i);
          end;
      End;
 (**********************************************************************)
Procedure up(i:longint);
      Var
        j       :longint;
      Begin
        j:=i;
        while i<>0 do
          begin
            update(i);
            i:=pa[i];
          end;
        splay(j);
      End;
 (***********************************************************************)
Function find(i,x:longint):longint;
      Begin
        Repeat
          new(i);
          if con[l[i]]+1=x then exit(i);
          if con[l[i]]>=x then i:=l[i] else
            begin
              if r[i]=0 then exit(i);
              x:=x-1-con[l[i]];
              i:=r[i];
            end;
        Until false;
      End;
 (***********************************************************************)
Procedure cut(i,u:longint;var t1,t2:longint);
      Begin
        if u=1 then
          begin
            t1:=0;
            t2:=i;
            exit;
          end;
        if u=con[i]+1 then
          begin
            t1:=i;
            t2:=0;
            exit;
          end;
        i:=find(i,u);
        splay(i);
        t1:=l[i];
        t2:=i;
        l[i]:=0;
        update(i);
        pa[t1]:=0;
      End;
 (************************************************************************)
Function union(t1,t2:longint):longint;
      Begin
        if t1=0 then exit(t2);
        new(t1);
        while r[t1]<>0 do
          begin
            t1:=r[t1];
            new(t1);
          end;
        setlink(t1,t2,2);
        up(t1);
        exit(t1);
      End;
 (*************************************************************************)
Procedure tinh(u,v:longint;x:real;ok:longint);
       Var
        t1,t2,t3        :longint;
      Begin
        cut(root,u,t1,t2);
        cut(t2,v-u+2,t2,t3);
        if ok=2 then res:=(con[t2]+gc[t2,0])*cos(x)+(t[t2]+gs[t2,0])*sin(x)
        else res:=(t[t2]+gs[t2,0])*cos(x)-(con[t2]+gc[t2,0])*sin(x);
        root:=union(t1,t2);
        root:=union(root,t3);
      End;
 (************************************************************************)
Procedure swap(u,v:longint);
      Var
        t1,t2,t3        :longint;
      Begin
        cut(root,u,t1,t2);
        cut(t2,v-u+2,t2,t3);
        tt[t2]:=1-tt[t2];
        root:=union(t2,t3);
        root:=union(t1,root);
      End;
 (************************************************************************)
Procedure mul(u,v:longint;x:real);
      Var
        t1,t2,t3        :longint;
      Begin
        cut(root,u,t1,t2);
        cut(t2,v-u+2,t2,t3);
        tt2[t2]:=tt2[t2]*x;
        root:=union(t2,t3);
        root:=union(t1,root);
      End;
 (*************************************************************************)
Procedure sub2;
      Var
        i,u,v,j,k:longint;
        ch      :char;
        x       :real;
      Begin
        for i:=1 to n do
          begin
            change(i,a[i]);
            tt2[i]:=1;
          end;
        root:=khoitao(1,n);
        for i:=1 to m do
          begin
            read(fi,ch);
            if ch='M' then
              begin
                read(fi,ch);
                if ch='o' then
                  begin
                    read(fi,ch,ch,ch,ch,u,x);
                    u:=find(root,u);
                    a[u]:=x;change(u,x);
                    while u<>0 do
                      begin
                        update(u);
                        u:=pa[u];
                      end;
                  end
                else
                  begin
                    read(fi,ch,u,v,x);
                    mul(u,v,x);
                  end;
              end
            else if (ch='C') or (ch='S') then
              begin
                res:=0;
                read(fi,ch,ch,u,v,x);
                if ch='n' then tinh(u,v,x,1) else tinh(u,v,x,2);
                writeln(fo,res:0:9);
              end
            else if ch='R' then
              begin
                read(fi,ch,ch,ch,ch,ch,ch);
                read(fi,u,v);
                swap(u,v);
              end;
            readln(fi);
          end;
      End;
 (********************************************************************)
BEGIN
      assign(fi,tfi);reset(fi);
      assign(fo,tfo);rewrite(fo);
        readln(fi,n);
        for e:=1 to n do read(fi,a[e]);
        readln(fi);
        readln(fi,m);
        if (n<=5000) and (m<=5000) then sub1 else
        sub2;
      close(fi);
      close(fo);
END.




