import { Router } from "express";
import * as supplierController from "../../controller/v1/supplier"

export const supplier: Router = Router();

supplier.post('/tambah', supplierController.tambahSupplier);
supplier.get('/', supplierController.lihatSupplier);
supplier.delete('/hapus/:id_sup', supplierController.hapusSupplier);
supplier.put('/ubah/:id_sup', supplierController.ubahSupplier);