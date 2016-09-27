{$MODE OBJFPC}
{$R- Q-}
const
        inp='VMCOUNT.INP';
        out='VM.OUT';
        k=1000000000+7;

var     a:array[1..23,1..23] of char;
        sum:int64;
        f:array[1..8388609,1..24] of int64;
        n,i,j:integer;
        mask:longint;
        fi,fo:text;

procedure input;
begin
        assign(fi,inp);
        reset(fi);
        readln(fi,n);
        for i:=1 to n do
                begin
                        for j:=1 to n do read(fi,a[i,j]);
                        readln(fi);
                end;
        close(Fi);
end;
function get(x,j:longint):byte;
begin
        get:=(x shr j) and 1;
end;
function bat(x:longint;i:longint):longint;
begin
        bat:=x or (1 shl i);
end;
procedure DP;
var x:integer;
begin
        fillchar(f,sizeof(f),0);
        f[1,1]:=1;
        for i:=1 to n-1 do f[1 shl i,i+1]:=1;

        for mask:=1 to (1 shl n) - 1 do
           for i:=1 to n do
            if f[mask,i]>0 then
              for j:=1 to n do
                 if (a[i,j]='1') and (get(mask,j-1) and 1=0) then
                    begin
                        x:=bat(mask,j-1);
                        f[x,j]:=f[x,j]+f[mask,i];
                    end;
end;
begin
        input;
        dp;
        sum:=0;
        for j:=1 to n do
                sum:=sum+ f[(1 shl n) -1,j] mod k;
        assign(fo,out);
        rewrite(fo);
        write(fo,(sum +k)mod k);
        close(fo);
end.
