CONST
        tfi     ='dtograda.inp';
        tfo     ='dtograda.ou1';
        nmax    =1000000;
TYPE
        arr     =array [1..nmax] of longint;
Var
        fi,fo   :text;
        n,k,top,t,dem:longint;
        h,st,l,f:arr;
        res     :int64;
 (**********************************************************************)
Procedure nhap;
      Var
        i       :longint;
      Begin
        assign(fi,tfi);reset(fi);
          read(fi,n,k);
          for i:=1 to n do read(fi,h[i]);
        close(fi);
      End;
 (********************************************************************)
Procedure push(x:longint);
      Begin
        inc(top);
        st[top]:=x;
      End;
 (*********************************************************************)
Procedure khoitao;
      Var
        i       :longint;
      Begin
        push(1);
        t:=1;
        if k=1 then l[1]:=h[1];
        for i:=2 to n do
          begin
            if i-st[t]>=k then inc(t);
            while (top>=t) and (h[i]<=h[st[top]]) do dec(top);
            push(i);
            if i>=k then l[i]:=h[st[t]];
          end;
      End;
 (***********************************************************************)
Procedure xuli;
      Var
        i,m     :longint;
      Begin
        top:=0;
        push(k);
        f[1]:=l[k];
        t:=1;
        for i:=k+1 to n do
          begin
            if i-st[t]>=k then inc(t);
            while (top>=t) and (l[i]>=l[st[top]]) do dec(top);
            push(i);
            f[i-k+1]:=l[st[t]];
          end;
        for i:=n-k+2 to n do
          begin
            if st[t]-i<0 then inc(t);
            f[i]:=l[st[t]];
          end;
        for i:=1 to n do res:=res+h[i]-f[i];
        dem:=1;
        m:=1;
        for i:=2 to n do
          begin
            if (f[i]<>f[i-1]) or (m=k) then
              begin
                inc(dem);
                m:=0;
              end;
            inc(m);
          end;
      End;
 (***********************************************************************)
Procedure inkq;
      Begin
        assign(fo,tfo);rewrite(fo);
          writeln(fo,res);
          writeln(fo,dem);
        close(fo);
      End;
 (********************************************************************)
BEGIN
        nhap;
        khoitao;
        xuli;
        inkq;
END.

