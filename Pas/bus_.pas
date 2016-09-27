uses
    math;
const
    fi = '';
    fo = '';
type
    bus = array [0..4] of longint;
    edge = record
        u , v : longint;
        id : longint;
    end;
    indentify = record
        i , j : longint;
    end;
    bit = record
        v , c : longint;
    end;
var
    a : array [0..100001] of bus;
    e : array [0..100001] of edge;
    fc : array [0..100001] of longint;
    fv : array [0..100001] of array of longint;
    ff : array [0..100001] of array of bit;
    block : array [0..100001 + 1] of longint;
    n , m , p , t , nb , i , j : longint;
    gg : bit;

procedure sort(l , r : longint);
var
    tedge , medge : edge;
    tbus , mbus : bus;
    i , j : longint;

    function cmp(a1 : edge ; a2 : bus ; b1 : edge ; b2 : bus) : boolean; inline;
    begin
        exit((a1.u < b1.u) or ((a1.u = b1.u) and ((a2[1] < b2[1]) or ((a2[1] = b2[1]) and (a2[4] < b2[4])))));
    end;

begin
    if (l >= r) then
        exit;
    i := l;
    j := r;
    mbus := a[(l + r) div 2];
    medge := e[(l + r) div 2];
    repeat
        while (cmp(e[i] , a[i] , medge , mbus)) do
            inc(i);
        while (cmp(medge , mbus , e[j] , a[j])) do
            dec(j);
        if (i <= j) then begin
            tedge := e[i];
            e[i] := e[j];
            e[j] := tedge;
            tbus := a[i];
            a[i] := a[j];
            a[j] := tbus;
            inc(i);
            dec(j);
        end;
    until (i >= j);
    sort(l , j);
    sort(i , r);
end;

procedure discrete(u , l , r : longint); inline;
var
    aa , vv : array [0..100001] of longint;
    i , nv , nn : longint;
    id : array [0..100001] of indentify;

    procedure qsort(l , r : longint);
    var
        tkey , key , i , j : longint;
        tid : indentify;
    begin
        if (l >= r) then
            exit;
        i := l;
        j := r;
        key := aa[(l + r) div 2];
        repeat
            while (aa[i] < key) do
                inc(i);
            while (key < aa[j]) do
                dec(j);
            if (i <= j) then begin
                tkey := aa[i];
                aa[i] := aa[j];
                aa[j] := tkey;
                tid := id[i];
                id[i] := id[j];
                id[j] := tid;
                inc(i);
                dec(j);
            end;
        until (i >= j);
        qsort(l , j);
        qsort(i , r);
    end;

begin
    nn := 0;
    for i := l to r do begin
        aa[nn + 1] := a[i][1];
        id[nn + 1].i := i;
        id[nn + 1].j := 1;
        {
        aa[nn + 2] := a[i][4];
        id[nn + 2].i := i;
        id[nn + 2].j := 4;
        nn += 2;
        }
        inc(nn);
    end;
    qsort(1 , nn);
    a[id[1].i][id[1].j] := 1;
    nv := 1;
    vv[1] := aa[1];
    for i := 2 to nn do begin
        if (aa[i] > aa[i - 1]) then begin
            inc(nv);
            vv[nv] := aa[i];
        end;
        a[id[i].i][id[i].j] := nv;
    end;
    setlength(fv[u] , nv + 1);
    fc[u] := nv;
    for i := 1 to nv do
        fv[u][i] := vv[i];
end;

procedure qsort(l , r : longint);
var
    tbus , mbus : bus;
    tedge : edge;
    i , j : longint;

    function cmp(a , b : bus) : boolean; inline;
    begin
        exit( (a[0] < b[0]) or ((a[0] = b[0]) and (a[4] < b[4])) );
    end;

