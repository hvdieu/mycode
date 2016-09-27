Const   inp = 'beauty.inp';
        out = 'beauty.out';
        maxn = 19;
        maxC = 999999999;
Var     fi,fo   :       text;
        n,m       :       longint;
        f       :       array [0..maxn,0..1,0..1,0..162,0..maxn] of int64;
        d,c,mid,kq :       int64;
        ss       :       string;

function tinh(i,ok1,ok2,s,scs : longint) : int64;
var j,x : longint;
    res : int64;
        begin
            if i = m+1 then
             if (scs <> 0) and (s mod scs = 0) then exit(1)
              else exit(0);
            if f[i,ok1,ok2,s,scs] <> maxC then exit(f[i,ok1,ok2,s,scs]);
            res := 0;
            if ok1 = 1 then
              begin
                  if ok2=1 then
                   for j := 0 to 9 do res := res + tinh(i+1,1,1,s+j,scs+1)
                  else
                   begin
                       res := res + tinh(i+1,1,0,s,scs);
                       for j := 1 to 9 do
                         res := res + tinh(i+1,1,1,s+j,scs+1);
                   end;
              end
            else if ok1 = 0 then
              begin
                   val(ss[i],x);
                   if ok2 = 0 then
                   begin
                      for j := 0 to x-1 do
                        begin
                           if j = 0 then res := res + tinh(i+1,1,0,s,scs)
                              else res := res + tinh(i+1,1,1,s+j,scs+1);
                        end;
                      if x = 0 then
                      res := res + tinh(i+1,0,ok2,s+x,scs)
                      else res := res + tinh(i+1,0,1,s+x,scs+1);
                   end
                   else if ok2 = 1 then
                   begin
                        for j := 0 to x-1 do res := res + tinh(i+1,1,1,s+j,scs+1);
                        res := res + tinh(i+1,0,1,s+x,scs+1);
                   end;
              end;
            f[i,ok1,ok2,s,scs] := res;
            tinh := res;
        end;

procedure main;
var i,i1,i2,i3,i4 : longint;
    temp : int64;
        begin
            d := 0; c := 100000000000;
            while d <= c do
              begin
                  mid := (d+c) shr 1;
                  str(mid,ss);
                  m := length(ss);
                  for i := 0 to m do
                   for i1 := 0 to 1 do
                    for i2 := 0 to 1 do
                     for i3 := 0 to 9*m do
                      for i4 := 0 to m do
                      f[i,i1,i2,i3,i4] := maxC;
                  temp := tinh(1,0,0,0,0);
                  if temp >= n then
                    begin
                        kq := mid;
                        c := mid - 1;
                    end
                  else d := mid + 1;
              end;
            writeln(fo,kq);
        end;

procedure input;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             while not eof(fi) do
               begin
                    read(fi,n);
                    main;
               end;
             close(fi); close(fo);
        end;

begin
     input;
end.