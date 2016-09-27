const
        tfi='demso.inp';
        tfo='demso.out';
var     fi,fo:text;
        x,y:int64;
        sx,sy:string;
        a,b:array[1..16] of longint;
        f:array[1..16,0..1,0..1,0..10000] of int64;
        g:array[1..16,0..1,0..1,0..10000] of boolean;
        kq:int64;
procedure  nhap;
var     i:longint;
        begin
                read(fi,x,y);
                str(x,sx);
                str(y,sy);
                for i:=1 to length(sx) do val(sx[i],a[i]);
                for i:=1 to length(sy) do val(sy[i],b[i]);
        end;
function tinh(i,ok1,ok2,truoc:longint):int64;
var     ok3,ok4,dau,cuoi,cs:longint;
        res:int64;
        begin
                if (i>length(sy)) then exit(0);
                if g[i,ok1,ok2,truoc] then exit(f[i,ok1,ok2,truoc]);
                res:=0;
                if ok1=1 then cuoi:=9
                else cuoi:=b[i];
                if ok2=1 then dau:=0
                else dau:=a[i];
                for cs:=dau to cuoi do
                  if abs(cs-truoc)>1 then
                      begin
                        if (ok1=1) and (cuoi>cs) then ok3:=1
                        else ok3:=0;
                        if (ok2=1) and (dau<cs) then ok4:=1
                        else ok4:=0;
                        res:=res+tinh(i+1,ok3,ok4,cs);
                      end;
                      g[i,ok1,ok2,cs]:=true;
                      f[i,ok1,ok2,cs]:=res;
                      exit(res);
        end;
begin
        assign(fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
        nhap;
        kq:=tinh(1,0,0,0);
        write(fo,kq);
        close(fi);close(fo);
end.
