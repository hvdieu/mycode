Const   out = 'asd.out';
        maxn = 10001;

Var     n,i,j,k,max   :       longint;
        kq      :       array [1..maxn,1..maxn] of integer;

function lay(x,i : longint) : longint;
        begin
            lay := (x shr (i)) and 1;
        end;

procedure noi(i,j : longint);
  begin
      kq[i,j] := 1; kq[j,i] := 1;
  end;

begin
      assign(output,out); rewrite(output);
      readln(k);
      n := 2; max := 0;
      for i := 31 downto 1 do
        begin
            if lay(k,i)=1 then
              begin
                 noi(1,n+1); noi(1,n+2);
                 j := n+1;
                 while j <= n+2*i-2 do
                   begin
                       noi(j,j+2); noi(j,j+3);
                       noi(j+1,j+2); noi(j+1,j+3);
                       inc(j,2);
                   end;
                 n := n + 2*i;
                 if max=0 then
                   begin
                       max := i;
                       noi(n-1,2); noi(n,2);
                   end
                 else
                   begin
                       noi(n,n+1); noi(n-1,n+1);
                       for j := n+2 to n+max-i do
                         begin
                            noi(j,j-1);
                         end;
                       inc(n,max-i);
                       noi(n,2);
                   end;
              end;
        end;
      if lay(k,0)=1 then
        begin
            if max=0 then
             begin
                 kq[1,2] := 1; kq[2,1] := 1;
             end
            else begin
                     noi(1,n+1);
                     for j := n+2 to n+max do
                      begin
                         noi(j,j-1);
                      end;
                     inc(n,max);
                     noi(n,2);
                 end;
        end;
      writeln(n);
      for i := 1 to n do
        begin
            for j := 1 to n do if kq[i,j]=1 then write('Y') else write('N');
            writeln;
        end;
end.

