CREATE DATABASE HorizonAir;
USE HorizonAir;

-- Tabel BANDARA
CREATE TABLE Bandara (
    ID_Bandara INT,
    Nama VARCHAR(100),
    Kota VARCHAR(100),
    Negara VARCHAR(100),
    Kode_IATA VARCHAR(10) UNIQUE
);

-- Tabel BAGASI
CREATE TABLE Bagasi (
    ID_Bagasi INT PRIMARY KEY,
    Berat INT,
    Ukuran CHAR(1),
    Warna VARCHAR(50),
    Jenis VARCHAR(20)
);

-- Tabel MASKAPAI
CREATE TABLE Maskapai (
    ID_Maskapai VARCHAR(10) PRIMARY KEY,
    Nama VARCHAR(100),
    Negara_Asal VARCHAR(100)
);

-- Tabel PESAWAT
CREATE TABLE Pesawat (
    ID_Pesawat VARCHAR(10) PRIMARY KEY,
    Model VARCHAR(50),
    Kapasitas INT,
    Tahun_Produksi INT,
    Status_Pesawat VARCHAR(50),
    ID_Maskapai VARCHAR(10),
    FOREIGN KEY (ID_Maskapai) REFERENCES Maskapai(ID_Maskapai)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tabel PENERBANGAN
CREATE TABLE Penerbangan (
    ID_Penerbangan VARCHAR(10) PRIMARY KEY,
    Waktu_Keberangkatan DATETIME,
    Waktu_Sampai DATETIME,
    Status_Penerbangan VARCHAR(50),
    ID_Pesawat VARCHAR(10),
    FOREIGN KEY (ID_Pesawat) REFERENCES Pesawat(ID_Pesawat)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tabel PENUMPANG
CREATE TABLE Penumpang (
    NIK VARCHAR(20) PRIMARY KEY,
    Nama VARCHAR(100),
    Tanggal_Lahir DATE,
    Alamat VARCHAR(200),
    No_Telepon VARCHAR(20),
    Jenis_Kelamin CHAR(1),
    Kewarganegaraan VARCHAR(50),
    ID_Bagasi INT,
    FOREIGN KEY (ID_Bagasi) REFERENCES Bagasi(ID_Bagasi)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tabel BANDARA_PENERBANGAN (Many to Many)
CREATE TABLE Bandara_Penerbangan (
    Bandara_ID INT,
    Penerbangan_ID VARCHAR(10),
    PRIMARY KEY (Bandara_ID, Penerbangan_ID),
    FOREIGN KEY (Bandara_ID) REFERENCES Bandara(ID_Bandara)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (Penerbangan_ID) REFERENCES Penerbangan(ID_Penerbangan)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tabel TIKET
CREATE TABLE Tiket (
    ID_Tiket VARCHAR(10) PRIMARY KEY,
    Nomor_Kursi VARCHAR(10),
    Harga INT,
    Waktu_Pembelian DATETIME,
    Kelas_Penerbangan VARCHAR(50),
    NIK_Penumpang VARCHAR(20),
    ID_Penerbangan VARCHAR(10),
    FOREIGN KEY (NIK_Penumpang) REFERENCES Penumpang(NIK)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ID_Penerbangan) REFERENCES Penerbangan(ID_Penerbangan)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO Bandara VALUES
(1, 'Soekarno-Hatta', 'Jakarta', 'Indonesia', 'CGK'),
(2, 'Ngurah Rai', 'Denpasar', 'Indonesia', 'DPS'),
(3, 'Changi', 'Singapore', 'Singapore', 'SIN'),
(4, 'Haneda', 'Tokyo', 'Japan', 'HND');

INSERT INTO Bagasi VALUES
(1, 20, 'M', 'Hitam', 'Koper'),
(2, 15, 'S', 'Merah', 'Ransel'),
(3, 25, 'L', 'Biru', 'Koper'),
(4, 10, 'S', 'Hijau', 'Ransel');

INSERT INTO Maskapai VALUES
('GA123', 'Garuda Indonesia', 'Indonesia'),
('SQ456', 'Singapore Airlines', 'Singapore'),
('JL789', 'Japan Airlines', 'Japan'),
('QZ987', 'AirAsia', 'Malaysia');

INSERT INTO Pesawat VALUES
('PKABC1', 'Boeing 737', 180, 2018, 'Aktif', 'GA123'),
('PKDEF2', 'Airbus A320', 150, 2020, 'Aktif', 'SQ456'),
('PKGHI3', 'Boeing', 250, 2019, 'Dalam Perawatan', 'JL789'),
('PKJKL4', 'Airbus A330', 280, 2021, 'Aktif', 'QZ987');

INSERT INTO Penerbangan VALUES
('FL0001', '2024-12-15 10:00:00', '2024-12-15 12:30:00', 'Jadwal', 'PKABC1'),
('FL0002', '2024-12-16 08:00:00', '2024-12-16 10:45:00', 'Jadwal', 'PKDEF2'),
('FL0003', '2024-12-17 14:00:00', '2024-12-17 16:30:00', 'Ditunda', 'PKGHI3'),
('FL0004', '2024-12-18 18:00:00', '2024-12-18 20:30:00', 'Jadwal', 'PKJKL4');

INSERT INTO Penumpang VALUES
('3201123456789012', 'Budi Santoso', '1990-04-15', 'Jl. Merdeka No.1', '081234567890', 'L', 'Indonesia', 1),
('3302134567890123', 'Siti Aminah', '1985-08-20', 'Jl. Kebangsaan No.2', '081298765432', 'P', 'Indonesia', 2),
('3403145678901234', 'John Tanaka', '1992-12-05', 'Shibuya, Tokyo', '080123456789', 'L', 'Japan', 3),
('3504156789012345', 'Li Wei', '1995-03-10', 'Orchard Rd, Singapore', '0658123456789', 'L', 'Singapore', 4);

INSERT INTO Bandara_Penerbangan VALUES
(1, 'FL0001'),
(2, 'FL0002'),
(3, 'FL0003'),
(4, 'FL0004');

INSERT INTO Tiket VALUES
('TIK001', '12A', 1200000, '2024-11-01 08:00:00', 'Ekonomi', '3201123456789012', 'FL0001'),
('TIK002', '14B', 1500000, '2024-11-02 09:30:00', 'Bisnis', '3302134567890123', 'FL0002'),
('TIK003', '16C', 2000000, '2024-11-03 10:15:00', 'Ekonomi', '3403145678901234', 'FL0003'),
('TIK004', '18D', 1000000, '2024-11-04 11:45:00', 'Ekonomi', '3504156789012345', 'FL0004');

ALTER TABLE Penumpang ADD email VARCHAR(100);

ALTER TABLE Bagasi MODIFY Jenis VARCHAR(50);

ALTER TABLE Bandara ADD PRIMARY KEY (Kode_IATA);

ALTER TABLE Penumpang DROP COLUMN email;


