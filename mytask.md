A. Research & Discovery
Task 1 – User Research & Persona
Deskripsi:
Identifikasi dan dokumentasikan 3 persona utama:
Warga/Komunitas: pengguna mobile yang butuh info risiko sederhana dan pelaporan cepat.
Pelaku Usaha Kecil/UMKM: butuh tahu risiko area usaha dan peringatan dini.
Admin Pemda/BPBD: pengguna dashboard web yang butuh peta hotspot dan data analitik cepat.
Untuk setiap persona: nama, profil singkat, tujuan utama, pain point, dan skenario penggunaan.
Deliverables: Dokumen 3 persona lengkap dengan skenario penggunaan.
Task 2 – Competitive Analysis
Deskripsi:
Analisis 3–5 aplikasi/platform sejenis:
inaRISK (BNPB),
SIAGA BENCANA / aplikasi lokal BPBD,
BMKG app,
aplikasi peta risiko internasional (misal: Global Disaster Alert and Coordination System).
Catat: kelebihan, kekurangan, pola UI yang umum dipakai, dan gap yang bisa diisi SpataGuard.
Deliverables: Tabel comparative analysis + insight utama untuk desain SpataGuard.
Task 3 – User Journey Mapping
Deskripsi:
Buat user journey map untuk setiap persona:
Warga: dari buka app → cek risiko lokasi → lihat penjelasan faktor → kirim laporan.
UMKM: dari buka app → cek risiko area usaha → terima early warning.
Admin Pemda: dari buka dashboard → lihat hotspot → overlay RTRW → cek audit log.
Identifikasi touchpoint, emosi user di setiap tahap, dan peluang perbaikan (opportunity).
Deliverables: User journey map per persona (bisa dibuat di FigJam/Miro).
B. Information Architecture & Wireframe
Task 4 – Information Architecture (IA)
Deskripsi:
Buat sitemap/struktur navigasi untuk:
Mobile app: halaman utama (peta), detail risiko lokasi, form laporan, riwayat laporan, notifikasi, profil.
Web dashboard: overview, peta risiko, laporan warga, early warning, audit log, versioning layer, manajemen user.
Pastikan hierarki informasi jelas dan tidak lebih dari 3 klik untuk fitur utama.
Deliverables: Sitemap mobile + sitemap web dalam format diagram.
Task 5 – Low-fidelity Wireframe (Mobile)
Deskripsi:
Buat wireframe lo-fi untuk semua screen mobile utama:
Splash screen / onboarding,
Halaman peta utama (Risk Map Explorer),
Panel "Lokasi Saya" + Risk Score,
Form laporan warga,
Halaman detail laporan,
Halaman notifikasi / early warning,
Profil & pengaturan akun.
Fokus pada layout, hierarki konten, dan alur antar screen (bukan visual detail).
Deliverables: Wireframe lo-fi mobile (semua screen utama) di Figma.
Task 6 – Low-fidelity Wireframe (Web Dashboard)
Deskripsi:
Buat wireframe lo-fi untuk semua halaman web utama:
Halaman login,
Overview/dashboard utama (KPI + grafik + tabel),
Halaman peta (heatmap + toggle layer),
Halaman laporan warga,
Halaman early warning,
Halaman audit log,
Halaman versioning layer,
Halaman manajemen user.
Fokus pada layout grid, hierarki informasi, dan navigasi sidebar.
Deliverables: Wireframe lo-fi web (semua halaman utama) di Figma.
C. Design System
Task 7 – Design System & Token
Deskripsi:
Tentukan dan dokumentasikan design system SpataGuard:
Warna: palette utama (sesuai tema risiko: hijau/kuning/oranye/merah untuk level risiko + warna brand SpataGuard), light & dark mode.
Tipografi: pilih font display + font body, tentukan skala ukuran (xs → hero), aturan penggunaan.
Spacing: sistem 4px, dokumentasi token spacing.
Border radius, shadow: token per komponen.
Ikonografi: pilih icon set (Lucide/Phosphor) + aturan penggunaan.
Buat design token di Figma (Variables) agar semua komponen mudah dikonsistenkan.
Deliverables: Design system Figma file + dokumentasi token.
Task 8 – Komponen UI Library (Mobile)
Deskripsi:
Buat komponen mobile di Figma:
Bottom navigation bar,
Map marker (per level risiko: Aman/Waspada/Siaga/Bahaya),
Risk Score card (panel info lokasi),
Risk factor badge/chip,
Form laporan (input, photo upload, location picker),
Notification/alert card,
Empty state,
Loading/skeleton.
Semua komponen harus punya state: default, hover, active, disabled, error.
Deliverables: Mobile component library di Figma.
Task 9 – Komponen UI Library (Web Dashboard)
Deskripsi:
Buat komponen web di Figma:
Sidebar navigasi (collapsed & expanded),
Topbar,
KPI card,
Tabel data (dengan filter, sorting, pagination),
Map legend & layer toggle,
Area popup (info area di peta),
Alert/early warning card,
Audit log row,
Modal konfirmasi,
Badge status risiko,
Empty state & skeleton loader.
Semua komponen punya state lengkap dan siap di-handoff ke web dev.
Deliverables: Web component library di Figma.
D. High-fidelity Design & Prototyping
Task 10 – High-fidelity Design (Mobile)
Deskripsi:
Buat desain hi-fi untuk semua screen mobile utama menggunakan komponen dari Task 8:
Splash + onboarding (2–3 screen),
Risk Map Explorer (tampilan peta dengan zona risiko berwarna),
Panel "Lokasi Saya" + Risk Score + penjelasan faktor,
Form laporan warga,
Halaman notifikasi / early warning,
Profil & pengaturan.
Desain dalam 2 mode: light dan dark.
Deliverables: Hi-fi mobile design (semua screen) di Figma.
Task 11 – High-fidelity Design (Web Dashboard)
Deskripsi:
Buat desain hi-fi untuk semua halaman web dashboard menggunakan komponen dari Task 9:
Halaman login,
Overview dashboard,
Peta heatmap + overlay layer,
Halaman laporan warga,
Halaman early warning,
Halaman audit log,
Halaman versioning layer,
Halaman manajemen user.
Desain dalam 2 mode: light dan dark.
Deliverables: Hi-fi web design (semua halaman) di Figma.
Task 12 – Interactive Prototype
Deskripsi:
Buat prototype interaktif di Figma untuk 2 alur utama:
Alur Mobile: buka peta → tap lokasi → lihat Risk Score → kirim laporan warga.
Alur Web: login → lihat overview → buka peta → toggle overlay RTRW → klik area terflag → lihat detail.
Prototype harus bisa dipakai untuk demo hackathon tanpa perlu app yang sudah jalan penuh.
Deliverables: Prototype interaktif yang siap demo.
E. UX Writing & Accessibility
Task 13 – UX Writing
Deskripsi:
Tulis semua teks UI yang konsisten dan mudah dipahami warga awam:
Label tombol, navigasi, dan form.
Penjelasan level risiko (Aman, Waspada, Siaga, Bahaya) dalam 1–2 kalimat sederhana.
Pesan error, empty state, dan konfirmasi aksi.
Teks onboarding yang menjelaskan cara pakai app dalam 3 langkah.
Hindari jargon teknis di sisi mobile (warga), boleh lebih teknis di sisi web (pemda/BPBD).
Deliverables: UX writing glossary + semua teks UI terdokumentasi.
Task 14 – Accessibility Check
Deskripsi:
Pastikan desain memenuhi standar aksesibilitas dasar:
Kontras warna teks vs. background minimal 4.5:1 (WCAG AA).
Ukuran teks minimum 12px, body 16px.
Touch target mobile minimum 44×44px.
Semua elemen interaktif punya label yang jelas.
Urutan tab/fokus yang logis untuk web dashboard.
Dokumentasikan hasil cek dan perbaikan yang dilakukan.
Deliverables: Laporan accessibility + revisi desain jika ada yang gagal.
F. Handoff & Kolaborasi Dev
Task 15 – Design Handoff ke Mobile Dev & Web Dev
Deskripsi:
Pastikan semua aset di Figma siap di-handoff:
Semua komponen sudah ter-organize rapi di Figma (halaman per platform).
Export aset ikon dan ilustrasi dalam format SVG/PNG.
Semua design token (warna, spacing, tipografi) sudah terdokumentasi jelas dan konsisten.
Tambahkan anotasi pada desain yang membutuhkan penjelasan behavior (animasi, state, interaksi khusus).
Lakukan sesi handoff singkat (30–60 menit) bersama mobile dev dan web dev untuk walkthrough desain.
Deliverables: Figma file siap handoff + sesi walkthrough dengan dev.
Task 16 – Iterasi Desain Berdasarkan Feedback Dev
Deskripsi:
Setelah dev mulai implementasi, UI/UX siap menerima feedback jika ada komponen yang sulit diimplementasikan atau perlu penyesuaian.
Lakukan revisi desain yang diperlukan (misal: komponen terlalu kompleks, layout perlu disederhanakan untuk performance).
Pastikan revisi didokumentasikan di Figma dengan versioning yang jelas.
Deliverables: Desain revisi + catatan perubahan di Figma.