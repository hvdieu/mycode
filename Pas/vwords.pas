{$h+}
USES math;
CONST
        tfi     ='vwords.inp';
        tfo     ='vwords.out';
        nmax    =42;
TYPE
        arr     =array [1..nmax] of  string;
        arr1    =array [1..5000] of boolean;
        arr2    =array [1..5000] of longint;
VAR
        fi,fo   :text;
        s       :arr;
        head,qx,qy,d:arr2;
        free    :arr1;
        n,res,r,f,u,v:longint;
        dd      :boolean;
 (**********************************************************************)
Procedure nhap;
      Var
        i       :longint;
        w       :longint;
        ch      :char;
      Begin
        assign(fi,tfi);reset(fi);
          readln(fi,n);
          n:=n+2;
          for i:=1 to n do
            begin
              if i>1 then head[i]:=head[i-1]+length(s[i-1]);
              read(fi,w);
              read(fi,ch);
              readln(fi,s[i]);
            end;
        close(fi);
      End;
 (*********************************************************************)
Procedure push(x,y:longint);
      Begin
        inc(r);
        qx[r]:=x;
        qy[r]:=y;
      End;
 (*********************************************************************)
Procedure pop;
      Begin
        u:=qx[f];
        v:=qy[f];
        inc(f);
      End;
 (*********************************************************************)
Procedure lam;
      Var
        i,x,y:longint;
      Begin
        dd:=false;
        i:=1;
        while (i<=min(length(s[1]),length(s[2]))) and (s[1,i]=s[2,i]) do inc(i);
        if i<>min(length(s[1]),length(s[2]))+1 then exit;
        if length(s[1])=length(s[2]) then
          begin
            dd:=true;
            exit;
          end;
        if length(s[2])>length(s[1]) then push(2,i)
        else push(1,i);
        f:=1;
        while f<=r do
          begin
            pop;
            for i:=3 to n do
              begin
                x:=1;
                y:=v;
                while (x<=length(s[i])) and (y<=length(s[u])) and
                (s[i,x]=s[u,y]) do
                  begin
                    inc(x);
                    inc(y);
                  end;
                if (x>length(s[i])) and (y>length(s[u])) then
                  begin
                    dd:=true;
                    res:=d[head[u]+v]+1;
                    exit;
                  end;
                if (x>length(s[i])) or (y>length(s[u])) then
                  begin
                    if (x>length(s[i])) then
                    begin
                    if (free[head[u]+y]=false) then
                      begin
                        free[head[u]+y]:=true;
                        d[head[u]+y]:=d[head[u]+v]+1;
                        push(u,y);
                      end
                    end
                    else if free[head[i]+x]=false then
                      begin
                        free[head[i]+x]:=true;
                        d[head[i]+x]:=d[head[u]+v]+1;
                        push(i,x);
                      end;
                  end;
              end;
          end;
      End;
 (**********************************************************************)
Procedure inkq;
      Begin
        assign(fo,tfo);rewrite(fo);
          if dd=false then write(fo,'NIE') else write(fo,res);
        close(fo);
      End;
 (*********************************************************************)
BEGIN
        nhap;
        lam;
        inkq;
END.

