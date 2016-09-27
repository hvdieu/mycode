uses math;
Const   inp = '';//'message1.inp';
        out = '';//'message1.out';
        maxn = 110;
        p = 26;
       { p1 = 999983;
        p2 = 98765431;}
        p1 = 1000000007;
        p2 = 1000000007;

Var     fi,fo   :       text;
        a,b     :       array [1..maxn,1..maxn] of integer;
        s1,s2   :       array [1..maxn,0..maxn] of longint;
        f1,f2   :       array [1..maxn,1..maxn,0..maxn] of longint;
        mu1     :       array [0..maxn*maxn] of longint;
        st      :   array [1..maxn*maxn] of longint;
        n,m,top,d,r,res,t     :       longint;

function gethasha(i,l,r : longint) : longint;
        begin
             gethasha := (s1[i,r] - int64(s1[i,l-1])*mu1[r-l+1] + int64(p1)*p1) mod p1;
        end;

function gethashb(i,l,r : longint) : longint;
        begin
             gethashb := (s2[i,r] - int64(s2[i,l-1])*mu1[r-l+1] + int64(p1)*p1) mod p1;
        end;

procedure khoitao;
var i : longint;
        begin
            mu1[0] := 1;
           for i := 1 to 10001 do
                mu1[i] := int64(mu1[i-1])*p mod p1;
        end;

procedure init;
var i,j,l,r : longint;
    x   :       int64;
        begin

           for i := 1 to m do
             for j := 1 to n do
              begin
                   s1[i,j] := (int64(s1[i,j-1])*p + a[i,j] ) mod p1;
                   s2[i,j] := (int64(s2[i,j-1])*p + b[i,j] ) mod p1;
              end;

           for l := 1 to n do
             for r := l to n do
              for i := 1 to m do
               begin
               f1[l,r,i] := ((int64(f1[l,r,i-1])*mu1[r-l+1]) mod p2 + (s1[i,r] - int64(s1[i,l-1])*mu1[r-l+1] + int64(p1)*p1) mod p1) mod p2;
               f2[l,r,i] := ((int64(f2[l,r,i-1])*mu1[r-l+1]) mod p2 + (s2[i,r] - int64(s2[i,l-1])*mu1[r-l+1] + int64(p1)*p1) mod p1) mod p2;
               end;
        end;

function gethashf1(l,r,i,j : longint) : longint;
        begin
         gethashf1 := (f1[l,r,j] - int64(f1[l,r,i-1])*mu1[(r-l+1)*(j-i+1)] + int64(p2)*p2) mod p2;
        end;

function gethashf2(l,r,i,j : longint) : longint;
        begin
         gethashf2 := (f2[l,r,j] - int64(f2[l,r,i-1])*mu1[(r-l+1)*(j-i+1)] + int64(p2)*p2) mod p2;
        end;

procedure swap(var xx,yy : longint);
var temp : longint;
        begin
             temp := xx; xx := yy; yy := temp;
        end;

procedure sort(l,h : longint);
var i,j,key : longint;
        begin
             if l >= h then exit;
             i := l; j := h;
             key := st[(l+h) div 2];
             repeat
                  while st[i] < key do inc(i);
                  while st[j] > key do dec(j);
                  if i <= j then
                    begin
                         if i < j then swap(st[i],st[j]);
                         inc(i); dec(j);
                    end;
             until i > j;
             sort(l,j); sort(i,h);
        end;

function find(d,c,key : longint) : longint;
var mid : longint;
        begin
             while d <= c do
               begin
                    mid := (d+c) div 2;
                    if st[mid] = key then exit(mid)
                     else if key > st[mid] then d := mid + 1
                      else c := mid - 1;
               end;
             exit(0);
        end;

function check : boolean;
var i,j,vt,x : longint;
        begin
             sort(1,top);
             for i := 1 to m-r+1 do
              for j := 1 to n-d+1 do
               begin
                   x := gethashf2(j,j+d-1,i,i+r-1);
                   vt := find(1,top,x);
                   if vt <> 0 then exit(true);
               end;
             exit(false);
        end;

procedure main;
var i,j : longint;
        begin
             res := 0;  r:=1;
             for d := n downto 1 do
               while r<>m+1 do
                 begin
                   top := 0;
                   for i := 1 to m-r+1 do
                   for j := 1 to n-d+1 do
                        begin
                             inc(top);
                             st[top] := gethashf1(j,j+d-1,i,i+r-1);
                        end;
                   if check = false then break else
                     begin
                       if d*r > res then res := d*r;
                       inc(r);
                     end;
                 end;
             writeln(fo,res);
        end;
procedure input;
var i,j : longint;
    ch : char;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,t);
             khoitao;
             while t > 0 do
               begin
                    dec(t);
                    readln(fi,m,n);
                    for i := 1 to m do
                     begin
                          for j := 1 to n do
                           begin
                             read(fi,ch);
                             a[i,j] := ord(ch) - ord('a');
                           end;
                          readln(fi);
                     end;
                    for i := 1 to m do
                     begin
                          for j := 1 to n do
                          begin
                            read(fi,ch);
                            b[i,j] := ord(ch) - ord('a');
                          end;
                          readln(fi);
                     end;
                    init;
                    main;
               end;
             close(fi); close(fo);
        end;

begin
     input;
end.



