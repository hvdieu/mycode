const   finp    =       'PYTHAEQ.INP';
        fout    =       'pitago.out';
var     g,f     :       text;
        r,resu       :    longint;
procedure       mo;
begin
        assign(f,finp);
        reset(f);
        assign(g,fout);
        rewrite(g);
end;
procedure       dong;
begin
        close(f);
        close(g);
end;
procedure       doc;
begin
        readln(f,r);
        If r=0 then
                begin
                        writeln(g,'1') ;
                        close(g);
                        halt;
                end;
        end;
Procedure       tinh1;
begin
        resu:=1;
        while not odd(r) do r:=r shr 1;
end;
Function        Fu(p,k:longint):longint;
begin
        If p mod 4=3 then fu:=1;
        If p mod 4=1 then fu:=k+1;
end;
Procedure       xuly;
var     i,j,h,temp:longint;
begin
        i:=3;h:=0;
        Repeat
                temp:=0;
                If r mod i=0 then
                while r mod i=0 do
                        begin
                                inc(temp);
                                r:=r div i;
                        end;
                        If temp>0 then
                        begin
                                resu:=resu*fu(i,temp*2);
                        end;
                        inc(i,2);
        Until (r=1)or(i>trunc(sqrt(r)));
                If r<>1 then resu:=resu*fu(r,2);
                Resu:=Resu shl 2;
                writeln(g,resu);
        end;
begin
        mo;
        doc;
        tinh1;
        xuly;
        dong;
end.
