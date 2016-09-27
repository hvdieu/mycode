Uses math;
Const   maxn = 1500;
    inp = 'lcs2x.inp';
    out = 'lcs2x.oup';

Var     a,b     :       array [0..maxn] of longint;
        f       :       array [0..maxn,0..maxn] of longint;
        m,n,ntest,res,k,t,i,j,u,v     :       longint;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
     readln(ntest);
     while ntest > 0 do
      begin
          fillchar(f,sizeof(f),0);
          dec(ntest); res := 0;
          readln(m,n);
          for i := 1 to m do read(a[i]);
          for i := 1 to n do read(b[i]);
          for i := 1 to m do
           for j := 1 to n do
            begin
            if a[i]=b[j] then
             for k := 0 to i-1 do
              for t := 0 to j-1 do
               if (a[k]=b[t]) and (2*a[k]<=a[i]) then f[i,j] := max(f[i,j],f[k,t]+1);
            if res < f[i,j] then
              begin
                res := f[i,j];
                u := i; v := j;
              end;
            end;
          writeln(Res);
          //writeln(u,' ',v);
      end;
     readln;
end.
