Const   inp = 'QBMST.INP';
        out = 'QBMST.OUT';
        maxn = 10001;
        maxm = 15001;
Var     fi,fo   :       text;
        head    :       array [1..maxn] of longint;
        adj,cost     :       array [1..2*maxm] of longint;