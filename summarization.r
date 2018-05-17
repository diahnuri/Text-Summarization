#Melakukan summarization / rangkuman ada dua tahap utama. 
#Pertama, kita mengumpulkan teks/ paragraf / narasi yang akan diringkas. 
#Kedua, kita lakukan rangkuman pada teks tersebut.

#Langkah Pertama
# 1. Instal package yang dibutuhkan
install.packages("xml2")
install.packages("rvest")
install.packages("lexRankr")
# 2. Load package yang dibutuhkan
library(xml2)
library(rvest)
library(lexRankr)
# 3. Mengambil teks dari URL, definisikan url nya dulu
mosanto_url = "https://www.theguardian.com/environment/2017/sep/28/monsanto-banned-from-european-parliament"
# 4. Membacakan halaman html
page = xml2::read_html(mosanto_url)
# 5. Membaca text dari halaman html menggunakan selector
teks_halaman = rvest::html_text(rvest::html_nodes(page, ".js-article__body p"))
print(teks_halaman)
# Langkah Kedua
# Membuat rangkuman teks. Kita membuat rangkuman teks dengan menerapkan algoritm LexRank.
# Algoritma LexRank sebenarnya diperuntukkan untuk Google's Page Rank.
# Kalau Google's Page Rank inputnya adalah halaman html sedangkan
# rangkuman yg akan diterapkan, inputnya teks.
# Tujuan dari LexRank adalah menemukan kata yang paling merepresentasikan
# sekumpulan teks. Fungsi lexRank() dari package lexRankr mengimplementasikan LexRank yang mengambil teks_halaman sebagai input rangkuman.


#mengerjakana lexRank untuk 3 kalimat teratas
top_3 = lexRankr::lexRank(teks_halaman,
                          # 1 artikel: mengulang id dokumen yang sama
                          docId = rep(1, length(teks_halaman)),
                          # mengembalikan 3 kalimat
                          n = 3, continuous = TRUE)
#menampilkan kalimat berdasarkan rankingnya
print(top_3["sentence"])
#mengurutkan kalimat 3 ranking teratas dengan urutan dalam dokumen
order_of_appearance = order(as.integer(gsub("_","",top_3$sentenceId)))
#sudah diurutkan, ambil kalimatnya saja dalam kondisi yang terurut
ordered_top_3 = top_3[order_of_appearance, "sentence"]
print(ordered_top_3)
