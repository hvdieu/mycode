Const   maxn = 20001;
        p = 52;
        p1 = 1000000007;

Type    canh = record
        u,v : longint;
        end;

Var     n,i,top,c,bd,dich,left,right,m,res     :       longint;
        hash    :       array [0..25] of longint;
        ke,head,next :       array [1..maxn] of longint;
        e       :       array [1..maxn] of canh;
        st,a      :  array [1..maxn] of longint;
        queue,d     :  array [1..maxn] of longint;
        free    :   array [1..maxn] of boolean;
        s,s1,s2   :  string;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,k : longint;
        begin
            if l >= h then exit;
            i := l; j := h; k := st[l+random(h-l+1)];
            repeat
                while st[i] < k do inc(i);
                while st[j] > k do dec(j);
                if i <= j then
                  begin
                      if i < j then
                        begin
                            swap(st[i],st[j]);
                        end;
                      inc(i); dec(j);
                  end;
            until i > j;
            sort(l,j); sort(i,h);
        end;

function lay(s : string) : longint;
var i : longint;
        begin
             for i := 1 to length(s) do
               if s[i] in ['a'..'z'] then
                hash[i] := (int64(hash[i-1])*p + ord(s[i]) - ord('a')+1) mod p1
                 else hash[i] := (int64(hash[i-1])*p + ord(s[i]) - ord('A')+27) mod p1;
             exit(hash[length(s)]);
        end;

procedure push(s : string);
var i,j,m : longint;
    stt : string;
        begin
             m := length(s);
             inc(c);
             i := 1; stt := '';
             while s[i] <> ' ' do
               begin
                   stt := stt + s[i];
                   inc(i);
               end;
             inc(top); st[top] := lay(stt);
             e[c].u := st[top];
             i := i+4; stt := '';
             while i <= m do
               begin
                   stt := stt + s[i];
                   inc(i);
               end;
             inc(top); st[top] := lay(stt);
             e[c].v := st[top];
        end;

function find(x : longint) : longint;
var d,c,mid : longint;
        begin
            d := 1; c := n;
            while d <= c do
              begin
                  mid := (d+c) div 2;
                  if a[mid] = x then exit(mid)
                   else if a[mid] > x then c := mid - 1
                    else d := mid + 1;
              end;
            exit(0);
        end;

procedure khoitao;
var i,x,y : longint;
        begin
            for i := 1 to m do
              begin
                   with e[i] do
                     begin
                         x := find(u); y := find(v);
                     end;
                   ke[i] := y; next[i] := head[x];
                   head[x] := i;
              end;
        end;

procedure bfs;
var i,u,v,j : longint;
        begin
            left := 0; right := 1;
            queue[right] := bd;
            free[bd] := false;
            while left < right do
              begin
                  inc(left); u := queue[left];
                  if u = dich then
                    begin
                        res := d[left];
                        exit;
                    end;
                  j := head[u];
                  while j <> 0 do
                    begin
                        v := ke[j];
                        if free[v] then
                          begin
                              free[v] := false;
                              inc(right);
                              queue[right] := v;
                              d[right] := d[left]+1;
                          end;
                        j := next[j];
                    end;
              end;
        end;

procedure main;
var i,j : longint;
        begin
            sort(1,top);
            i := 1; j := 0;
            while i <= top do
              begin
                 while (i < top) and (st[i] = st[i+1]) do inc(i);
                 inc(j); a[j] := st[i];
                 inc(i);
              end;
            n := j;
            khoitao;
            readln(s1); readln(s2);
            bd := find(lay(s1)); dich := find(lay(s2));
            fillchar(free,sizeof(free),true);
            if (bd = 0) or (dich = 0) then exit;
            bfs;
        end;

begin
     assign(input,'ALCHEMY.INP'); reset(input);
     assign(output,'ALCHEMY.OUT'); rewrite(output);
     readln(m);
     for i := 1 to m do
       begin
           readln(s);
           push(s);
       end;
     res := -1;
     main;
     writeln(res);
end.
