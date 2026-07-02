# 📊 Estimasi Tingkat Kemandirian Belajar Mahasiswa Program Studi Statistika Universitas Mataram Menggunakan Two Stage Cluster Sampling
## DESKRIPSI PROYEK
Repository ini mendokumentasikan proses analisis survei mengenai tingkat kemandirian belajar mahasiswa Program Studi Statistika Universitas Mataram menggunakan pendekatan Two Stage Cluster Sampling.

Pengumpulan data dilakukan melalui penyebaran kuesioner skala Likert kepada mahasiswa yang dipilih menggunakan teknik pengambilan sampel dua tahap. Analisis data dilakukan menggunakan bahasa pemrograman R, meliputi pengolahan data, uji validitas, uji reliabilitas, statistik deskriptif, pembobotan sampel, serta estimasi parameter populasi melalui perhitungan Standard Error (SE), Confidence Interval (CI), Relative Standard Error (RSE), dan Design Effect (DEFF).

Repository ini bertujuan menyajikan tahapan analisis secara sistematis dan terdokumentasi sehingga dapat menjadi referensi dalam penerapan metode Two Stage Cluster Sampling untuk penelitian survei di bidang pendidikan, khususnya dalam mengestimasi tingkat kemandirian belajar mahasiswa.
___

## STRUKTUR REPOSITORY

UAS-Teknik-Sampling/
│
├── README.md
├── Analisis.R
├── TEKNIK SAMPLING UAS.xlsx
├── Executive Summary.docx
└── Pertanyaan Kuisioner.pdf

Keterangan:
README.md → Dokumentasi proyek.
Analisis.R → Script lengkap analisis data menggunakan R.
TEKNIK SAMPLING UAS.xlsx → Dataset hasil survei yang dianalisis.
Executive Summary.docx → Ringkasan hasil penelitian.
Pertanyaan Kuisioner.pdf → Instrumen penelitian yang digunakan dalam pengumpulan data.
___

# DAFTAR ISI

