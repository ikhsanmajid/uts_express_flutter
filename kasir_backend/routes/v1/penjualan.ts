import { Router } from "express";
import * as penjualanController from "../../controller/v1/penjualan"

export const penjualan: Router = Router();

penjualan.post('/tambah', penjualanController.tambahPenjualan);
penjualan.get('/', penjualanController.lihatPenjualan);