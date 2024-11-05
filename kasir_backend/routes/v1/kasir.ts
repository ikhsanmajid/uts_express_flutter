import { Router } from "express";
import * as barangController from "../../controller/v1/barang"

export const barang: Router = Router();

barang.post('/tambah', barangController.tambahBarang);
barang.get('/', barangController.lihatBarang);
barang.delete('/hapus/:nobarcode', barangController.hapusBarang);
barang.put('/ubah/:nobarcode', barangController.ubahBarang);


