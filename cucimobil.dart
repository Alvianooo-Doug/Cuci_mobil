import 'dart:io';

// Deklarasi variabel global agar bisa diakses oleh semua fungsi
List<String> waitingList = [];
Map<String, String?> posA = {'plat': null};
Map<String, String?> posB = {'plat': null};
Map<String, String?> posC = {'plat': null};

void main() {
  var jalan = true;

  while (jalan) {
    tampilMenu();
    stdout.write('Pilih menu (1-5): ');
    String? pilihan = stdin.readLineSync();

    switch (pilihan) {
      case '1':
        tambahList();
        break;
      case '2':
        showList();
        break;
      case '3':
        showPos();
        break;
      case '4':
        finishPos();
        break;
      case '5':
        print('\nTerima kasih telah menggunakan sistem cuci mobil!');
        jalan = false;
        break;
      default:
        print('\nPilihan tidak valid! Silakan pilih menu 1-5.');
    }
  }
}

void tampilMenu() {
  print('==========================');
  print('1. Tambah Antrean Mobil');
  print('2. Lihat Waiting List');
  print('3. Lihat Pos Pencucian');
  print('4. Selesaikan Pos');
  print('5. Keluar');
  print('==========================');
}

void tambahList() {
  stdout.write('\nMasukkan nomor plat mobil: ');
  String? plat = stdin.readLineSync();

  if (plat == null || plat.trim().isEmpty) {
    print('Nomor plat tidak boleh kosong!');
    return;
  }

  // Cek pos kosong secara berurutan
  if (posA['plat'] == null) {
    posA['plat'] = plat;
    print('Mobil $plat masuk ke Pos A.');
  } else if (posB['plat'] == null) {
    posB['plat'] = plat;
    print('Mobil $plat masuk ke Pos B.');
  } else if (posC['plat'] == null) {
    posC['plat'] = plat;
    print('Mobil $plat masuk ke Pos C.');
  } else {
    // Jika semua pos penuh, masuk ke waiting list
    waitingList.add(plat);
    print('Semua pos penuh. Mobil $plat dimasukkan ke Waiting List.');
  }
}

void showList() {
  print('\n--- WAITING LIST ---');
  if (waitingList.isEmpty) {
    print('Waiting list kosong.');
    return;
  }

  // Demonstrasi perulangan for, for-in, dan forEach
  print('--- Menggunakan For Loop Biasa ---');
  for (int i = 0; i < waitingList.length; i++) {
    print('${i + 1}. Plat: ${waitingList[i]}');
  }

  print('\n--- Menggunakan For-In ---');
  int no = 1;
  for (var plat in waitingList) {
    print('${no++}. Plat: $plat');
  }

  print('\n--- Menggunakan ForEach ---');
  waitingList.forEach((plat) {
    print('Plat: $plat');
  });
}

void showPos() {
  print('\n--- STATUS POS PENCUCIAN ---');
  print('Pos A : ${posA['plat'] ?? 'Kosong'}');
  print('Pos B : ${posB['plat'] ?? 'Kosong'}');
  print('Pos C : ${posC['plat'] ?? 'Kosong'}');
}

void finishPos() {
  showPos();
  stdout.write('\nSelesaikan pos mana? (A/B/C): ');
  String? inputPos = stdin.readLineSync()?.toUpperCase();

  if (inputPos == 'A') {
    prosesSelesaiPos(posA, 'A');
  } else if (inputPos == 'B') {
    prosesSelesaiPos(posB, 'B');
  } else if (inputPos == 'C') {
    prosesSelesaiPos(posC, 'C');
  } else {
    print('Pos tidak valid! Pilih A, B, atau C.');
  }
}

void prosesSelesaiPos(Map<String, String?> pos, String namaPos) {
  if (pos['plat'] == null) {
    print('Pos $namaPos sedang kosong!');
    return;
  }

  print('Pencucian mobil ${pos['plat']} di Pos $namaPos selesai.');
  pos['plat'] = null; // Pos dikosongkan terlebih dahulu

  // Jika ada mobil di waiting list, masukkan mobil paling depan (index 0)
  if (waitingList.isNotEmpty) {
    String mobilBerikutnya = waitingList.removeAt(0);
    pos['plat'] = mobilBerikutnya;
    print('Mobil $mobilBerikutnya dari waiting list otomatis masuk ke Pos $namaPos.');
  }
}