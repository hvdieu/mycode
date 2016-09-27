uses    math;

const   fi='CUTSEQS.INP';
        fo='CUTSEQS.OU';

var     inp,oup:text;
        a,q:array[0..100014] of longint;
        F:array[0..100014] of int64;
        m:qword;
        n,dau,cuoi:longint;

procedure openf;
begin
        assign(inp,fi);reset(inp);
        assign(oup,fo);rewrite(oup);
end;

procedure closef;
begin
        close(inp);
        close(oup);
end;

procedure input;
var     i:longint;
begin
        readln(inp,n,m);
        for i:=1 to n do
            begin
                read(inp,a[i]);
                if a[i]>m then
                   begin
                        write(oup,-1);
                        closef;
                        halt;
                   end;
            end;
end;

procedure solve;
var     i,left,j:longint;
        sum:qword;
begin
        dau:=1;cuoi:=1;
        q[1]:=1;left:=1;
        F[1]:=a[1];
        sum:=a[1];
        for i:=2 to n do
            begin
                sum:=sum+a[i];
                while (sum>m)and(left<i) do
                    begin
                        sum:=sum-a[left];
                        inc(left);
                    end;
                while (dau<=cuoi)and(a[i]>=a[q[cuoi]]) do dec(cuoi);
                inc(cuoi);
                q[cuoi]:=i;
                while (q[dau]<left)and(dau<cuoi) do inc(dau);
                F[i]:=F[left-1]+a[q[dau]];
                for j:=dau to cuoi-1 do
                    F[i]:=min(F[i],F[q[j]]+a[q[j+1]]);
            //    writeln(oup,F[i]);
            end;
       // for i := 1 to n do writeln(oup,f[i],' ');
        write(oup,F[n]);
end;

procedure process;
begin
        input;
        solve;
end;

BEGIN
        openf;
        process;
        closef;
END.

