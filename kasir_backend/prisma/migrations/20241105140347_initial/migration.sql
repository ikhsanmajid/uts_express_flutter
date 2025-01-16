-- CreateTable
CREATE TABLE `barang` (
    `nobarcode` VARCHAR(191) NOT NULL,
    `nama` VARCHAR(191) NOT NULL,
    `harga` INTEGER NOT NULL,
    `stok` INTEGER NOT NULL,

    UNIQUE INDEX `barang_nobarcode_key`(`nobarcode`),
    PRIMARY KEY (`nobarcode`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
