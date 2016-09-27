Const   inp = '';
        out = '';
        maxn = 1001;
Var     fi,fo   :       text;
        a       :       array [1..maxn,1..301] of byte;
        st      :       array [1..maxn] of longint;
        dem,n,m,top    :       longint;
        res     :  qword;

procedure input;
var i,j : longint;
        begin
            assign(fi,inp); reset(fi);
            readln(fi,m,n);
            for i := 1 to m do
              for j := 1 to n do
               read(fi,a[i,j]);
            close(fi);
        end;

procedure main; {$INLINE ON}
var l,r,i : longint;
        begin
             for l := 1 to n-1 do
                 begin
                   top := 0;
                   for i := 1 to m do
                     if a[i,l] = 1 then
                       begin
                           inc(top);
                           st[top] := i;
                       end;
                   for r := l+1 to n do
                   begin
                     dem := 0;
                     for i := 1 to top do
                       if a[st[i],r] = 1 then inc(dem);
                     res := res + (dem*(dem-1)) div 2;
                   end;
                 end;
             assign(fo,out); rewrite(fo);
             write(fo,res);
             close(fo);
        end;

begin
     input;
     main;
end.
