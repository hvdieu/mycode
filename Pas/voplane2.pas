uses    math;
const   inf='voplane.inp';
        outf='voplane.ou1';
        maxn = 30;
type    typen=0..maxn;
var     inp,out:text;
        n:longint;
        res,tmp:longint;
        sl,dsKhoang,l,id,x,y,previous:Array[typen] of longint;

procedure openf;
begin
        assign(inp,inf);
        reset(inp);
        assign(out,outf);
        rewrite(out);
end;
procedure swap(Var a,b:longint);
var     t:longint;
begin
        t:=a;
        a:=b;
        b:=t;
end;
procedure closef;
begin
        close(out);
        close(inp);
end;
procedure readf;
var     i:longint;
begin

        readln(inp,n);
        for i:=1 to n do begin
                readln(inp,x[i],y[i]);
                id[i]:=i;
        end;

end;
procedure check;
var     khoang,i,j,tmp2:longint;
        pos,vitri:array[typen] of longint; // i thuoc khoang Vitri[i]
        dsdiem:array[typen,typen] of longint;
        xet:array[typen] of boolean;
begin
        fillchar(xet,sizeof(xet),false);
        fillchar(previous,sizeof(previous),0);
        sl:=previous;
        khoang:=1;
                {
        writeln('         DEBUG     ',tmp);
        for i:=1 to tmp do writeln(dskhoang[i]);
        writeln(' ######### ');
               }
        for i:=1 to n do begin
                while (x[id[i]] > dsKhoang[khoang]) and (khoang <= tmp) do inc(khoang);
                vitri[id[i]]:=khoang;
        end;
         //tmp2 la so canh ngang, so phan tu cua danh sach L
        tmp2:=0;
        for i:=1 to n do begin

                if (previous[vitri[i]] <> 0) then begin
                        if (y[i] = y[previous[vitri[i]]]) then begin
                                exit;
                                //Hai diem cung 1 tung do kg the nam trong 1 khoang dc
                        end;
                        xet[i]:=true;
                end;

                inc(sl[vitri[i]]);
                dsdiem[vitri[i],sl[vitri[i]]]:=i;
                pos[i]:=sl[vitri[i]];

                previous[vitri[i]]:=i;
        end;
        tmp2:=0;
        for i:=1 to n do begin
                if (xet[i]) then begin
                        if (tmp2 = 0) then begin
                                l[1] := y[i];
                                tmp2:=1;
                        end else begin
                                j:=pos[i]-1;
                                if (y[dsdiem[vitri[i],j]] <= l[tmp2]) then begin
                                        inc(tmp2);
                                        l[tmp2]:=y[i];
                                end;
                        end;
                end;
        end;
      //  writeln(tmp,' ',tmp2);
        if (tmp+tmp2<res) then res:=tmp+tmp2;
      //  readln;
end;
procedure try(i:longint);
var     j:0..1;
begin
        for j:=0 to 1 do begin
                inc(tmp,j);
                if j = 1 then dsKhoang[tmp]:=i;
                if (i < n -1) then try(i+1) else begin
                        if (tmp < res) then begin
                                check;
                        end;
                end;
                dec(tmp,j);
        end;
end;
procedure process;
var     i,j:longint;
begin
        res:=n-1;
        if (res <= 2) then exit; // Co 1 dinh thi ko cat. 2 dinh thi cat 1. 3 dinh thi cat 2
        y[0]:=high(longint);
        for i:=1 to n-1 do begin
                for j:=i+1 to n do begin
                        if (y[i] < y[j]) then begin
                                swap(x[i],x[j]);
                                swap(y[i],y[j]);
                        end;
                end;
        end;
        inc(res);
        //Mangid nay dung de ta kiem tra diem 1 thuoc khoang nao thoi ma :D
        for i:=1 to n-1 do begin
                for j:=i+1 to n do begin
                        if (x[id[i]] > x[id[j]]) then swap(id[i],id[j]);
                end;
        end;
        tmp:=0;
        try(1);

end;
procedure writef;
begin
        writeln(out,res);
end;
procedure solve;
var     t:longint;
begin
        readln(inp,t);
        while t>0 do begin
                dec(t);
                readf;
                process;writef;
        end;
end;
begin
        openf;
        solve;
        closef;
end.
