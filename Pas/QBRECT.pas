Const   inp = '';
        out = '';
        maxn = 1001;
Var     fi,fo   :       text;
        m,n     :       longint;
        a,h     :       array [0..maxn,0..maxn] of longint;
        st,l,r      :       array [0..maxn+1] of longint;
        res     :   longint;


Procedure input;
Var i,j : longint;
        BEGIN
              assign(fi,inp); reset(fi);
              readln(fi,m,n);
              res :=0;
              fillchar(a,sizeof(a),0);
              For i := 1 to m do
                For j := 1 to n do read(fi,a[i,j]);
              close(fi);
        END;

Procedure lam(i : longint);
Var j,top : longint;
        BEGIN
            top := 1;
            fillchar(l,sizeof(l),0);
            fillchar(r,sizeof(r),0);
            fillchar(st,sizeof(st),0);
            st[1] := 1; l[1] := 1;
            st[0] := 0;
            For j := 2 to n do
              BEGIN
                   if h[i,j] > h[i,j-1] then
                     BEGIN
                          inc(top);
                          st[top] := j;
                          l[j] := 1;
                     END
                       else
                     BEGIN
                           While (top>=1) do
                             BEGIN
                              if (h[i,st[top]] >= h[i,j]) then dec(top)
                               else break;
                             END;
                           l[j] := j-st[top] ;
                           inc(top);
                           st[top] := j;
                     END;
              END;

            st[1] := n; r[n] := 1; top := 1;
            st[0] := n+1;
            For j := n-1 downto 1 do
              BEGIN
                   if h[i,j] > h[i,j+1] then
                     BEGIN
                          inc(top);
                          st[top] := j;
                          r[j] := 1;
                     END
                       else
                     BEGIN
                          While (top >= 1) do
                            BEGIN
                              if (h[i,st[top]] >= h[i,j]) then dec(top)
                                else break;
                            END;
                          r[j] := abs(j-st[top]);
                          inc(top);
                          st[top] := j;
                     END;
              END;
            For j := 1 to n do
               if h[i,j]*(l[j]+r[j]-1) > res then res := h[i,j] *(l[j]+r[j]-1);

        END;

Procedure main;
Var i,j : longint;
        BEGIN
             fillchar(h,sizeof(h),0);
             For i := 1 to m do
               For j := 1 to n do
                 if a[i,j] = 1 then h[i,j] := h[i-1,j] + 1
                   else h[i,j] := 0;
             For i := 1 to m do
               lam(i);
        END;

Procedure output;
        BEGIN
              assign(fo,out); rewrite(fo);
              write(fo,res);
              close(fo);
        END;

BEGIN
      input;
      main;
      output;
END.
