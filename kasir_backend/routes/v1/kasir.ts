import { Router } from "express";
import { supplier } from "./supplier";
import { barang } from "./barang";

export const kasir: Router = Router();

kasir.use('/supplier', supplier);
kasir.use('/barang', barang);