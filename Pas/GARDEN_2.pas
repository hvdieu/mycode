Program GARDEN;
const   tfi                     =       'GARDEN.inp';
        tfo                     =       'GARDEN.out';
        oo                      =       1001;
var     fi,fo                   :       text;
        n,p,k                   :       longint;
        a                       :       array[0..oo,0..oo] of longint;
        S                       :       array[0..oo,0..oo] of longint;
        res                     :       longint;
        dem                     :       longint;
(*****************************)
Procedure input;
var i,j:longint;
        u,v:longint;
begin
        fillchar(a,sizeof(a),0);
        Read(fi,n,p,k);
        For i:=1 to p do
         begin
                ReaD(fi,u,v);
                A[u,v]:=1;
         end;
end;
(*****************************)
PRocedure init;
var i,j:longint;
begin
        s[0,0]:=0;
        For i:=1 to n do
         for j:=1 to n do
          s[i,j]:=s[i-1,j]+s[i,j-1]-s[i-1,j-1]+a[i,j];
end;
(*****************************)
function gmax(x,y:longint):longint;
begin
        IF x>y then exit(x);
        exit(y);
end;
(*****************************)
PRocedure xuli;
var i,j:longint;
        tg:longint;
begin
        For i:=1 to n-k+1 do
          for j:=1 to n-k+1 do
           begin
                tg:=s[i+k-1,j+k-1]-s[i-1,j+k-1]-s[i+k-1,j-1]+s[i-1,j-1];
                IF tg=res then inc(dem);
           end;
end;
(*****************************)
Procedure process;
var i,j,tg:longint;
begin
        For i:=1 to n-k+1 do
         For j:=1 to n-k+1 do
          begin
                tg:=s[i+k-1,j+k-1]-s[i-1,j+k-1]-s[i+k-1,j-1]+s[i-1,j-1];
                res:=gmax(res,tg);
          end;
end;
(*****************************)
PRocedure output;
begin
        res:=-1;
        dem:=0;
        Process;
        writeln(fo,res);
        xuli;
        writeln(fo,dem);
end;
(*****************************)
begin
        assign(Fi,tfi);reset(fi);
        assign(fo,tfo);rewrite(fo);
                input;
                init;
                output;
        close(fi);close(fo);
end.
