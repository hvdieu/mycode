Const   maxn = 20001;
Var     n,t       :       longint;
        tree,kq,pos      :       array [0..maxn] of longint;

procedure update(i,val : longint);
        begin
            while i <= n do
              begin
                  inc(tree[i],val);
                  inc(i,i and (-i));
              end;
        end;

function get(i : longint) : longint;
var s : longint;
        begin
            s := 0;
            while i > 0 do
              begin
                  inc(s,tree[i]);
                  dec(i,i and (-i));
              end;
            exit(s);
        end;

procedure main;
var i,vt,temp,d,c,mid,res : longint;
        begin
            if n = 1 then
              begin
                  writeln(1);
                  exit;
              end;
            fillchar(tree,sizeof(tree),0);
            fillchar(pos,sizeof(pos),0);
            for i := 1 to n do update(i,1);
            for i := 1 to n do
              begin
                  vt := i mod (n-i+1) + 1;
                  temp := get(n) - get(pos[i-1]);
                  d := 1; c := n;
                  if temp < vt then dec(vt,temp)
                   else inc(vt,get(pos[i-1]));

                  while d <= c do
                    begin
                        mid := (d+c) shr 1;
                        temp := get(mid);
                        if temp = vt then
                          begin
                              res := mid;
                              c := mid -1;
                          end
                        else if temp > vt then c := mid - 1
                         else d := mid + 1;
                    end;
                  kq[res] := i; update(res,-1);
                  pos[i] := res;
              end;
            for i := 1 to n do write(kq[i],' ');
            writeln;
        end;

begin
    //  assign(input,'CTRICK.INP'); reset(input);
    //  assign(output,'CTRICK.OUT'); rewrite(output);
      readln(t);
      while t > 0 do
        begin
            dec(t);
            readln(n);
            main;
        end;
end.
