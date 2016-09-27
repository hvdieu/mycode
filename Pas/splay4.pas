{$INLINE ON}
{$MODE OBJFPC}
Uses math;
Const
    inp = '';
    out = '';
    maxn = 100001;

Type
    pnode = ^tnode;
    tnode = record
        key,con : longint;
        cha,left,right : pnode;
    end;

Var
    nilt,root,i : pnode;
    n,ntest,u,v,x,res : longint;
    a,t : array [1..maxn] of longint;
    time : real;

procedure cnt(i,j : pnode; ok : boolean); inline;
begin
    j^.cha := i;
    if ok then i^.left := j else i^.right := j;
end;

procedure update(i : pnode); inline;
begin
    i^.con := i^.left^.con + i^.right^.con+1;
end;

procedure tao(var i : pnode); inline;
begin
    new(i); i^.left := nilt; i^.right := nilt; i^.cha := nilt;
    i^.con := 1;
end;

function inn(l,r : longint) : pnode;
    var mid : longint;
        i : pnode;
begin
    if l > r then exit(nilt);
    mid := (l+r) div 2;
    tao(i); i^.key := mid;
    cnt(i,inn(l,mid-1),true);
    cnt(i,inn(mid+1,r),false);
    update(i);
    exit(i);
end;

function find(u : longint) : pnode; inline;
    var i : pnode;
begin
    i := root;
    repeat
        if i^.left^.con+1=u then exit(i);
        if i^.left^.con >= u then i := i^.left
         else begin
            u := u-i^.left^.con-1;
            i := i^.right;
         end;
    until false;
end;

procedure Uptree(i : pnode); inline;
    var j,p,pp : pnode;
begin
    p := i^.cha; pp := p^.cha;
    if i=p^.left then
      begin
         j := i^.right;
         cnt(i,p,false);
         cnt(p,j,true);
      end
    else begin
        j := i^.left;
        cnt(i,p,true);
        cnt(p,j,false);
    end;
    cnt(pp,i,pp^.left=p);
    update(p); update(i);
end;

procedure splay(i : pnode); inline;
    var j,p,pp : pnode;
begin
    while i^.cha <> nilt do
      begin
        p := i^.cha; pp := p^.cha;
        if pp <> nilt then
          begin
            if (pp^.left=p) = (p^.left=i) then Uptree(p)
              else Uptree(i);
          end;
        Uptree(i);
      end;
end;

procedure Ups(i : pnode); inline;
    var j : pnode;
begin
    j := i;
    while j<>nilt do
      begin
        update(j);
        j := j^.cha;
      end;
    splay(i);
    root := i;
end;

function Delete(u : longint) : longint; inline;
    var i,j,p : pnode;
        x : longint;
begin
    i := find(u); x := i^.key;
    if (i^.left<>nilt) and (i^.right<>nilt) then
      begin
        j := i^.left;
        while j^.right <> nilt do j := j^.right;
        i^.key := j^.key;
        i := j;
      end;
    if i^.left<>nilt then j := i^.left
     else j := i^.right;
    p := i^.cha;
    cnt(p,j,p^.left=i);
    if root=i then root := j;
    dispose(i);
    if j<>nilt then Ups(j)
     else Ups(p);
    exit(x);
end;

procedure add(j : pnode;u : longint); inline;
    var i,p : pnode;
begin
    if u=n then
      begin
        i := root;
        while i^.right <> nilt do i := i^.right;
        cnt(i,j,false);
        exit;
      end;
    i := find(u);
    if i^.left=nilt then cnt(i,j,true)
     else begin
        i := i^.left;
        while i^.right <> nilt do i := i^.right;
        cnt(i,j,false);
     end;
    Ups(j);
end;

procedure inn2(i : pnode);
begin
    if i^.left<>nilt then inn2(i^.left);
    inc(n); a[n] := i^.key;
    if i^.right <> nilt then inn2(i^.right);
end;

procedure update1(i,val : longint); inline;
begin
    while i <= n do
      begin
        t[i] := max(t[i],val);
        inc(i,i and (-i));
      end;
end;

function get(i : longint) : longint; inline;
    var s : longint;
begin
    s := 0;
    while i > 0 do
      begin
        s := max(s,t[i]);
        dec(i,i and (-i));
      end;
    exit(s);
end;

procedure main; inline;
    var i,j : longint;
begin
    for i := 1 to n do
      begin
         x := get(a[i])+1;
         res := max(res,x);
         update1(a[i],x);
      end;
    writeln(n-res);
end;

begin
   // time := gettickcount;
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
    readln(n,ntest);
    new(nilt); nilt^.con := 0;
    root := inn(1,n);
    while ntest > 0 do
      begin
        dec(ntest);
        readln(u,v);
        if u<>v then
        begin
        x := Delete(u);
        tao(i); i^.key := x;
        add(i,v);
        end;
      end;
    n := 0;
    inn2(root);
    main;
   // writeln((gettickcount-time)/1000:0:4);
end.


