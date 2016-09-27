Uses crt;
Var tuoicha,tuoicon : longint;

begin
    clrscr;
    write('Nhap tuoi cha : '); readln(tuoicha);
    write('Nhap tuoi con : '); readln(tuoicon);
    write('Sau ',tuoicha-2*tuoicon,' nam thi tuoi cha gap doi tuoi con');
    readln;
end.