- [Deskripsi Proyek](#deskripsi-proyek)
- [Struktur Repository](#struktur-repository)
- [Latar Belakang](#latar-belakang)
- [Tujuan Penelitian](#tujuan-penelitian)
- [Metode Penelitian](#metode-penelitian)
- [Data Penelitian](#data-penelitian)
- [Tahapan Analisis](#tahapan-analisis)
  - [1. Import Data](#1-import-data)
  - [2. Persiapan Data](#2-persiapan-data)
  - [3. Uji Validitas](#3-uji-validitas)
  - [4. Uji Reliabilitas](#4-uji-reliabilitas)
  - [5. Statistik Deskriptif](#5-statistik-deskriptif)
  - [6. Pembobotan Sampel](#6-pembobotan-sampel)
  - [7. Estimasi Parameter Survei](#7-estimasi-parameter-survei)
  - [8. Estimasi per Cluster](#8-estimasi-per-cluster)
  - [9. Kategorisasi Tingkat Kemandirian Belajar](#9-kategorisasi-tingkat-kemandirian-belajar)
- [Hasil Analisis](#hasil-analisis)
- [Kesimpulan](#kesimpulan)
- [Software yang Digunakan](#software-yang-digunakan)
- [Penulis](#penulis)
___

## LATAR BELAKANG
Kemandirian belajar merupakan salah satu faktor yang mendukung keberhasilan mahasiswa dalam proses pembelajaran. Mahasiswa yang memiliki kemandirian belajar mampu mengatur waktu, mencari sumber belajar, dan menyelesaikan tugas secara mandiri. Oleh karena itu, perlu dilakukan pengukuran untuk mengetahui tingkat kemandirian belajar mahasiswa melalui survei.

Dalam penelitian ini digunakan metode Two-Stage Cluster Sampling karena populasi mahasiswa telah terbagi ke dalam beberapa kelas sehingga proses pengambilan sampel menjadi lebih efisien. Data yang diperoleh kemudian dianalisis menggunakan bahasa pemrograman R, meliputi uji validitas, uji reliabilitas, statistik deskriptif, pembobotan sampel, serta estimasi parameter survei. Hasil analisis diharapkan dapat memberikan gambaran mengenai tingkat kemandirian belajar mahasiswa sekaligus menunjukkan penerapan metode Two-Stage Cluster Sampling dalam analisis data survei.
___

## TUJUAN PENELITIAN

Penelitian ini bertujuan untuk:

- Mengestimasi tingkat kemandirian belajar mahasiswa Program Studi Statistika Universitas Mataram menggunakan metode **Two-Stage Cluster Sampling**.
- Menguji validitas dan reliabilitas instrumen penelitian.
- Menghitung estimasi rata-rata tingkat kemandirian belajar beserta ukuran ketelitiannya, seperti **Standard Error (SE)**, **Confidence Interval (CI)**, **Relative Standard Error (RSE)**, dan **Design Effect (DEFF)**.
- Menunjukkan penerapan metode **Two-Stage Cluster Sampling** menggunakan bahasa pemrograman **R**.
___

## METODOLOGI PENELITIAN
Penelitian ini menggunakan pendekatan kuantitatif dengan metode survei. Pengumpulan data dilakukan melalui penyebaran kuesioner kepada mahasiswa Program Studi Statistika Universitas Mataram untuk memperoleh informasi mengenai tingkat kemandirian belajar.

Populasi penelitian adalah mahasiswa Program Studi Statistika Universitas Mataram. Teknik pengambilan sampel yang digunakan adalah Two-Stage Cluster Sampling, yaitu pengambilan sampel dalam dua tahap. Pada tahap pertama dipilih cluster (kelas) sebagai unit sampling primer, kemudian pada tahap kedua dipilih sejumlah mahasiswa dari setiap cluster terpilih sebagai responden penelitian.

Instrumen yang digunakan berupa kuesioner yang terdiri atas 10 butir pertanyaan mengenai kemandirian belajar. Setiap butir diukur menggunakan skala Likert 4 poin, yaitu:
| Skor | Kategori |
|:----:|----------|
| 1 | Sangat Tidak Setuju |
| 2 | Tidak Setuju |
| 3 | Setuju |
| 4 | Sangat Setuju |
___

## ANALISIS DATA
Analisis data pada penelitian ini dilakukan menggunakan bahasa pemrograman **R**. Tahapan analisis yang dilakukan adalah sebagai berikut.

### 1. Import Data
Tahap ini bertujuan untuk membaca data hasil kuesioner yang tersimpan dalam file Microsoft Excel ke dalam lingkungan kerja R. Selain itu, package yang dibutuhkan untuk analisis juga dipanggil agar seluruh fungsi dapat digunakan.
**kode**
library(readxl)
library(psych)
library(survey)

data <- read_excel("D:/TEKNIK SAMPLING UAS.xlsx")

View(data)

**Keterangan**
readxl: digunakan untuk membaca file Excel.
psych: digunakan untuk melakukan uji validitas dan reliabilitas.
survey: digunakan untuk analisis data survei menggunakan desain sampling kompleks.
View(): digunakan untuk menampilkan data dalam bentuk spreadsheet sehingga dapat dilakukan pemeriksaan awal terhadap isi data.

### 2. Persiapan Data
Menentukan variabel yang digunakan sebagai indikator dalam pengukuran tingkat kemandirian belajar.
**kode**
item <- c("P1","P2","P3","P4","P5",
          "P6","P7","P8","P9","P10")

**Keterangan**
Objek item berisi daftar nama variabel yang akan digunakan dalam seluruh proses analisis.
Dengan menyimpan nama variabel dalam satu objek, proses pengolahan data menjadi lebih efisien karena dapat dipanggil secara bersamaan.

### 3. Mengubah Data Menjadi Numeriks
Mengubah tipe data seluruh item menjadi numerik agar dapat dilakukan analisis statistik.
**kode**
data[item] <- lapply(
data[item],
function(x)
as.numeric(as.character(x)))

**Keterangan**
data[item]: Memilih variabel P1 sampai P10.
Fungsi lapply() digunakan untuk menjalankan proses konversi pada seluruh item secara otomatis.
as.numeric(as.character(x)): Data yang masih terbaca sebagai karakter diubah menjadi numerik sehingga dapat digunakan dalam perhitungan statistik.

### 4. Uji Validitas
Mengetahui apakah setiap butir pertanyaan mampu mengukur variabel kemandirian belajar secara tepat.
**kode**
data$TOTAL <- rowSums(data[item])

hasil_validitas <- data.frame()

for(i in item){

total_koreksi <- data$TOTAL-data[[i]]

uji <- cor.test(
data[[i]],
total_koreksi,
method="pearson")

hasil_validitas <- rbind(
hasil_validitas,
data.frame(
Item=i,
r_hitung=round(uji$estimate,3),
p_value=round(uji$p.value,4)
))

}

r_tabel <- 0.361

hasil_validitas$Keputusan <-
ifelse(
hasil_validitas$r_hitung>r_tabel,
"Valid",
"Tidak Valid")

hasil_validitas

**Keterangan**
data$TOTAL <- rowSums(data[item]): Menghitung jumlah skor seluruh item untuk setiap responden.
hasil_validitas <- data.frame(): Digunakan untuk menyimpan seluruh hasil uji validitas.
for(i in item): Menghitung validitas setiap item dari P1 sampai P10.
total_koreksi <- data$TOTAL-data[[i]]: Skor item yang sedang diuji dikeluarkan dari skor total sehingga diperoleh corrected item-total correlation.
cor.test(...): Menghitung korelasi Pearson antara skor item dengan corrected total score.
rbind(...): Menambahkan hasil setiap item ke dalam tabel hasil validitas.
ifelse(...): Jika nilai r hitung lebih besar dari r tabel (0,361), maka item dinyatakan valid.
hasil_validitas: Menampilkan tabel hasil uji validitas.

### 5. Uji Reliabilitas
Mengetahui tingkat konsistensi instrumen penelitian.
**kode**
hasil_alpha <- alpha(data[item])

hasil_alpha

hasil_alpha$total$raw_alpha

**Keterangan**
hasil_alpha <- alpha(data[item]): Menghitung nilai Cronbach's Alpha menggunakan seluruh item pertanyaan.
hasil_alpha: Menampilkan informasi reliabilitas, termasuk nilai alpha, korelasi item, dan perubahan alpha apabila suatu item dihapus.
hasil_alpha$total$raw_alpha: Menampilkan nilai Cronbach's Alpha yang digunakan sebagai indikator reliabilitas instrumen.

### 6. Menghitung Skor Kemandirian Belajar
Menghitung skor rata-rata setiap responden.
**kode**
data$Skor <- rowMeans(data[item])

**Keterangan**
Fungsi rowMeans() menghitung rata-rata skor P1–P10 pada setiap responden sehingga diperoleh satu nilai yang mewakili tingkat kemandirian belajar. 

### 7. Statistik Deskriptif
Memberikan gambaran umum mengenai distribusi skor responden.
**kode**
summary(data$Skor)

mean(data$Skor)

sd(data$Skor)

min(data$Skor)

max(data$Skor)

**Keterangan**
summary(): menampilkan ringkasan statistik.
mean(): menghitung rata-rata skor.
sd(): menghitung simpangan baku.
min(): menentukan nilai terkecil.
max(): menentukan nilai terbesar.

### 8. Frekuensi Responden
Mengetahui karakteristik responden berdasarkan kelas, angkatan, dan jenis kelamin.
**kode**
table(data$KELAS)

table(data$ANGKATAN)

table(data$JK)

**Keterangan**
Fungsi table() menghitung jumlah responden pada setiap kategori sehingga dapat diketahui distribusi sampel.

### 9. Menentukan Bobot Sampling
Menghitung bobot sampel berdasarkan peluang pemilihan pada Two-Stage Cluster Sampling.
**kode**
M <- 6
m <- 2

NA25 <- 31
NB24 <- 28

nA25 <- 18
nB24 <- 12

P1 <- m/M

P2_A25 <- nA25/NA25

P2_B24 <- nB24/NB24

Pi_A25 <- P1*P2_A25

Pi_B24 <- P1*P2_B24

Bobot_A25 <- 1/Pi_A25

Bobot_B24 <- 1/Pi_B24

**Keterangan**
Tahap ini menghitung peluang pemilihan pada tahap pertama dan tahap kedua. Selanjutnya dihitung bobot dasar sebagai kebalikan dari peluang pemilihan.

### 10. Menghitung Bobot Akhir
Menyesuaikan bobot dasar dengan response rate penelitian.
**kode**
Target <- 30

ResponseRate <- nrow(data)/Target

data$Bobot_Akhir <-
ifelse(
data$KELAS=="A",
Bobot_A25/ResponseRate,
Bobot_B24/ResponseRate)

**Keterangan**
Bobot akhir diperoleh dengan membagi bobot dasar terhadap response rate sehingga bobot dapat digunakan pada proses estimasi.

### 11. Membentuk Desain Survei
Mendefinisikan desain survei sesuai metode Two-Stage Cluster Sampling.
**kode**
design_cluster <-
svydesign(
id=~KELAS,
weights=~Bobot_Akhir,
data=data)

**Keterangan**
Objek design_cluster menyimpan informasi mengenai cluster dan bobot yang digunakan dalam seluruh proses estimasi.

### 12. Estimasi Parameter
Mengestimasi rata-rata tingkat kemandirian belajar beserta ukuran ketelitiannya.
**Kode**
mean_kb <- svymean(~Skor,design_cluster)

SE(mean_kb)

confint(mean_kb)

RSE <- (SE(mean_kb)/coef(mean_kb))*100

svymean(~Skor,
design_cluster,
deff=TRUE)

svyby(~Skor,
~KELAS,
design_cluster,
svymean)

**Keterangan**
Tahap ini menghasilkan estimasi rata-rata, Standard Error (SE), Confidence Interval (CI), Relative Standard Error (RSE), Design Effect (DEFF), dan rata-rata skor pada setiap cluster.

### 13. Kategorisasi Tingkat Kemandirian Belajar
Mengelompokkan skor rata-rata responden ke dalam kategori tingkat kemandirian belajar.
**Kode**
data$Kategori <- cut(...)

**Keterangan**
Fungsi cut() digunakan untuk membagi skor menjadi empat kategori, yaitu:
Sangat Rendah
Rendah
Tinggi
Sangat Tinggi
berdasarkan interval skor yang telah ditentukan.

### 14. Estimasi Kategori
Mengestimasi jumlah dan proporsi responden pada setiap kategori dengan mempertimbangkan bobot sampling.
**Kode**
svytable(~Kategori,
design_cluster)

prop.table(
svytable(~Kategori,
design_cluster))

**Keterangan**
svytable() menghitung estimasi jumlah responden pada setiap kategori dengan menggunakan bobot survei.
prop.table() mengubah hasil estimasi tersebut menjadi proporsi sehingga dapat diketahui persentase responden pada masing-masing kategori tingkat kemandirian belajar.
___

## ALUR ANALISIS
Data Survei
     │
     ▼
Import Data
     │
     ▼
Persiapan Data
     │
     ▼
Uji Validitas
     │
     ▼
Uji Reliabilitas
     │
     ▼
Statistik Deskriptif
     │
     ▼
Perhitungan Bobot Sampel
     │
     ▼
Estimasi Two-Stage Cluster Sampling
     │
     ▼
Estimasi per Cluster
     │
     ▼
Kategorisasi Tingkat
     │
     ▼
Interpretasi dan Kesimpulan
___

## HASIL DAN PEMBAHASAN
### 1. Uji Validitas

| Item | r hitung | p-value | Keputusan |
|------|----------|--------|-----------|
| P1  | 0.669 | 0.0001 | Valid |
| P2  | 0.538 | 0.0022 | Valid |
| P3  | 0.678 | 0.0000 | Valid |
| P4  | 0.258 | 0.1694 | Tidak Valid |
| P5  | 0.130 | 0.4932 | Tidak Valid |
| P6  | 0.729 | 0.0000 | Valid |
| P7  | 0.553 | 0.0015 | Valid |
| P8  | 0.760 | 0.0000 | Valid |
| P9  | 0.537 | 0.0022 | Valid |
| P10 | 0.682 | 0.0000 | Valid |

**Interpretasi**
Hasil uji validitas menunjukkan bahwa dari 10 item pertanyaan, terdapat 8 item yang valid yaitu P1, P2, P3, P6, P7, P8, P9, dan P10 karena memiliki nilai r hitung lebih besar dari r tabel (0.361). Sementara itu, P4 dan P5 tidak valid karena nilai korelasinya lebih kecil dari r tabel.
Hal ini menunjukkan bahwa sebagian besar item sudah mampu mengukur konstruk kemandirian belajar dengan baik, namun terdapat dua item yang kurang sesuai sehingga perlu diperbaiki atau dihapus pada penelitian selanjutnya.

---

### 2. Reliabilitas Instrumen

- Cronbach’s Alpha = **0.853**

**Interpretasi**
Nilai Cronbach’s Alpha sebesar **0.853** menunjukkan bahwa instrumen memiliki reliabilitas yang tinggi. Artinya, seluruh item dalam kuesioner memiliki konsistensi internal yang baik dalam mengukur variabel kemandirian belajar. Dengan nilai alpha di atas 0.7, instrumen ini dapat dikatakan layak digunakan dalam analisis lebih lanjut.

---

### 3. Statistik Deskriptif Skor

- Mean = **2.78**
- SD = **0.43**
- Min = **1.60**
- Max = **3.50**

**Interpretasi**
Rata-rata skor kemandirian belajar mahasiswa adalah **2.78** dengan standar deviasi **0.43**. Nilai ini menunjukkan bahwa tingkat kemandirian belajar mahasiswa berada pada kategori **cukup tinggi**.
Nilai minimum (1.60) dan maksimum (3.50) menunjukkan adanya variasi tingkat kemandirian antar responden, meskipun secara umum tidak terlalu menyebar.

---

### 4. Estimasi Survey (Two Stage Cluster Sampling)

- Mean = **2.7618**
- Standard Error = **0.1219**
- 95% CI = **2.5228 – 3.0007**
- Relative Standard Error (RSE) = **4.41%**
- Design Effect (DEFF) = **2.80**

**Interpretasi**
Hasil estimasi menunjukkan rata-rata populasi sebesar **2.7618** dengan standard error **0.1219**. Interval kepercayaan 95% berada pada rentang **2.5228 hingga 3.0007**.
Nilai Relative Standard Error (RSE) sebesar **4.41%** menunjukkan bahwa estimasi memiliki tingkat presisi yang sangat baik (karena < 10%).
Namun, nilai Design Effect (DEFF = 2.80) menunjukkan adanya efek cluster, yaitu variasi dalam data lebih besar dibandingkan jika menggunakan simple random sampling.

---

### 5. Estimasi per Kelas

| Kelas | Mean Skor |
|------|----------|
| A25 | 2.8778 |
| B24 | 2.6333 |

**Interpretasi**
Rata-rata skor pada kelas A25 (**2.8778**) lebih tinggi dibandingkan kelas B24 (**2.6333**). Hal ini menunjukkan bahwa mahasiswa kelas A memiliki tingkat kemandirian belajar yang sedikit lebih baik.
Perbedaan ini dapat disebabkan oleh faktor lingkungan belajar, karakteristik kelas, atau perbedaan motivasi akademik antar kelompok.

---

### 6. Distribusi Kategori

| Kategori | Proporsi |
|----------|----------|
| Sangat Rendah | 3.95% |
| Rendah | 20.62% |
| Tinggi | 59.79% |
| Sangat Tinggi | 15.63% |

**Interpretasi**
Sebagian besar mahasiswa berada pada kategori **Tinggi (59.79%)**, diikuti oleh kategori Rendah (20.62%), Sangat Tinggi (15.63%), dan Sangat Rendah (3.95%).
Hal ini menunjukkan bahwa secara umum tingkat kemandirian belajar mahasiswa tergolong baik, karena mayoritas responden berada pada kategori tinggi.

---

## Kesimpulan

Berdasarkan hasil analisis menggunakan metode **Two Stage Cluster Sampling** terhadap tingkat kemandirian belajar mahasiswa, dapat disimpulkan bahwa:

1. Instrumen penelitian yang digunakan cukup baik, dengan **8 dari 10 item dinyatakan valid** dan memiliki **reliabilitas tinggi** (Cronbach’s Alpha = 0.853).

2. Tingkat kemandirian belajar mahasiswa secara umum berada pada kategori **cukup tinggi**, dengan nilai rata-rata sebesar **2.76–2.78**.

3. Estimasi menggunakan desain survei menghasilkan nilai mean **2.7618** dengan tingkat presisi yang baik, ditunjukkan oleh **RSE sebesar 4.41%**.

4. Terdapat pengaruh desain cluster dalam data, yang ditunjukkan oleh **Design Effect (DEFF) sebesar 2.80**, sehingga variansi lebih besar dibandingkan simple random sampling.

5. Berdasarkan perbandingan kelas, **kelas A memiliki tingkat kemandirian belajar lebih tinggi** dibandingkan kelas B.

6. Secara keseluruhan, mayoritas mahasiswa berada pada kategori **kemandirian belajar tinggi (59.79%)**, sehingga dapat disimpulkan bahwa tingkat kemandirian belajar mahasiswa tergolong baik.

---

## Keterbatasan Penelitian

Penelitian ini memiliki beberapa keterbatasan, antara lain:

1. **Ukuran sampel relatif kecil**, yaitu hanya 30 responden, sehingga generalisasi hasil ke populasi yang lebih luas perlu dilakukan dengan hati-hati.

2. **Jumlah cluster terbatas**, sehingga variasi antar kelompok mungkin belum sepenuhnya tergambar secara optimal.

3. **Terdapat item tidak valid (P4 dan P5)** yang seharusnya direvisi atau dihapus untuk meningkatkan kualitas instrumen.

4. Analisis hanya berfokus pada **kemandirian belajar**, tanpa mempertimbangkan variabel lain yang mungkin berpengaruh seperti motivasi, lingkungan belajar, atau dukungan keluarga.

---

## Rekomendasi

Berdasarkan hasil penelitian, beberapa rekomendasi yang dapat diberikan adalah:

1. Penelitian selanjutnya disarankan menggunakan **sampel yang lebih besar** agar hasil estimasi lebih stabil dan representatif.

2. Jumlah cluster dapat diperbanyak untuk meningkatkan kualitas desain **two stage cluster sampling**.

3. Item yang tidak valid (P4 dan P5) sebaiknya **direvisi atau diganti** agar instrumen lebih akurat dalam mengukur variabel penelitian.

4. Penelitian berikutnya dapat menambahkan **variabel lain** seperti motivasi belajar, lingkungan akademik, atau dukungan sosial untuk memperoleh analisis yang lebih komprehensif.

5. Disarankan menggunakan analisis lanjutan seperti **regresi atau model multivariat** untuk melihat faktor-faktor yang memengaruhi kemandirian belajar.

## Link kuesioner
https://docs.google.com/forms/d/e/1FAIpQLSeqfboXeDvi77hTy-E3JQhmO4F5d29FdoSkHO1UgdXIwxahxQ/viewform?usp=dialog
