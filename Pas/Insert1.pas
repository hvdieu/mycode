program Insert;
const
        inp='Insert.Inp';
        oup='Insert.Ou1';
        max=1000100;
var
        F,Fo:text;
        A:array [1..100100] of longint;
        T:array[1..max*8] of longint;
        Res1,res2,N:longint;
(*              *)
procedure update(i,a,b,x,y:longint);
var     mid:longint;
begin
        if (x<=a) and (y>=b) then
                begin
                        T[i]:=T[i]+1;
                        exit;
                end;
        if (x>b) or (y<a) then exit;
        mid:=(a+b) div 2;
        if b-a=1 then mid:=a;
        update(i*2,a,mid,x,y);
        update(i*2+1,mid+1,b,x,y);
end;
(*              *)
procedure find(i,a,b,x:longint);
var     mid:longint;
begin
        if (x<A) or (x>b) then exit;
        res1:=res1+T[i];
        if (A=x) and (A=b) then exit;
        mid:=(a+b) div 2;
        if b-a=1 then mid:=a;
        find(i*2,a,mid,x);
        find(i*2+1,mid+1,b,x);
end;
(*              *)
procedure nhap;
var     i,x:longint;
begin
        assign(f,inp);  reset(f);
        readln(f,n);
        for i:=1 to n do
                begin
                        readln(f,a[i]);
                end;
        A[n+1]:=A[1];
        for i:=1 to n do
                if (A[i]+1)<=(A[i+1]-1) then
                        begin
                                update(1,-max,max,A[i]+1,A[i+1]-1);
                        end;
        assign(fo,oup); rewrite(fo);
        while not eof(f) do
                begin
                        readln(f,x);
                        res1:=0;
                        find(1,-max,max,x);
                        //res2:=0;
                        // for i:=1 to n do
                        //        if (X>a[i]) and (x<a[i+1]) then inc(res2);
                        writeln(fo,res1);
                end;
        close(f);
        close(fo);
end;
(*              *)
BEGIN
        nhap;
END.
