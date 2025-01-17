import { NextFunction, Request, Response } from "express";
import * as penjualanService from "../../services/v1/penjualan_service";
import { IPenjualan } from "../../types/kasir";
import { PrismaClientKnownRequestError, PrismaClientValidationError } from "@prisma/client/runtime/library";

//ANCHOR - Lihat Penjualan
export async function lihatPenjualan(req: Request, res: Response, next: NextFunction) {
    try {        
        const penjualan = await penjualanService.lihatPenjualan()
        
        if ('data' in penjualan) {
            return res.json({
                status: "success",
                data: penjualan.data
            });
        }
    } catch (error) {
        return next(error)
    }
}

//ANCHOR - Lihat Penjualan
export async function tambahPenjualan(req: Request, res: Response, next: NextFunction) {
    try {        
        const { nonota, nobarcode, jumlah } = req.body as IPenjualan

        const data: IPenjualan = {
            nonota: Number(nonota) ?? 0,
            nobarcode: String(nobarcode) ?? "",
            jumlah: Number(jumlah) ?? 0
        }

        const penjualan = await penjualanService.tambahPenjualan(data)
        
        if ('data' in penjualan) {
            return res.status(201).json({
                status: "success",
                data: penjualan.data
            });
        }
    } catch (error) {
        return next(error)
    }
}