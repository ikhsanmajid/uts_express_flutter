/*
  Warnings:

  - A unique constraint covering the columns `[nonota]` on the table `penjualan` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `penjualan_nonota_key` ON `penjualan`(`nonota`);
