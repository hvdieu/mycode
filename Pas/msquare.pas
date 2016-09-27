program msquare;
const    inp = 'msquare.in10';
         out = 'msquare.out';
         max = 40320;
var      fi,fo :        text;
         x    :       array [1..8] of byte;
         target,a :       string;
         d      :       array [12345678..87654321] of boolean;
         queue  :       array [0..max] of string;
         t      :       array [0..max] of string;
         l      :       array [1..max] of longint;
         left,right     :       longint;
         kq     :       char;
{*      *       *       *       *}
Procedure Swap(Var u,v : char);
var temp : char;
BEGIN
    temp:=u;
    u:=v;
    v:=temp;
END;
{*       *      *       *       *}
procedure input;
var i : byte;
    e : string;
BEGIN
    target:='';
    assign(fi,inp);reset(fi);
    for i:=1 to 8 do
      BEGIN
          read(fi,x[i]);
          str(x[i],e);
          target:=target+e;
      END;
    close(fi);
    Swap(target[5],target[8]);
    swap(target[6],target[7]);

END;
{*      *       *       *       *}
procedure init;
var i : byte;
begin
    fillchar(d,sizeof(d),true);
    a:='12348765';

end;
{*      *       *       *       *}
procedure xoaya;
var k : byte;
BEGIN
   for k:=1 to 4 do swap(a[k],a[k+4]);
END;
{*      *       *       *       *}
procedure nguoca;
var k : byte;
BEGIN
   for k:=1 to 4 do swap(a[k],a[k+4]);
END;
{*      *       *       *       *}
procedure xoayb;
BEGIN
   swap(a[3],a[4]);
   swap(a[3],a[2]);
   swap(a[2],a[1]);
   swap(a[8],a[7]);
   swap(a[7],a[6]);
   swap(a[6],a[5]);
END;
{*      *       *       *       *}
procedure nguocb;
BEGIN
   swap(a[6],a[5]);
   swap(a[7],a[6]);
   swap(a[8],a[7]);
   swap(a[2],a[1]);
   swap(a[3],a[2]);
   swap(a[3],a[4]);
END;
{*      *       *       *       *}
procedure xoayc;
BEGIN
    swap(a[2],a[3]);
    swap(a[2],a[6]);
    swap(a[6],a[7]);
END;
{*      *       *       *       *}
procedure nguocc;
BEGIN
    swap(a[6],a[7]);
    swap(a[2],a[6]);
    swap(a[2],a[3]);
END;
{*      *       *       *       *}
procedure xuly;
var s : longint;
BEGIN
    left:=0;
    right:=1;
    queue[right]:=a;
    l[right]:=1;
    while left<right do
       BEGIN
           Inc(left);
           a:=queue[left];
           xoaya;
           val(a,s);
           if d[s] then
             BEGIN
                 inc(right);
                 queue[right]:=a;
                 l[right]:=l[left]+1;
                 t[right]:=t[left]+'A';
                 d[s]:=false;
                 if a=target then
                   BEGIN
                     kq:='A';
                     exit;
                   END;
             END;
           nguoca;
           xoayb;
           val(a,s);
           if d[s] then
             BEGIN
                 Inc(right);
                 queue[right]:=a;
                 l[right]:=l[left]+1;
                 t[right]:=t[left]+'B';
                 d[s]:=false;
                 if a=target then
                   BEGIN
                     kq:='B';
                     exit;
                   END;
             END;
           nguocb;
           xoayc;
           val(a,s);
           if d[s] then
             BEGIN
                 inc(right);
                 queue[right]:=a;
                 l[right]:=l[left]+1;
                 t[right]:=t[left]+'C';
                 d[s]:=false;
                 if a=target then
                   BEGIN
                     kq:='C';
                     exit;
                   END;
             END;
           nguocc;
       END;
END;
{*      *       *       *       *}
Procedure output;
var i : byte;
    k : string;
BEGIN
    assign(fo,out);rewrite(fo);
    writeln(fo,l[left]);
    k:=t[left];
    for i:=1 to l[left]-1 do
     write(fo,k[i]);
     write(fo,kq);
    close(fo);
END;
{*      *       *       *       *}
BEGIN
    input;
    init;
    xuly;
    output;
END.
