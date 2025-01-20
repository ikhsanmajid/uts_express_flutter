-- DropForeignKey
ALTER TABLE `penjualan` DROP FOREIGN KEY `penjualan_nobarcode_fkey`;

-- AddForeignKey
ALTER TABLE `penjualan` ADD CONSTRAINT `penjualan_nobarcode_fkey` FOREIGN KEY (`nobarcode`) REFERENCES `barang`(`nobarcode`) ON DELETE CASCADE ON UPDATE CASCADE;
