Uses math;
Const
    out = 'kq.out';
    h : array [1..4] of integer = (-1,0,1,0);
    c : array [1..4] of integer = (0,1,0,-1);

Var
	heart : array [1..4,1..58,1..69] of longint;
    a : array [1..58,1..69] of longint;
	i,j,m,n,u,v,x,k,dem,temp,kq : longint;
	s,st,ss : string;
    ch : char;

begin
	m := 58; n := 69;
	assign(output,out); rewrite(output);
    for i := 1 to 4 do
     begin
         str(i,st);
         assign(input,'heart'+st+'.inp'); reset(input);
         for u := 1 to m do
         begin
           for v := 1 to n do
            begin
                read(ch);
                if ch='0' then heart[i,u,v] := 0
                 else heart[i,u,v] := 1;
            end;
           readln;
         end;
     end;
    for i := 0 to 9999 do
      begin
          str(i,st);
          while length(st) < 4 do st := '0'+st;
          assign(input,'heart_easy_'+st+'.txt'); reset(input);
          for u := 1 to m do
           for v := 1 to n do
            read(a[u,v]);
          temp := maxlongint; kq := 0;
          for j := 1 to 4 do
          begin
           dem := 0;
           for u := 1 to m do for v := 1 to n do if a[u,v] <> heart[j,u,v] then inc(dem);
           if dem < temp then
             begin
                 temp := dem; kq := j;
             end;
          end;
          write(kq);
      end;
    for i := 0 to 9999 do
      begin
          str(i,st);
          while length(st) < 4 do st := '0'+st;
          assign(input,'heart_hard_'+st+'.txt'); reset(input);
          for u := 1 to m do
           for v := 1 to n do read(a[u,v]);
          temp := maxlongint; kq := 0;
          for j := 1 to 4 do
          begin
           dem := 0;
           for u := 1 to m do
            for v := 1 to n do
             if a[u,v] <> heart[j,u,v] then inc(dem);
           if dem < temp then
             begin
                 temp := dem; kq := j;
             end;
          end;
          write(kq);
      end;
end.
