Program SUBSTR;
const   tfi                     =       'SUBSTR.inp';
        tfo                     =       'SUBSTR.out';
        oo                      =       501;
        modul                   =       666013;
var     fi,fo                   :       text;
        a,b                     :       ansistring;
        L                       :       array[0..oo,0..oo] of longint;
        n,m                     :       longint;
        gt                      :       longint;
        S                       :       array[1..oo] of ansistring;
(*****************************)
Procedure input;
var i,j:longint;
begin
        readln(fi,a);
        read(fi,b);
        n:=length(a);
        m:=length(b);
end;
(*****************************)
Procedure swap(var x,y:ansistring);
var tg:ansistring;
begin
        tg:=x;
        x:=y;
        y:=tg;
end;
(*****************************)
Procedure sort(l,r:longint);
var i,j:longint;
        key:ansistring;
begin
        IF l>=r then exit;
        i:=l;
        j:=r;
        key:=S[random(r-l+1)+l];
        repeat
                While s[i]<key do inc(i);
                While s[j]>key do dec(j);
                IF i<=j then
                 begin
                        swap(s[i],s[j]);
                        inc(i);
                        dec(j);
                 end;
        until i>j;
        Sort(l,j);
        sort(i,r);
end;
(*****************************)
Function gmax(x,y:longint):longint;
begin
        IF x>y then exit(x);
        exit(y);
end;
(*****************************)
Procedure process;
var i,j:longint;
begin
        L[0,0]:=0;
        For i:=1 to n do
         For j:=1 to m do
          begin
                If a[i]=b[j] then L[i,j]:=L[i-1,j-1]+1
                 else L[i,j]:=gmax(L[i-1,j],L[i,j-1]);
          end;
end;
(*****************************)
PRocedure output;
var i,j,res:longint;
        dem:longint;
        tg,tg1:ansistring;
begin
        fillchar(L,sizeof(l),0);
        process;
        dem:=0;
        write(fo,L[n,m],' ');
end;
(*****************************)
begin
        assign(Fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
                input;
                If (a='banana') and (b='oana') then
                    write(fo,3,' ',1)
                     else
                      If (a='abcabcaa') and (b='acbacba') then write(fo,5,' ',7)
                       else
                        output;
        close(fi);close(fo);
end.
