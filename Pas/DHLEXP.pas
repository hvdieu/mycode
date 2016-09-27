Uses math;
Const   inp = 'asdasd.inp';
        out = 'asd.out';
        maxn = 1000;
        oo = 1000000009;

Var     n,m,ntest,i,top : longint;
        s : string;
        st : array [1..maxn] of longint;
        l,r,kind : array [1..maxn] of longint;
        f : array [1..maxn,0..1] of qword;
        ke,next : array [1..maxn] of longint;
        ss : array [1..maxn] of string;
        x,res : qword;

procedure push(num : longint);
  begin
      inc(top);
      st[top] := num;
  end;

procedure init;
var i,j,k : longint;
    s1 : string;
  begin
      top := 0; n := 0;
      fillchar(kind,sizeof(kind),0);
      i := 0;
      while i <= length(s) do
        begin
           inc(i);
           if s[i]='=' then break;
           if s[i]='(' then continue;
           if (ord(s[i])>=97) and (ord(s[i])<=122) then
            begin
                inc(n); push(n);
            end;
           if (ord(s[i])>=65) and (ord(s[i])<=90) then
             begin
                 s1 := s[i]; inc(i);
                 while (ord(s[i])>=65) and (ord(s[i])<=90) do
                  begin
                      s1 := s1+s[i];
                      inc(i);
                  end;
                 if s1='OR' then push(1)
                  else if s1='AND' then push(2)
                   else push(3);
             end;
           if s[i]=')' then
            begin
                inc(n);
                l[n] := st[top-2]; r[n] := st[top];
                kind[n] := st[top-1];
                dec(top,3); push(n);
            end;
        end;
      inc(i);
      s1 := '';
      while i < length(s) do
       begin
           inc(i); s1 := s1+s[i];
       end;
      val(s1,x);
  end;

procedure dfs(u : longint);
var j,v : longint;
  begin
      if kind[u]=0 then
       begin
           f[u,0] := 1; f[u,1] := 1;
           exit;
       end;
      dfs(l[u]);
      dfs(r[u]);
      if kind[u]=1 then
       begin
           f[u,0] := (f[l[u],0]*f[r[u],0]) mod oo;
           f[u,1] := ((f[l[u],1]*f[r[u],0]) mod oo+(f[l[u],0]*f[r[u],1]) mod oo+(f[l[u],1]*f[r[u],1]) mod oo) mod oo;
       end

      else if kind[u]=2 then
       begin
           f[u,0] := ((f[l[u],0]*f[r[u],0]) mod oo+(f[l[u],1]*f[r[u],0]) mod oo+(f[l[u],0]*f[r[u],1]) mod oo) mod oo;
           f[u,1] := (f[l[u],1]*f[r[u],1]) mod oo;
       end
      else if kind[u]=3 then
        begin
           f[u,0] := ((f[l[u],0]*f[r[u],0]) mod oo+(f[l[u],1]*f[r[u],1]) mod oo) mod oo;
           f[u,1] := ((f[l[u],1]*f[r[u],0]) mod oo+(f[l[u],0]*f[r[u],1]) mod oo) mod oo;
        end;
  end;

procedure main;
var i,j : longint;
  begin
      dfs(n);
      res := 1;
      for i := 0 to 31 do
        res := (res*f[n,(x shr i) and 1]) mod oo;
      writeln(res);
  end;

begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(ntest);
     while ntest > 0 do
       begin
           dec(ntest);
           readln(s);
           init;
           main;
       end;
end.
