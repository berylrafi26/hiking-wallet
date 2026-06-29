

**Beryl Hiking Catalog** adalah aplikasi mobile berbasis Flutter yang berfungsi sebagai **katalog sekaligus e-commerce perlengkapan mendaki**. Pengguna dapat melihat produk, menambahkan produk ke keranjang, melakukan checkout, serta melakukan pembayaran secara aman melalui aplikasi **Hiking Wallet** yang terintegrasi menggunakan **Deep Link**.

---

# Deskripsi

Aplikasi ini dikembangkan sebagai bagian dari sistem pembayaran digital yang terdiri dari dua aplikasi, yaitu:

* **Beryl Hiking Catalog** → Aplikasi e-commerce perlengkapan hiking.
* **Hiking Wallet** → Aplikasi dompet digital untuk memproses pembayaran.

Pada saat pengguna melakukan checkout, aplikasi akan mengirimkan permintaan pembayaran ke Hiking Wallet untuk proses verifikasi PIN, OTP, serta pemotongan saldo.

---

# Fitur

* Login & Registrasi Pengguna
* Menampilkan Katalog Produk Hiking
* Detail Produk
* Keranjang Belanja (Shopping Cart)
* Checkout Produk
* Integrasi Pembayaran menggunakan Deep Link
* Verifikasi PIN & OTP melalui Hiking Wallet
* Riwayat Pembelian
* Firebase Authentication
* Cloud Firestore Database

---

# Teknologi yang Digunakan

* Flutter
* Dart
* Firebase Authentication
* Cloud Firestore
* Provider (State Management)
* Deep Link potong saldo real time

---

# Struktur Proyek

```text
lib/
│
├── models/
│   └── cart_item.dart
│
├── providers/
│   └── cart_provider.dart
│
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── register_screen.dart
│   │
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── product_card.dart
│   │
│   ├── cart/
│   │   └── cart_screen.dart
│   │
│   ├── checkout/
│   │   └── checkout_screen.dart
│   │
│   ├── payment/
│   │   ├── pin_verification_screen.dart
│   │   └── otp_verification_screen.dart
│   │
│   └── transactions/
│       └── transaction_history_screen.dart
│
└── services/
    ├── api_services.dart
    └── auth_services.dart
```



# Tampilan Aplikasi

## Halaman Login & Verifikasi Email

> Tambahkan screenshot di bawah ini.


---

<img width="488" height="563" alt="image" src="https://github.com/user-attachments/assets/5248ee61-09f1-4ae0-88a7-0fb287c84768" />
<img width="1039" height="500" alt="image" src="https://github.com/user-attachments/assets/0112a535-1bb2-42f7-a10b-9eb8a61088ac" />

---

## Halaman Register
---
<img width="480" height="598" alt="Screenshot 2026-06-29 161647" src="https://github.com/user-attachments/assets/8a60d2e0-a14d-4500-8766-98d27db7abf8" />




---

## Halaman Home
---
<img width="490" height="637" alt="image" src="https://github.com/user-attachments/assets/b49cf6ee-badc-4ab4-a282-16c495102186" />


---

## Daftar Produk
---

<img width="487" height="640" alt="image" src="https://github.com/user-attachments/assets/b2301643-14c3-4509-9ec0-6a4a081ce8f1" />



---

## Keranjang Belanja


---
<img width="477" height="635" alt="image" src="https://github.com/user-attachments/assets/8a8e1726-8996-4a30-86bc-5b9022a657ec" />


---

## Checkout
---
<img width="489" height="639" alt="image" src="https://github.com/user-attachments/assets/62e71a6e-c148-4357-a2c2-fb9b0fcca4e6" />


---

## Verifikasi Pin
---

<img width="480" height="266" alt="image" src="https://github.com/user-attachments/assets/620746c0-755e-4500-a260-27a5da229917" />


---

## Riwayat Pembelian

---

<img width="478" height="181" alt="image" src="https://github.com/user-attachments/assets/b915ee6a-e1fa-4c0e-b116-b09134fb3070" />


---

# 🗂 Struktur Database Firebase

## Collection Users

```text
users
 └── userId
      ├── nama
      ├── email
      ├── nomorTelepon
      └── createdAt
```

---

## Collection Transactions

```text
transactions
 └── transactionId
      ├── userId
      ├── amount
      ├── type
      ├── status
      ├── address
      └── createdAt
```


