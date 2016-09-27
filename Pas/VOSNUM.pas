Uses math;
Const
	inp = 'vosnum.inp';
	out = 'VOSNUM.out';

Var
	ntest,i : longint;
	n,res : int64;
	d : array [0..9] of longint;
	mu : array [0..18] of int64;

procedure change(x : int64);
	var i,n,dem,l,ch,sl : longint;
		y : int64;
        ok : boolean;
begin
	n := 0;
	y := x;
	fillchar(d,sizeof(d),0);
	dem := 0; sl := 0;
	while y > 0 do
	  begin
	  	inc(n);
	  	inc(d[y mod 10]);
        if y mod 10 <> 0 then inc(sl);
	  	y := y div 10;
	  end;
	if n = 1 then
	  begin
	  	res := res + x-1;
	  	exit;
	  end;
	if (d[0]=n-1) then
	  begin
	  	 inc(res);
	  	 change(x-1);
	  	 exit;
	  end;
    ok := false;
	if (x-mu[n-1] <= 9) then
	  begin
	  	inc(res,x-mu[n-1]);
	  	inc(res);
	  	change(mu[n-1]-1);
	  	exit;
	  end;
    if x mod 10 = 0 then
     begin
       inc(res);
       if d[1] > 0 then
        begin
          dec(d[1]);
          dec(sl);
          ok := true;
        end;
     end;
    if (x div mu[n-1] = 1) and (x mod 10<>0) then
      begin
          dec(d[1]);
          dec(sl);
          ok := true;
      end
    else if ((x mod 10 = 1) and (d[1]=1)) then
     begin
         inc(res);
         dec(d[1]);
         dec(sl);
         ok := true;
     end;
    if ok = false then
      begin
          for i := 9 downto 1 do
           if d[i] > 0 then
            begin
                res := res + i;
                dec(d[i]);
                dec(sl);
                if (d[1]>0) then
                  begin
                      dec(d[1]);
                      inc(res);
                      dec(sl);
                  end;
                break;
            end;
      end;
    for i := 9 downto 1 do
     while d[i] > 0 do
      begin
          res := res + i;
          dec(d[i]);
          dec(sl);
          if sl <> 0 then inc(res);
      end;
    inc(res);
    change(mu[n-1]-1);
end;

begin
    assign(input,inp); reset(input);
    assign(output,out); rewrite(output);
	readln(ntest);
	mu[0] := 1;
	for i := 1 to 18 do mu[i] := mu[i-1]*10;
	while ntest > 0 do
	  begin
	  	dec(ntest);
	  	res := 0;
	  	readln(n);
	  	change(n);
	  	writeln(res);
	  end;
end.
