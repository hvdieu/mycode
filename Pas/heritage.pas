Const   maxn = 26;
Var     trung,tien       :       string;
        st      :       array [1..maxn] of char;
        contrai,conphai :       array ['A'..'Z'] of char;
        d       :       array ['A'..'Z'] of boolean;
        n,i,j       :       integer;

begin
       assign(input,'heritage.in'); reset(input);
       assign(output,'heritage.out'); rewrite(output);
       readln(trung); readln(tien);
       i := 0; j := 1;
       n := length(trung);
       while i < n do
         begin
              while d[trung[i]] = false do
                begin
                    inc(
                end;
         end;
end.

