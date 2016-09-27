Const   maxn = 100001;
Var     w,s       :       array [0..maxn] of longint;
        n,i,res     :       longint;

function find(d,c : longint;key : longint) : longint;
var mid,ans : longint;
        begin
              while d <= c do
                begin
                    mid := (d+c) shr 1;
                    if s[mid] <= key then
                      begin
                          ans := mid;
                          d := mid+1;
                      end
                    else c := mid-1;
                end;
              exit(ans);
        end;

procedure main;
var i,j : longint;
    temp : longint;
        begin
            res := 1;
            temp := w[n];
            i := n;
            while i > 0 do
              begin
                  if s[i-1] < temp then break;
                  j := find(0,i-1,s[i-1]-temp);
                  inc(res);
                  if i >= 2 then
                  repeat
                     if w[i-1] + temp <= s[i-2] - s[j] then dec(i)
                      else break;
                  until false;
                  temp := s[i-1] - s[j];
                  i := j+1;
              end;
            writeln(res);
        end;

begin
      assign(input,'TOWER.INP'); reset(input);
      assign(output,'TOWER.OUT'); rewrite(output);
      readln(n);
      for i := 1 to n do
        begin
            read(w[i]);
            s[i] := s[i-1] + w[i];
        end;
      main;
end.