begin
    if (l >= r) then
        exit;
    i := l;
    j := r;
    mbus := a[(l + r) div 2];
    repeat
        while (cmp(a[i] , mbus)) do
            inc(i);
        while (cmp(mbus , a[j])) do
            dec(j);
        if (i <= j) then begin
            tbus := a[i];
            a[i] := a[j];
            a[j] := tbus;
            tedge := e[i];
            e[i] := e[j];
            e[j] := tedge;
            inc(i);
            dec(j);
        end;
    until (i >= j);
    qsort(l , j);
    qsort(i , r);
end;

function search(u , v : longint) : longint; inline;
var
    l , r , mid : longint;
begin
    l := 1;
    r := fc[u];
    if (l > r) or (fv[u][r] < v) then
        exit(0);
    while (l < r) do begin
        mid := (l + r) div 2;
        if (fv[u][mid] < v) then
            l := mid + 1
        else
            r := mid;
    end;
    exit(l);
end;

function max(a , b : bit) : bit; inline;
begin
    if (a.v + (b.c - a.c) > b.v) then
        exit(a)
    else
        exit(b);
end;

function min(a , b : bit) : bit; inline;
begin
    if (a.v + (b.c - a.c) > b.v) then
        exit(b)
    else
        exit(a);
end;

function max(a , b : longint) : longint; inline;
begin
    if (a > b) then
        exit(a)
    else
        exit(b);
end;

function min(a , b : longint) : longint; inline;
begin
    if (a > b) then
        exit(b)
    else
        exit(a);
end;

function get(u , index : longint) : bit; inline;
begin
    index := min(index , fc[u]);
    get.v := t + 1;
    get.c := 0;
    while (index > 0) do begin
        get := min(get , ff[u][index]);
        dec(index , index and -index);
    end;
end;

procedure update(u , index : longint ; v : bit); inline;
begin
    while (index <= fc[u]) do begin
        ff[u][index] := min(ff[u][index] , v);
        inc(index , index and -index);
    end;
end;

begin
    assign(input , fi);
    reset(input);
    assign(output , fo);
    rewrite(output);
    //Input
    read(n , m , p , t);
    fillchar(fc , sizeof(fc) , 0);
    for i := 1 to m do begin
        read(e[i].u , e[i].v , a[i][1] , a[i][2] , a[i][3] , a[i][4]);
        //fc[e[i].u] += 1;
        a[i][0] := a[i][1];
        //fc[e[i].v] += 1;
        e[i].id := i;
    end;
    //
    inc(m);
    e[m].u := p;
    e[m].v := p;
    e[m].id := m;
    //fc[p] += 1;
    a[m][0] := t;
    a[m][1] := t;
    a[m][2] := t;
    a[m][3] := t;
    a[m][4] := t;
    //Predict
    sort(1 , m);
    nb := 1;
    block[1] := 1;
    for i := 2 to m do
        if (e[i].u > e[block[nb]].u) then begin
            inc(nb);
            block[nb] := i;
        end;
    block[nb + 1] := m + 1;
    for i := 1 to nb do
        discrete(e[block[i]].u , block[i] , block[i + 1] - 1);
    //Solve
    qsort(1 , m);
    for i := 1 to n do begin
        setlength(ff[i] , fc[i] + 1);
        for j := 0 to fc[i] do begin
            ff[i][j].v := t + 1;
            ff[i][j].c := 0;
        end;
    end;
    for i := 1 to m do begin
        //if (a[i][4] <= t) then begin
            gg := get(e[i].u , a[i][1]);
            if (gg.v = t + 1) then
                gg.v := 0;
            inc(gg.v , a[i][2] - gg.c);
            if (e[i].id <> m) then begin
                if (e[i].u = 1) or (gg.c > 0) then begin
                    gg.c := a[i][3];
                    j := search(e[i].v , a[i][4]);
                    if (j > 0) then
                        update(e[i].v , j , gg);
                end;
            end
            else begin
                if (gg.c = 0) and (p > 1) then
                    writeln(-1)
                else
                    writeln(gg.v);
                exit;
            end;
    end;
end.




