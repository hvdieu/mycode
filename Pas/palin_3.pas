Program PALIN;
const   tfi                     =       'PALIN.inp';
        tfo                     =       'PALIN.out';
        modul                   =       3210121;
type    arr                     =       array[1..50] of char;
var     fi,fo                   :       text;
        a,b,c,d                 :       string;
        n,m                     :       longint;
        S                       :       array[1..50] of longint;
        res                     :       longint;
        st                      :       array[1..50] of char;
        tg                      :       longint;
        a1,b1                   :       array[1..50] of char;
(*****************************)
Procedure swap(var x,y:string);
var tg1:string;
begin
        tg1:=x;
        x:=y;
        y:=tg1;
end;
(*****************************)
Procedure input;
var i,j:longint;
begin
        readln(fi,a);
        Readln(fi,b);
        IF length(a) < length(b) then swap(a,b);
        n:=length(a);
        m:=length(b);
        For i:=1 to n do a1[i]:=a[i];
        For i:=1 to m do b1[i]:=b[i];
end;
(*****************************)
Function check(a2,b2:arr):boolean;
var i:longint;
begin
        For i:=1 to m+n do
         If a2[i]<>b2[i] then exit(false);
        exit(true);
end;
(*****************************)
PRocedure process;
var i,j,k:longint;
        ok,ok1,ok2:boolean;
        st1:array[1..50] of char;
        dem:longint;
begin
        dem:=0;
        ok:=false;
        ok1:=false;
        ok2:=false;
        For i:=1 to m+n do
          IF s[i]=1 then inc(dem);
        If (dem=n) or (dem=m) then ok:=true;
        If not ok then exit;
        j:=0;
        k:=0;
        For i:=1 to m+n do
         begin
                IF s[i]=1 then
                 begin
                        inc(j);
                        If j>n then
                         begin
                                ok1:=true;
                                break;
                         end;
                        st[i]:=a1[j];
                 end
                else
                 begin
                        inc(k);
                        If k>m then
                         begin
                                ok2:=true;
                                break;
                         end;
                        st[i]:=b1[k];
                 end;
         end;
         If ok1 or ok2 then
          begin
                dec(i);
                If ok1 then
                 begin
                        while i<=m+n do
                         begin
                                inc(i);
                                inc(k);
                                st[i]:=b1[k];
                         end;
                 end
                else
                 begin
                        while i<=m+n do
                         begin
                                inc(i);
                                inc(j);
                                st[i]:=a1[j];
                         end;
                 end;
          end;
        j:=0;
        For i:=m+n downto 1 do
          begin
                inc(j);
                st1[j]:=st[i];
          end;
        If check(st,st1) then inc(res);
end;
(*****************************)
Procedure try(x:longint);
var i:longint;
begin
        If x>(m+n) then
             begin
                process;
                exit;
             end;
        For i:=0 to 1 do
          begin
                S[x]:=i;
                try(x+1);
          end;
end;
(*****************************)
PRocedure output;
begin
        res:=0;
        try(1);
        res:=res mod modul;
        write(fo,res);
end;
(*****************************)
begin
        assign(Fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
                input;
                output;
        close(fi);close(fo);
end.
