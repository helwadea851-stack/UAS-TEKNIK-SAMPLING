#=========================================================
# ESTIMASI TINGKAT KEMANDIRIAN BELAJAR
# TWO STAGE CLUSTER SAMPLING
#=========================================================

#=========================================================
# MEMANGGIL PACKAGE
#=========================================================

library(readxl)
library(psych)
library(survey)

#=========================================================
# IMPORT DATA
#=========================================================

data <- read_excel("D:/TEKNIK SAMPLING UAS.xlsx")

View(data)

#=========================================================
# ITEM PERTANYAAN
#=========================================================

item <- c("P1","P2","P3","P4","P5",
          "P6","P7","P8","P9","P10")

#=========================================================
# UBAH KE NUMERIC
#=========================================================

data[item] <- lapply(data[item],
                     function(x) as.numeric(as.character(x)))

#=========================================================
# UJI VALIDITAS
#=========================================================

data$TOTAL <- rowSums(data[item])

hasil_validitas <- data.frame()

for(i in item){
  
  total_koreksi <- data$TOTAL - data[[i]]
  
  uji <- cor.test(data[[i]],
                  total_koreksi,
                  method="pearson")
  
  hasil_validitas <- rbind(
    hasil_validitas,
    data.frame(
      Item=i,
      r_hitung=round(uji$estimate,3),
      p_value=round(uji$p.value,4)
    )
  )
  
}

r_tabel <- 0.361

hasil_validitas$Keputusan <-
  ifelse(hasil_validitas$r_hitung>r_tabel,
         "Valid",
         "Tidak Valid")

hasil_validitas

#=========================================================
# UJI RELIABILITAS
#=========================================================

hasil_alpha <- alpha(data[item])

hasil_alpha

hasil_alpha$total$raw_alpha

#=========================================================
# MENGHITUNG SKOR RATA-RATA
#=========================================================

data$Skor <- rowMeans(data[item])

#=========================================================
# STATISTIK DESKRIPTIF
#=========================================================

summary(data$Skor)

mean(data$Skor)

sd(data$Skor)

min(data$Skor)

max(data$Skor)

#=========================================================
# FREKUENSI RESPONDEN
#=========================================================

table(data$KELAS)

table(data$ANGKATAN)

table(data$JK)

#=========================================================
# INFORMASI SAMPLING
#=========================================================

M <- 6
m <- 2

NA25 <- 31
NB24 <- 28

nA25 <- 18
nB24 <- 12

#=========================================================
# PELUANG PEMILIHAN
#=========================================================

P1 <- m/M

P2_A25 <- nA25/NA25

P2_B24 <- nB24/NB24

Pi_A25 <- P1*P2_A25

Pi_B24 <- P1*P2_B24

#=========================================================
# BOBOT DASAR
#=========================================================

Bobot_A25 <- 1/Pi_A25

Bobot_B24 <- 1/Pi_B24

#=========================================================
# RESPONSE RATE
#=========================================================

Target <- 30

ResponseRate <- nrow(data)/Target

#=========================================================
# BOBOT AKHIR
#=========================================================

data$Bobot_Akhir <-
  ifelse(data$KELAS=="A",
         Bobot_A25/ResponseRate,
         Bobot_B24/ResponseRate)

#=========================================================
# DESAIN SURVEI
#=========================================================

design_cluster <-
  svydesign(
    id=~KELAS,
    weights=~Bobot_Akhir,
    data=data
  )

#=========================================================
# ESTIMASI RATA-RATA
#=========================================================

mean_kb <-
  svymean(~Skor,
          design_cluster)

mean_kb

#=========================================================
# STANDARD ERROR
#=========================================================

SE(mean_kb)

#=========================================================
# CONFIDENCE INTERVAL
#=========================================================

confint(mean_kb)

#=========================================================
# RELATIVE STANDARD ERROR
#=========================================================

RSE <-
  (SE(mean_kb)/coef(mean_kb))*100

RSE

cat("Nilai RSE =",
    round(RSE,2),
    "%\n")

#=========================================================
# DESIGN EFFECT
#=========================================================

svymean(~Skor,
        design_cluster,
        deff=TRUE)

#=========================================================
# ESTIMASI PER CLUSTER
#=========================================================

svyby(~Skor,
      ~KELAS,
      design_cluster,
      svymean)

#=========================================================
# KATEGORI TINGKAT
#=========================================================

data$Kategori <- cut(
  data$Skor,
  breaks=c(1,1.75,2.50,3.25,4),
  labels=c("Sangat Rendah",
           "Rendah",
           "Tinggi",
           "Sangat Tinggi"),
  include.lowest=TRUE)

design_cluster <- svydesign(
  id = ~KELAS,
  weights = ~Bobot_Akhir,
  data = data
)

svytable(~Kategori, design_cluster)

prop.table(svytable(~Kategori, design_cluster))

#=========================================================
# ESTIMASI KATEGORI
#=========================================================

svytable(~Kategori,
         design_cluster)

prop.table(
  svytable(~Kategori,
           design_cluster))