Const   maxn = 1000001;
Var     t,n,st,x,i,j     :       longint;
        f       :       array [0..maxn] of longint;
        s       :       string;
        u,v     :       char;

{*************************************************************************}
{**************************************************************************}
begin
     assign(input,'DGAMES.INP'); reset(input);
     assign(output,'DGAMES.OUT'); rewrite(output);
           fillchar(f,sizeof(f),0);
           f[0] := 0;
           for x := 1 to 1000000 do
             begin
                str(x,s); v := '/'; u := ':';
                for i := 1 to length(s) do
                  begin
                     if (s[i] <> '0') and (s[i] < u) then u := s[i];
                     if (s[i] <> '0') and (s[i] > v) then v := s[i];
                  end;
                val(u,i); val(v,j);
                if (i <> 0) and (j <> 0) then
                 begin
                   if (f[x-i] = 0) or (f[x-j]=0) then f[x] := 1
                    else f[x] := 0;
                 end
                  else if i = 0 then
                    begin
                     if f[x-j] = 0 then f[x] := 1
                       else f[x] := 0;
                    end
                  else if f[x-i] = 0 then f[x] := 1
                     else f[x] := 0;
             end;
     readln(t);
     while t > 0 do
       begin
           dec(t);
           read(n);
           if f[n] = 1 then writeln('YES')
            else writeln('NO');
       end;
end.
