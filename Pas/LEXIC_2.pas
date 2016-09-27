Const   maxn = 27;
Var     c,a     :       array [0..maxn,0..maxn] of string;
        gt      :       array [0..maxn] of string;
        count   :       array ['a'..'z'] of longint;
        free    :       array ['a'..'z'] of boolean;
        m,n,ntest     :       longint;
        kind,spc    :     char;
        s,res       :   string;

function cong(a,b : string) : string;
var sum,carry,i,x,y : longint;
    c   :       string;
        begin
             carry := 0;  c := '';
             while length(a) < length(b) do a := '0' + a;
             while length(a) > length(b) do b := '0'+ b;
             for i := length(a) downto 1 do
              begin
                  x := ord(a[i])-ord('0');
                  y := ord(b[i])-ord('0');
                  sum := x+y+carry;
                  carry := sum div 10;
                  c := chr(sum mod 10 +48)+c;
              end;
             if carry > 0 then c := '1'+c;
             exit(c);
        end;

function tru(a,b : string) : string;
var c : string;
    s,borrow,i  : longint;
        begin
             borrow := 0; c := '';
             while length(a) < length(b) do a := '0' + a;
             while length(a) > length(b) do b := '0' + b;
             for i := length(a) downto 1 do
               begin
                  s := ord(a[i]) - ord(b[i]) - borrow;
                  if s < 0 then
                   begin
                        s := s + 10;
                        borrow := 1;
                   end else borrow := 0;
                   c := chr(s+48)+c;
               end;
             while (length(c) > 1) and (c[1]='0') do delete(c,1,1);
             exit(c);
        end;

function nhan1(a : string; b : longint) : string;
var i,carry,s : longint;
    c,tmp : string;
        begin
             c := '';
             carry := 0;
             for i := length(a) downto 1 do
               begin
                   s := (ord(a[i])-48)*b + carry;
                   carry := s div 10;
                   c := chr(s mod 10 + 48) + c;
               end;
             if carry > 0 then str(carry,tmp) else tmp := '';
             nhan1 := tmp+c;
        end;

function nhan(a,b : string) : string;
var sum,tmp : string;
    m,i,j : longint;
        begin
             m := -1; sum := '';
             for i := length(a) downto 1 do
               begin
                   m := m+1;
                   tmp := nhan1(b,ord(a[i])-48);
                   for j := 1 to m do tmp := tmp + '0';
                   sum := cong(tmp,sum);
               end;
             exit(sum);
        end;

procedure khoitao;
var i,j : longint;
    tmp : string;
        begin
            gt[0] := '1';
            for i := 1 to 26 do
             begin
                str(i,tmp);
                gt[i] := nhan(gt[i-1],tmp);
             end;
            for i := 0 to 26 do
             begin
              c[0,i] := '1';
              a[0,i] := '1';
             end;
            for i := 1 to 26 do
             begin
               c[i,0] := '0';
               a[i,0] := '0';
             end;
            for i := 1 to 26 do
             for j := i to 26 do
              begin
               c[i,j] := cong(c[i-1,j-1],c[i,j-1]);
               a[i,j] := nhan(c[i,j],gt[i]);
              end;
        end;

procedure sub1;
var i,j : longint;
    ok : boolean;
    ch,cuoi : char;
        begin
            fillchar(count,sizeof(count),0);
            ok := true;
            for i := 1 to length(s) do
              begin
                  inc(count[s[i]]);
                  if ord(s[i]) - ord('a') + 1 > n then
                    begin
                        ok := false;
                        break;
                    end;
              end;
            for ch := 'a' to 'z' do
              if count[ch] > 1 then
                begin
                    ok := false;
                    break;
                end;
            if ok = false then
              begin
                  writeln('Incorrect data');
                  exit;
              end;
            res := '0';
            cuoi := chr(97+n-1);
            fillchar(free,sizeof(free),true);
            for i := 1 to length(s) do
              begin
                   for ch := 'a' to chr(ord(s[i])-1) do
                    if free[ch] then
                     res := cong(res,a[m-i,n-i]);
                   free[s[i]] := false;
              end;
            res := cong(res,'1');
            writeln(res);
        end;

function cmp(a,b : string) : integer;
        begin
             while length(a) < length(b) do a := '0'+a;
             while length(a) > length(b) do b := '0' + b;
             if a = b then exit(0);
             if a > b then exit(1);
             exit(-1);
        end;

procedure sub2;
var i,j : longint;
    ch : char;
        begin
             if cmp(s,a[m,n]) = 1 then
               begin
                   writeln('Incorrect data');
                   exit;
               end;
             res := '';
             fillchar(free,sizeof(free),true);
             for i := 1 to m do
               begin
                   for ch := 'a' to 'z' do
                   if free[ch] then
                    if cmp(s,a[m-i,n-i]) = 1 then s := tru(s,a[m-i,n-i])
                     else
                       begin
                           res := res + ch;
                           free[ch] := false;
                           break;
                       end;
               end;
             writeln(res);
        end;

procedure nhap;
var i,j : longint;
        begin
             assign(input,'LEXIC.INP'); reset(input);
             assign(output,'LEXIC.OUT'); rewrite(output);
             readln(ntest);
             while ntest > 0 do
               begin
                   dec(ntest);
                   readln(n,m);
                   read(kind,spc); readln(s);
                   if kind = 'P' then sub1
                    else sub2;
               end;
        end;

begin
      khoitao;
      nhap;
end.