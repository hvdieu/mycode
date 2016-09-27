{$M 64000000,0}
{$MODE OBJFPC}
{$INLINE ON}
{$H-,I-,Q-,R-,S-}

// Result: AC
program mse07b_AnhDQ;

const
  MaxP    = 10000000;
  MaxDEAP = 1000000;

type
  DEAPType = LongInt;
  DEAP     = object
               nHeap: LongInt;
               Items: array[1..MaxDEAP + 1] of DEAPType;
               function  HighBit(x: LongInt): LongInt; inline;
               function  IsEmpty: Boolean; inline;
               function  GetMax: DEAPType; inline;
               function  GetMin: DEAPType; inline;
               procedure Init; inline;
               procedure InsertMax(pos: LongInt; key: DEAPType); inline;
               procedure InsertMin(pos: LongInt; key: DEAPType); inline;
               procedure Insert(key: DEAPType); inline;
               procedure PopMax; inline;
               procedure PopMin; inline;
             end;


var
  cmd, k, p: LongInt;
  H        : DEAP;
  Id       : array[1..MaxP] of LongInt;
(*------------------------------*)
  function DEAP.HighBit(x: LongInt): LongInt; inline;
  begin
    while (x <> (x and -x)) do Dec(x, x and -x); exit(x);
  end;
(*------------------------------*)
  function DEAP.IsEmpty: Boolean; inline;
  begin
    exit(nHeap = 1);
  end;
(*------------------------------*)
  function DEAP.GetMax: LongInt; inline;
  begin
    if nHeap = 2 then exit(Items[2]); exit(Items[3]);
  end;
(*------------------------------*)
  function DEAP.GetMin: LongInt; inline;
  begin
    exit(Items[2]);
  end;
(*------------------------------*)
  procedure DEAP.Init; inline;
  begin
    nHeap := 1;
  end;
(*------------------------------*)
  procedure DEAP.InsertMax(pos: LongInt; key: DEAPType); inline;
  begin
    while (pos >= 6) and (Items[pos shr 1] < key) do
    begin
      Items[pos] := Items[pos shr 1];
      pos := pos shr 1;
    end;
    Items[pos] := key;
  end;
(*------------------------------*)
  procedure DEAP.InsertMin(pos: LongInt; key: DEAPType); inline;
  begin
    while (pos >= 4) and (key < Items[pos shr 1]) do
    begin
      Items[pos] := Items[pos shr 1];
      pos := pos shr 1;
    end;
    Items[pos] := key;
  end;
(*------------------------------*)
  procedure DEAP.Insert(key: DEAPType); inline;
  var i: LongInt;
  begin
    Inc(nHeap);
    if nHeap = 2 then
    begin
      Items[2] := key; exit;
    end;
    i := nHeap xor (HighBit(nHeap) shr 1);
    if (nHeap shr 1) xor nHeap > nHeap then
    begin
      if i > nHeap then i := i shr 1;
      if key < Items[i] then InsertMin(nHeap, key)
      else
      begin
        Items[nHeap] := Items[i];
        InsertMax(i, key);
      end;
    end
    else if Items[i] < key then InsertMax(nHeap, key)
         else
         begin
           Items[nHeap] := Items[i];
           InsertMin(i, key);
         end;
  end;
(*------------------------------*)
  procedure DEAP.PopMax; inline;
  var i, j: LongInt;
  begin
    if nHeap < 4 then
    begin
      Dec(nHeap); exit;
    end;
    Items[1] := Items[nHeap];
    Dec(nHeap);
    i := 3;
    while i shl 1 <= nHeap do
      if (i shl 1 < nHeap) and (Items[i shl 1] < Items[i shl 1 + 1]) then
      begin
        Items[i] := Items[i shl 1 + 1]; i := i shl 1 + 1;
      end
      else
      begin
        Items[i] := Items[i shl 1]; i := i shl 1;
      end;
    j := i - (HighBit(i) shr 1);
    if j shl 1 <= nHeap then
    begin
      j := j shl 1;
      if (j < nHeap) and (Items[j] < Items[j + 1]) then Inc(j);
    end;
    if Items[1] < Items[j] then
    begin
      Items[i] := Items[j];
      InsertMin(j, Items[1]);
    end
    else InsertMax(i, Items[1]);
  end;
(*------------------------------*)
  procedure DEAP.PopMin; inline;
  var i, j: LongInt;
  begin
    Items[1] := Items[nHeap];
    Dec(nHeap);
    i := 2;
    while i shl 1 <= nHeap do
      if (i shl 1 < nHeap) and (Items[i shl 1 + 1] < Items[i shl 1]) then
      begin
        Items[i] := Items[i shl 1 + 1]; i := i shl 1 + 1;
      end
      else
      begin
        Items[i] := Items[i shl 1]; i := i shl 1;
      end;
    j := i + (HighBit(i) shr 1);
    if j > nHeap then j := j shr 1;
    if Items[j] < Items[1] then
    begin
      Items[i] := Items[j];
      InsertMax(j, Items[1]);
    end
    else InsertMin(i, Items[1]);
  end;
(*------------------------------*)
begin
  H.Init;
  repeat
    read(cmd);
    case cmd of
      0: Halt;
      1: begin
           read(k, p);
           Id[p] := k;
           H.Insert(p);
         end;
      2: begin
           if H.IsEmpty then WriteLn(0)
           else
           begin
             WriteLn(Id[H.GetMax]);
             H.PopMax;
           end;
         end;
      3: begin
           if H.IsEmpty then WriteLn(0)
           else
           begin
             WriteLn(Id[H.GetMin]);
             H.PopMin;
           end;
         end;
    end;
  until false;
end.