import { Router } from "express";
import * as barangController from "../../controller/v1/barang"
import * as supplierController from "../../controller/v1/supplier"

export const kasir: Router = Router();

//Barang Route
kasir.post('/barang/tambah', barangController.tambahBarang);
kasir.get('/barang', barangController.lihatBarang);
kasir.delete('/barang/hapus/:nobarcode', barangController.hapusBarang);
kasir.put('/barang/ubah/:nobarcode', barangController.ubahBarang);

//Supplier Route
kasir.post('/supplier/tambah', supplierController.tambahSupplier);
kasir.get('/supplier', supplierController.lihatSupplier);
kasir.delete('/supplier/hapus/:id_sup', supplierController.hapusSupplier);
kasir.put('/supplier/ubah/:id_sup', supplierController.ubahSupplier);


