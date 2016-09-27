uses math;
const
    tfi='pds.inp';
    tfo='pds.out';
var
    fi,fo:text;
    st:string;
    ll,k,i, dem:longint;
    res,l,r,mid,tg, n:qword;
    f:array[1..20,0..1,0..200,0..200,0..1] of int64;
    g:array[1..20,0..1,0..200,0..200,0..1] of longint;
procedure inp;
    begin
        read(fi,n);
    end;
function call(i,ok,sum,m,ok2:longint):int64;
    var
        ok1,ok3,m1,last,j:longint;
    begin
        if i=ll+1 then
            if (ok2=1) and (sum=k) and (m=0) then exit(1)
            else exit(0);
        if g[i,ok,sum,m,ok2]=dem then exit(f[i,ok,sum,m,ok2]);
        f[i,ok,sum,m,ok2]:=0;
        if ok=1 then last:=9
        else last:=ord(st[i])-48;
        for j:= 0 to last do
            if sum+j<=k then
                begin
                    if (ok=1) or (j<last) then ok1:=1
                    else ok1:=0;
                    if (ok2=1) or (j<>0) then ok3:=1
                    else ok3:=0;
                    if (ok3=1) then m1:=(m*j) mod k
                    else m1:=m;
                    f[i,ok,sum,m,ok2]:=f[i,ok,sum,m,ok2]+call(i+1,ok1,sum+j,m1,ok3);
                end;
        g[i,ok,sum,m,ok2]:=dem;
        exit(f[i,ok,sum,m,ok2]);
    end;
begin
    assign(fi,tfi);reset(fi);
    assign(fo,tfo);rewrite(fo);
    inp;
    l:=1;
    r := 1; for i := 1 to 63 do r := r * 2; dec(r);
    res:=0;
        while l<=r do
            begin
                mid:=(l+r) div 2;
                str(mid,st);
                ll:=length(st);
                tg:=0;
                for k:= 1 to 9*ll do
                    begin
                        inc(dem);
                        if tg>=n then break;
                        tg:=tg+call(1,0,0,1,0);
                    end;
                if tg<n then l:=mid+1
                else if tg>n then r:=mid-1
                else if tg=n then
                    begin
                        res:=mid;
                        r:=mid-1;
                    end;

            end;
        write(fo,res);
    close(fi);close(fo);
end.
