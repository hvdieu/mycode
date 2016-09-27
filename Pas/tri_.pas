USES math;
CONST
        tfi     ='tri_.inp';
        tfo     ='tri.out';
        nmax    =100000;
        e       =0.00000000001;
TYPE
        arr     =array [1..nmax,1..2] of longint;
        arr1    =array [1..nmax] of real;
        arr2    =array [1..nmax] of longint;
        arr3    =array [0..nmax*3] of longint;
        arr4    =array [1..nmax*17,1..2] of longint;
        arr5    =array [1..2] of longint;
VAR
        fi,fo   :text;
        n,m,count:longint;
        a,b,c,aa:arr;
        s,d,g   :arr1;
        px,py,pz:arr3;
        st      :arr4;
        h       :int64;
 (***********************************************************************)
Procedure nhap;
      Var
        i       :longint;
      Begin
          read(fi,n,m);
          for i:=1 to n do read(fi,a[i,1],a[i,2]);
          for i:=1 to m do read(fi,b[i,1],b[i,2],c[i,1],c[i,2]);
      End;
 (**********************************************************************)
Procedure doicho(var x,y:real);
      Var
        tg      :real;
      Begin
        tg:=x;
        x:=y;
        y:=tg;
      End;
 (***********************************************************************)
Procedure doicho2(var x,y:longint);
      Var
        tg      :longint;
      Begin
        tg:=x;
        x:=y;
        y:=tg;
      End;
 (**********************************************************************)
Procedure sort(l,r:longint);
      Var
        i,j     :longint;
        key     :real;
      Begin
        i:=l;j:=r;key:=s[l+random(r-l+1)];
        Repeat
          while s[i]<key do inc(i);
          while s[j]>key do dec(j);
          if i<=j then
            begin
              doicho(s[i],s[j]);
              doicho2(a[i,1],a[j,1]);
              doicho2(a[i,2],a[j,2]);
              inc(i);
              dec(j);
            end;
        Until i>j;
        if i<r then sort(i,r);
        if l<j then sort(l,j);
      End;
 (***********************************************************************)
Procedure khoitao;
      Var
        i       :longint;
      Begin
        for i:=1 to n do
          s[i]:=a[i,1]/(sqrt(sqr(int64(a[i,1]))+sqr(int64(a[i,2]))));
        sort(1,n);
      End;
 (***********************************************************************)
Procedure sort2(l,r:longint);
      Var
        i,j,x   :longint;
        key,key2:double;
      Begin
        i:=l;j:=r;
        x:=l+random(r-l+1);
        key:=g[x];
        key2:=d[x];
        Repeat
          while (g[i]<key) or ((g[i]=key) and (d[i]<key2)) do inc(i);
          while (g[j]>key) or ((g[j]=key) and (d[j]>key2)) do dec(j);
          if i<=j then
            begin
              doicho(g[i],g[j]);
              doicho(d[i],d[j]);
              doicho2(aa[i,1],aa[j,1]);doicho2(aa[i,2],aa[j,2]);
              inc(i);
              dec(j);
            end;
        Until i>j;
        if i<r then sort2(i,r);
        if l<j then sort2(l,j);
      End;
 (**********************************************************************)
Function ccw(a,b,c:arr5):longint;
      Var
        x,y,p,q :longint;
        t       :int64;
      Begin
        x:=b[1]-a[1];
        y:=b[2]-a[2];
        p:=c[1]-b[1];
        q:=c[2]-b[2];
        t:=int64(x)*q-int64(y)*p;
        if t=0 then exit(0)
        else if t>0 then exit(1)
        else exit(-1);
      End;
 (**********************************************************************)
Procedure init(s,l,r:longint);
      Var
        i,u,v,p,q,j:longint;
        k       :real;
      Begin
        if l=r then
          begin
            inc(count);px[s]:=count;py[s]:=count;
            st[count]:=a[l];
            exit;
          end;
        init(2*s,l,(l+r) div 2);
        init(2*s+1,(l+r) div 2+1,r);
        u:=px[2*s];v:=px[2*s+1];
        inc(count);px[s]:=count;
        if (st[u,2]<st[v,2]) or ((st[u,2]=st[v,2]) and (st[u,1]<st[v,1])) then
        st[count]:=st[u] else st[count]:=st[v];
        for i:=l to r do aa[i]:=a[i];
        for i:=l to r do
          if a[i,1]<>st[count,1] then
            begin
              k:=arctan((a[i,2]-st[count,2])/(a[i,1]-st[count,1]));
              d[i]:=sqrt(sqr(int64(a[i,2])-st[count,2])+sqr(int64(a[i,1])-st[count,1]));
              if a[i,1]-st[count,1]<0 then k:=k+pi;
              g[i]:=k;
            end
          else if a[i,2]<>st[count,2] then g[i]:=pi/2 else g[i]:=-1;
        sort2(l,r);
        j:=l;
        while g[j]=-1 do inc(j);
        inc(count);st[count]:=aa[j];
        for i:=j+1 to r do
          begin
            while (count<>px[s]) and (ccw(st[count-1],st[count],aa[i])<>1) do dec(count);
            inc(count);st[count]:=aa[i];
          end;
        py[s]:=count;
        pz[s]:=py[s];
        for i:=px[s] to py[s]-1 do if st[i,2]>st[i+1,2] then
          begin
            pz[s]:=i;
            exit;
          end;
      End;
 (***********************************************************************)
