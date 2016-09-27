{$H+}
uses math;
Const   inp = '';
        out = '';
        maxn = 500;
        oo = 100000000;

Type    arr = array [0..maxn] of longint;
        arr1 = array [0..maxn] of int64;

Var     s1,s2 : string;
        a,b,c     :       arr;

{***************************************************************************}
function convert(s : string) : arr;
var a : arr;
    dem,i : longint;
    st : string;
        begin
            fillchar(a,sizeof(a),0);
            dem := 0; st := '';
            for i := length(s) downto 1 do
              begin
                  inc(dem); st := s[i]+st;
                  if dem = 8 then
                    begin
                       inc(a[0]); val(st,a[a[0]]);
                       dem := 0; st := '';
                    end;
              end;
            if dem <> 0 then
              begin
                  inc(a[0]); val(st,a[a[0]]);
              end;
            exit(a);
        end;
{***************************************************************************}
function cong(a,b : arr) : arr;
var i,nho : longint;
    x : int64;
    c : arr;
        begin
            fillchar(c,sizeof(c),0);
            c[0] := max(a[0],b[0]);
            nho := 0;
            for i := 1 to c[0] do
              begin
                  x := a[i]+b[i]+nho;
                  nho := x div oo;
                  c[i] := x mod oo;
              end;
            if nho <> 0 then
              begin
                  inc(c[0]); c[c[0]] := nho;
              end;
            exit(c);
        end;
{***************************************************************************}
function maxx(a,b : arr) : boolean;
var i : longint;
        begin
            if a[0] > b[0] then exit(true);
            if a[0] < b[0] then exit(false);
            for i := a[0] downto 1 do
             if a[i] > b[i] then exit(true)
              else if a[i] < b[i] then exit(false);
            exit(true);
        end;
{***************************************************************************}
function tru(a,b : arr) : arr;
var c : arr;
    nho,x : int64;
    i : longint;
        begin
            fillchar(c,sizeof(c),0);
            nho := 0; c[0] := max(a[0],b[0]);
            for i := 1 to c[0] do
              begin
                 x := a[i]-b[i]-nho;
                 if x >= 0 then
                   begin
                       nho := 0;
                       c[i] := x;
                   end
                 else
                   begin
                       nho := 1;
                       c[i] := x+oo;
                   end;
              end;
            while (c[0] > 1) and (c[c[0]]=0) do dec(c[0]);
            exit(c);
        end;
{***************************************************************************}
function nhan(a,b : arr) : arr;
var c : arr1;
    i,j : longint;
    x,nho : int64;
        begin
             fillchar(c,sizeof(c),0);
             fillchar(nhan,sizeof(nhan),0);
             c[0] := a[0]+b[0]-1;
             for i := 1 to a[0] do
              for j := 1 to b[0] do
               c[i+j-1] := c[i+j-1] + int64(a[i])*b[j];
             nho := 0;
             for i := 1 to c[0] do
               begin
                   x := c[i] + nho;
                   nho := x div oo;
                   c[i] := x mod oo;
               end;
             if nho <> 0 then
               begin
                   inc(c[0]);
                   c[c[0]] := nho;
               end;
             nhan[0] := c[0];
             for i := 1 to c[0] do nhan[i] := c[i];
        end;
{***************************************************************************}
procedure ghi(a : arr);
var i : longint;
    s : string;
        begin
            write(a[a[0]]);
            for i := a[0]-1 downto 1 do
              begin
                  str(a[i],s);
                  while length(s) < 8 do s := '0'+s;
                  write(s);
              end;
            writeln;
        end;
{***************************************************************************}
begin
     assign(input,inp); reset(input);
     assign(output,out); rewrite(output);
     readln(s1); readln(s2);
     a := convert(s1); b := convert(s2);
     c := cong(a,b);
     ghi(c);
     if maxx(a,b) = false then
       begin
           write('-');
           c := tru(b,a);
       end
     else c := tru(a,b);
     ghi(c);
     c := nhan(a,b);
     ghi(c);
end.

