Uses math;
Var     s       :       string;
        ch      :       char;
        dem,sl,w,can     :       array [1..3] of int64;
        i       :    longint;
        d,c,mid,res,co,r    :       int64;

function min(var xx,yy : int64) : int64;
        begin
            if xx < yy then exit(xx)
             else exit(yy);
        end;

function check(x : int64) : boolean;
var i : longint;
    temp : int64;
        begin
            temp := 0;
            for i := 1 to 3 do
             if dem[i]*x-sl[i] > 0 then
             inc(temp,(dem[i]*x-sl[i])*w[i]);
            if temp <= r then exit(true)
             else exit(false);
        end;

begin
   //   assign(input,'asd.inp'); reset(input);
    //  assign(output,'asd.out'); rewrite(output);
      readln(s);
      for i := 1 to length(s) do
       if s[i] = 'B' then inc(dem[1])
        else if s[i] = 'C' then inc(dem[3])
         else inc(Dem[2]);
       readln(sl[1],sl[2],sl[3]);
       readln(w[1],w[2],w[3]);
       co := maxlongint;
       for i := 1 to 3 do
        if dem[i] <> 0 then
         if co > sl[i] div dem[i] then co := sl[i] div dem[i];
       for i := 1 to 3 do
        if dem[i] <> 0 then
         dec(sl[i],dem[i]*co);
       readln(r);
       res := 0;
       d := 1; c := r;
       while d <= c do
         begin
             mid := (d+c) shr 1;
             if check(mid) then
               begin
                   res := mid;
                   d := mid + 1;
               end
             else c := mid - 1;
         end;
       writeln(res+co);
       readln;

end.