Procedure find2(s,a,b:longint);
      Var
        l,r,mid :longint;
        c1,c2,c3:int64;
      Begin
        if px[s]=py[s] then
          begin
            h:=max(h,int64(a)*st[px[s],1]+int64(b)*st[py[s],2]);
            exit;
          end;
        l:=px[s];r:=pz[s];
        h:=max(h,int64(a)*st[l,1]+int64(b)*st[l,2]);
        h:=max(h,int64(a)*st[r,1]+int64(b)*st[r,2]);
        inc(l);dec(r);
        while l<=r do
          begin
            mid:=(l+r) div 2;
            c1:=int64(a)*st[mid-1,1]+int64(b)*st[mid-1,2];
            c2:=int64(a)*st[mid,1]+int64(b)*st[mid,2];
            c3:=int64(a)*st[mid+1,1]+int64(b)*st[mid+1,2];
            //h:=max(max(h,c1),max(c3,c2));
            if (c1<=c2) and (c3<=c2) then
              begin
                h:=max(h,c2);
                break;
              end
            else if c3>c2 then l:=mid+1
            else r:=mid-1;
          end;
        if pz[s]=py[s] then exit;
        l:=pz[s]+1;r:=py[s];
        h:=max(h,int64(a)*st[l,1]+int64(b)*st[l,2]);
        h:=max(h,int64(a)*st[r,1]+int64(b)*st[r,2]);
        inc(l);dec(r);
        while l<=r do
          begin
            mid:=(l+r) div 2;
            c1:=int64(a)*st[mid-1,1]+int64(b)*st[mid-1,2];
            c2:=int64(a)*st[mid,1]+int64(b)*st[mid,2];
            c3:=int64(a)*st[mid+1,1]+int64(b)*st[mid+1,2];
            //h:=max(max(h,c1),max(c3,c2));
            if (c1<=c2) and (c3<=c2) then
              begin
                h:=max(h,c2);
                break
              end
            else if c3>c2 then l:=mid+1
            else r:=mid-1;
          end;
      End;
 (**********************************************************************)
Procedure get(s,l,r,u,v,a,b:longint);
      Begin
        if (v<l) or (r<u) then exit;
        if (u<=l) and (r<=v) then
          begin
            find2(s,a,b);
            exit;
          end;
        get(2*s,l,(l+r) div 2,u,v,a,b);
        get(2*s+1,(l+r) div 2+1,r,u,v,a,b);
      End;
 (************************************************************************)
Function findmin(x:real):longint;
      Var
        l,r,mid :longint;
      Begin
        findmin:=n+1;
        l:=1;r:=n;
        while l<=r do
          begin
            mid:=(l+r) div 2;
            if s[mid]>=x then
              begin
                findmin:=mid;
                r:=mid-1;
              end
            else l:=mid+1;
          end;
      End;
 (***********************************************************************)
Function findmax(x:real):longint;
      Var
        l,r,mid :longint;
      Begin
        findmax:=0;
        l:=1;r:=n;
        while l<=r do
          begin
            mid:=(l+r) div 2;
            if s[mid]<=x then
              begin
                findmax:=mid;
                l:=mid+1;
              end
            else r:=mid-1;
          end;
      End;
 (***********************************************************************)
Procedure lam;
      Var
        i,l,r,aa,bb,j:longint;
        u,v     :real;
        cc      :int64;
      Begin
        for i:=1 to m do
          begin
            u:=b[i,1]/(sqrt(sqr(int64(b[i,1]))+sqr(int64(b[i,2]))));
            v:=c[i,1]/(sqrt(sqr(int64(c[i,1]))+sqr(int64(c[i,2]))));
            if u>v then doicho(u,v);
            if (i = 358) then
              begin
                  cc := -1;
              end;
            l:=findmin(u);r:=findmax(v);
            if r<l then writeln(fo,'N')
            else
              begin
                aa:=b[i,2]-c[i,2];bb:=c[i,1]-b[i,1];
                cc:=-int64(aa)*int64(b[i,1])-int64(bb)*int64(b[i,2]);
                if cc<0 then
                  begin
                    aa:=-aa;bb:=-bb;cc:=-cc;
                  end;
                h:=-cc-1;
                get(1,1,n,l,r,aa,bb);
                if h+cc>0 then writeln(fo,'Y') else writeln(fo,'N');
              end;
          end;
      End;
 (*************************************************************************)
BEGIN
      assign(fi,tfi);reset(fi);
      assign(fo,tfo);rewrite(fo);
        nhap;
        khoitao;
        init(1,1,n);
        lam;
      close(fi);
      close(fo);
END.


