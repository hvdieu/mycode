Uses math;
Const   maxn = 50001;

Var     n,d,i   :       longint;
        a,kq,kq1       :       array [1..maxn] of longint;
        res     :      int64;

{*************************************************************************}
function check(x : int64) : boolean;
var i,j,t : longint;
    alt,temp : int64;
        begin
            alt := 0;
            j := 0;
            fillchar(kq,sizeof(kq),0);
            for i := 1 to d do
              begin
                  if alt div 2 <= x then
                    begin
                        temp := alt div 2;
                        while (j <= n) and (temp < x) do
                          begin
                              inc(j);
                              if j > n then exit(false);
                              temp := temp + a[j];
                              kq[j] := i;
                          end;
                        alt := temp;
                    end
                  else alt := alt div 2;
              end;
            for t := 1 to n do
             if kq[t] = 0 then kq[t] := d;
            kq1 := kq;
            exit(true);
        end;
{*************************************************************************}
procedure main;
var dau,cuoi,mid : int64;
        begin
             dau := 0; cuoi := 50000000000;
             while dau <= cuoi do
               begin
                    mid := (dau+cuoi) shr 1;
                    if check(mid) then
                     begin
                         res := mid;
                         dau := mid+1;
                     end
                    else cuoi := mid-1;
               end;
             writeln(res);
             for i := 1 to n do writeln(kq1[i]);
        end;
{*************************************************************************}
begin
      assign(input,'EATING.INP'); reset(input);
      assign(output,'EATING.OUT'); rewrite(output);
      readln(n,d);
      for i := 1 to n do read(a[i]);
      main;
end.
