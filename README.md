
# Hiking Wallet

## Deskripsi

Hiking Wallet merupakan aplikasi dompet digital (Digital Wallet) berbasis Flutter yang digunakan sebagai media pembayaran pada aplikasi **Beryl Hiking Catalog**. Aplikasi ini menangani seluruh proses transaksi keuangan mulai dari pengelolaan saldo, top up, verifikasi keamanan, hingga pencatatan riwayat transaksi.

Hiking Wallet diintegrasikan dengan **Beryl Hiking Catalog** menggunakan **Deep Link**, sehingga setiap permintaan pembayaran dari aplikasi katalog akan diproses melalui aplikasi ini.

---

# Fitur

* Login Pengguna
* Verifikasi OTP (One-Time Password)
* Google Authenticator (TOTP)
* Dashboard Wallet
* Top Up Saldo
* Verifikasi PIN
* Pemrosesan Pembayaran
* Riwayat Transaksi
* Integrasi Deep Link
* Firebase Authentication
* Cloud Firestore Database

---

# Teknologi yang Digunakan

* Flutter
* Dart
* Firebase Authentication
* Cloud Firestore
* Firebase Storage
* Deep Link
* Google Authenticator (TOTP)

---

# Struktur Proyek

```text
lib/
│
├── models/
│   ├── wallet_model.dart
│   └── transaction_model.dart
│
├── screens/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   ├── otp_login_screen.dart
│   │   └── google_authenticator_screen.dart
│   │
│   ├── home/
│   │   └── wallet_home_screen.dart
│   │
│   ├── payment/
│   │   ├── payment_request_screen.dart
│   │   ├── pin_verification_screen.dart
│   │   └── payment_success_screen.dart
│   │
│   ├── topup/
│   │   └── topup_screen.dart
│   │
│   └── transaction/
│       └── transaction_history_screen.dart
│
└── services/
    ├── wallet_service.dart
    ├── deep_link_service.dart
    └── totp_service.dart
```

---

# Alur Aplikasi

```text
Login
   │
   ▼
Dashboard Wallet
   │
   ├───────────────┐
   │               │
   ▼               ▼
Top Up        Payment Request
   │               │
   ▼               ▼
Update Saldo   Verifikasi PIN
                   │
                   ▼
          Verifikasi OTP/TOTP
                   │
                   ▼
           Saldo Dikurangi
                   │
                   ▼
        Simpan Riwayat Transaksi
```

---

# Integrasi dengan Beryl Hiking Catalog

Aplikasi Hiking Wallet menerima permintaan pembayaran dari aplikasi **Beryl Hiking Catalog** melalui Deep Link.

Alur pembayaran:

1. Pengguna melakukan checkout pada aplikasi Beryl Hiking Catalog.
2. Total pembayaran dikirim ke Hiking Wallet.
3. Hiking Wallet menampilkan halaman konfirmasi pembayaran.
4. Pengguna melakukan verifikasi PIN.
5. Pengguna melakukan verifikasi OTP atau Google Authenticator.
6. Saldo wallet dikurangi sesuai nominal transaksi.
7. Riwayat transaksi disimpan ke Cloud Firestore.
8. Status pembayaran dikirim kembali ke aplikasi Beryl Hiking Catalog.

---

# Struktur Database Firebase

## Collection wallets

```text
wallets
 └── uid
      ├── balance
      ├── updatedAt
      └── createdAt
```

---

## Collection transactions

```text
transactions
 └── transactionId
      ├── uid
      ├── amount
      ├── type
      ├── status
      ├── createdAt
      └── email
```

---

# Tampilan Aplikasi

## Login



```text
assets/screenshots/login.png
```

<img width="481" height="669" alt="image" src="https://github.com/user-attachments/assets/518ffeb1-69a9-4fdc-bf0f-29e67433ab07" />


---

## OTP Login

```text
assets/screenshots/otp_login.png
```

<img width="491" height="466" alt="image" src="https://github.com/user-attachments/assets/98baac00-6d7e-4b12-b120-8ccd239f76dd" />


---

## Google Authenticator

```text
assets/screenshots/google_authenticator.png
```

<img width="480" height="631" alt="image" src="https://github.com/user-attachments/assets/3e214f06-83b6-45a6-9b34-575839d9673c" />


---

## Dashboard Wallet

```text
assets/screenshots/wallet_home.png
```

<img width="488" height="647" alt="image" src="https://github.com/user-attachments/assets/0fb31730-db23-418c-ae5b-8e7f16583bb3" />


---

## Top Up Saldo

```text
assets/screenshots/topup.png
```

<img width="483" height="630" alt="image" src="https://github.com/user-attachments/assets/f65440d2-1805-4a12-bdfa-c1d1b6b8dd65" />


---


## Transaksi Saldo dan Hiking apps

```text
assets/screenshots/pin_verification.png
```
<img width="486" height="275" alt="image" src="https://github.com/user-attachments/assets/ebe6ac29-97de-42a2-817c-553650c85b2b" />


---

---

# Catatan 

> **pemberitahuan**
>
> Aplikasi **Hiking Wallet** tidak menyediakan fitur registrasi akun.
>
> Sebelum menggunakan aplikasi ini, pengguna **harus melakukan Sign Up terlebih dahulu pada aplikasi Beryl Hiking Catalog**.
>
> Setelah akun berhasil dibuat, pengguna dapat masuk ke aplikasi **Hiking Wallet** menggunakan **email dan password yang sama**.
>
> Kedua aplikasi menggunakan **Firebase Authentication** yang sama sehingga satu akun dapat digunakan pada kedua aplikasi.

### Alur Penggunaan

```text
Beryl Hiking Catalog
        │
        ▼
   Sign Up Akun
        │
        ▼
Firebase Authentication
        │
        ▼
 Login ke Hiking Wallet
        │
        ▼
Gunakan Seluruh Fitur Wallet
```

