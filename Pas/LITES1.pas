{$MODE OBJFPC}
const
  maxn = 100000;
  fi = 'lites.1.in';
  out = 'lites.out';
var
  sl : array[0..maxn * 8] of integer;
  tt : array[0..maxn * 8] of boolean;
  n, m, kq  : integer;
  f,fo : text;

procedure Truyvan0(r, l, k, i, j : integer);
var
  mid : integer;
begin
  if (i > k) or (j < l) then exit;
  if (i <= l) and (k <= j) then
  begin
    if tt[r] then sl[r] := k - l + 1 - sl[r];
    tt[r] := true;
    exit;
  end;

  mid := (l + k) div 2;
  tt[2 * r] := tt[r];
  tt[2 * r + 1] := tt[r];
  tt[r] := false;
  Truyvan0(r * 2, l, mid, i, j);
  Truyvan0(r * 2 + 1, mid + 1, k, i, j);
  sl[r] := sl[2 * r] + sl[2 * r + 1];
end;

procedure Truyvan1(r, l, h, i, j : integer);
var
  mid : integer;
begin
  if (h < i) or (l > j) then exit;

  if (i <= l) and (h <= j) then
  begin
    kq := kq + sl[r];
    exit;
  end;

  mid := (l + h) div 2;
  Truyvan1(r * 2, l, mid, i, j);
  Truyvan1(r * 2 + 1, mid + 1, h, i, j);
end;

procedure Input;
var
  k, u, v, i : integer;
begin
  assign(f, fi); reset(f);
  assign(fo,out); rewrite(fo);
  readln(f, n, m);
  fillchar(tt, sizeof(tt), false);
  fillchar(sl, sizeof(sl), 0);
  for i := 1 to m do
  begin
    readln(f, k, u, v);
    if k = 0 then truyvan0(1, 1, n, u, v);
    if k = 1 then
    begin
      kq := 0;
      truyvan1(1, 1, n, u, v);
      writeln(fo,kq);
    end;
  end;
  close(f); close(fo);
end;

begin
  Input;
end.

