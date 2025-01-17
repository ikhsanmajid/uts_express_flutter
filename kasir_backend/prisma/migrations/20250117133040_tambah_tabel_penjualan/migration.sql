-- CreateTable
CREATE TABLE `penjualan` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nonota` INTEGER NOT NULL,
    `nobarcode` VARCHAR(191) NOT NULL,
    `jumlah` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `penjualan` ADD CONSTRAINT `penjualan_nobarcode_fkey` FOREIGN KEY (`nobarcode`) REFERENCES `barang`(`nobarcode`) ON DELETE RESTRICT ON UPDATE CASCADE;
