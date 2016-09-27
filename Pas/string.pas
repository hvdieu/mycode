 {$H+}
Uses math;

Const   maxn = 200001;
        p = 26;
        p1 = 1000000003;

Type    arr = array [1..maxn] of int64;

Var     n,i ,l,d,c,mid,res,top    :       longint;
        s       :       string;
        hash,mu    :       array [0..maxn] of int64;
        st         :  array [1..maxn] of int64;

function gethash(i,j : longint) : int64;
        begin
            gethash := (hash[j] - (int64(hash[i-1])*mu[j-i+1] mod p1) + p1) mod p1;
        end;

procedure swap(var xx,yy : int64);
var temp : int64;
        begin
            temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint; var k : arr);
var i,j : longint;
    key : int64;
        begin
            if l >= h then exit;
            i := l; j := h; key := k[l+random(h-l+1)];
            repeat
               while k[i] < key do inc(i);
               while k[j] > key do dec(j);
               if i <= j then
                 begin
                     if i < j then swap(k[i],k[j]);
                     inc(i); dec(j);
                 end;
            until i > j;
            sort(l,j,k); sort(i,h,k);
        end;

function check(l : longint) : boolean;
var i : longint;
        begin
              top := 0;
              for i := 1 to n-l+1 do
                begin
                    inc(top);
                    st[top] := gethash(i,i+l-1);
                end;
              sort(1,top,st);
              for i := 1 to top-1 do
               if st[i] = st[i+1] then exit(true);
              exit(false);
        end;


procedure find;
var i : longint;
        begin
            mu[0] := 1;
            for i := 1 to n do
              begin
                  mu[i] := (int64(mu[i-1])*p) mod p1;
                  hash[i] := (int64(hash[i-1])*p + ord(s[i]) - ord('a')+1) mod p1;
              end;
            d := 1; c := n-1;
            while d <= c do
              begin
                  mid := (d+c) div 2;
                  if check(mid) then
                    begin
                        res := mid;
                        d := mid + 1;
                    end
                  else c := mid - 1;
              end;
            write(res);
        end;

begin
      assign(input,'string.inp'); reset(input);
      assign(output,'string.out'); rewrite(output);
      readln(n);
      readln(s);
      find;
end.

