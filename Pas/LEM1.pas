Uses math;
Const    inp = 'lem1.inp';
         out = '';
         maxn = 10001;
         eps  = 1e-9;
Var      fi,fo  :       text;
         n,i,max      :       longint;
         res    :     extended;
         r      :       array [1..maxn] of longint;
{*       *      *       *       *       *}
Procedure Find (d,cuoi : extended);
Var mid,a,b,c,O,goc  : extended;
    i    : longint;
BEGIN
    While d <= cuoi do
        BEGIN
                mid := (d+cuoi) /2;
                O := 0;
                For i := 1 to n do
                        BEGIN
                            b := r[i] + mid;
                            c := r[i + 1] + mid;
                            a := r[i] + r[ i + 1];
                            goc := arccos( ( sqr(b) + sqr(c) - sqr(a) ) / ( 2*b*c) );
                            O := O + goc;
                        END;
                 if abs(O  - 2*pi) <= eps then
                        BEGIN
                            res := mid;
                            exit;
                        END
                         else if O - 2*pi > eps then d := mid
                           else cuoi := mid;



        END;
        res := cuoi ;
END;
{*      *       *       *       *       *}
BEGIN
        Assign(fi,inp); reset(fi);
        readln(fi,n);
        For i := 1 to n do
         BEGIN
                read(fi, r[i] );
                max := max + r[i];
         END;
        close(fi);
        r[n + 1] := r[1];
        find(0,max);
        Assign(fo,out);rewrite(fo);
        write(fo,res:0:3);
        close(fo);


END.
