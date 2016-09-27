Const   inp = '';
        out = '';
        maxn = 100001;
Var     fi,fo   :       text;
        t       :       array [1..4*maxn] of longint;
        b       :       array [1..4*maxn] of boolean;
        n,m,k,u,v,res     :       longint;

procedure down(i,lo,hi : longint);
        begin
             t[i] := (hi-lo+1) - t[i];
             b[i] := false;
             b[i shl 1] := not b[i shl 1];
             b[i shl 1 + 1] := not b[i shl 1+1];
        end;

procedure update(i,lo,hi : longint);
var mid,con1,con2 : longint;
        begin    Const   inp = '';
        out = '';
        maxn = 100001;
Var     fi,fo   :       text;
        t       :       array [1..4*maxn] of longint;
        b       :       array [1..4*maxn] of boolean;
        n,m,k,u,v,res     :       longint;

procedure down(i,lo,hi : longint);
        begin
             t[i] := (hi-lo+1) - t[i];
             b[i] := false;
             b[i shl 1] := not b[i shl 1];
             b[i shl 1 + 1] := not b[i shl 1+1];
        end;

procedure update(i,lo,hi : longint);
var mid,con1,con2 : longint;
        begin
             if lo > hi then exit;
             if (lo > v) or (hi < u) then exit;
             con1 := i shl 1; con2 := con1 + 1;
             if (u <= lo) and (hi <= v) then
               begin
                   if b[i]=false then t[i] := (hi-lo+1) - t[i]
                   else b[i] := true;
                   b[con1] := not b[con1];
                   b[con2] := not b[con2];
                   exit;
               end;
             mid := (lo+hi) shr 1;
             if b[con1] then down(con1,lo,mid);
             if b[con2] then down(con2,mid+1,hi);
             update(con1,lo,mid);
             update(con2,mid+1,hi);
             t[i] := t[con1] + t[con2];

        end;

procedure get(i,lo,hi : longint);
var mid,con1,con2 : longint;
        begin
             if lo > hi then exit;
             if (lo > v) or (hi < u) then exit;
             con1 := i shl 1; con2 := con1 + 1;
             if (u <= lo) and (hi <= v) then
               begin
                   if b[i] then down(i,lo,hi);
                   res := res + t[i];
                   exit;
               end;
             if b[i] then down(i,lo,hi);
             mid := (lo+hi) shr 1;
             get(con1,lo,mid);
             get(con2,mid+1,hi);
        end;

procedure main;
var i : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,n,m);
             for i := 1 to m do
               begin
                    readln(fi,k,u,v);
                    if k = 0 then update(1,1,n)
                     else begin
                               res := 0;
                               get(1,1,n);
                               writeln(fo,res);
                          end;
               end;
             close(fi); close(fo);
        end;

begin
      main;
end.

             if lo > hi then exit;
             if (lo > v) or (hi < u) then exit;
             con1 := i shl 1; con2 := con1 + 1;
             if (u <= lo) and (hi <= v) then
               begin
                   if b[i]=false then t[i] := (hi-lo+1) - t[i]
                   else b[i] := true;
                   b[con1] := not b[con1];
                   b[con2] := not b[con2];
                   exit;
               end;
             mid := (lo+hi) shr 1;
             if b[con1] then down(con1,lo,mid);
             if b[con2] then down(con2,mid+1,hi);
             update(con1,lo,mid);
             update(con2,mid+1,hi);
             t[i] := t[con1] + t[con2];

        end;

procedure get(i,lo,hi : longint);
var mid,con1,con2 : longint;
        begin
             if lo > hi then exit;
             if (lo > v) or (hi < u) then exit;
             con1 := i shl 1; con2 := con1 + 1;
             if (u <= lo) and (hi <= v) then
               begin
                   if b[i] then down(i,lo,hi);
                   res := res + t[i];
                   exit;
               end;
             if b[i] then down(i,lo,hi);
             mid := (lo+hi) shr 1;
             get(con1,lo,mid);
             get(con2,mid+1,hi);
        end;

procedure main;
var i : longint;
        begin
             assign(fi,inp); reset(fi);
             assign(fo,out); rewrite(fo);
             readln(fi,n,m);
             for i := 1 to m do
               begin
                    readln(fi,k,u,v);
                    if k = 0 then update(1,1,n)
                     else begin
                               res := 0;
                               get(1,1,n);
                               writeln(fo,res);
                          end;
               end;
             close(fi); close(fo);
        end;

begin
      main;
end.
