for(int i = 0; i < n; i++) obj[i] = i; // obj đang là hoán vị tăng dần
for(int i = K-1; i >= 0; i--) swap(obj[x[i]], obj[y[i]]); // làm ngược lại K vòng swap đầu tiên
for(int i = 0; i < K; i++) {
	swap(obj[x[i]], obj[y[i]]]); // sau khi swap i lượt đầu ta được mảng obj như định nghĩa
}