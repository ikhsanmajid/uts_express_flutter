import { NextFunction, Request, Response } from "express";
import * as barangService from "../../model/v1/barang_model";
import { IBarang, UpdateIBarang } from "../../types/kasir";



//ANCHOR - Tambah barang
export async function tambahBarang(req: Request, res: Response, next: NextFunction) {
    try {
        const data = req.body as IBarang;
        const barang = await barangService.tambahBarang(data);
        
        if ('data' in barang) {
            return res.status(201).json({
                status: "success",
                data: barang.data
            });
        }
    } catch (error) {
        return next(error)
    }
}

//ANCHOR - Lihat barang
export async function lihatBarang(req: Request, res: Response, next: NextFunction) {
    try {
        const barang = await barangService.lihatBarang();
                
        if ('data' in barang) {
            return res.status(200).json({
                status: "success",
                data: barang.data
            });
        }

    } catch (error) {
        return next(error)
    }


}

//ANCHOR - Hapus barang
export async function hapusBarang(req: Request, res: Response, next: NextFunction) {
    try {
        const nobarcode: string | undefined = req.params.nobarcode

        if (nobarcode == undefined){
            return next(new Error('Barcode Kosong'))
        }

        const barang = await barangService.hapusBarang(nobarcode)

        if ('data' in barang) {
            return res.status(200).json({
                status: "success",
                data: barang.data
            });
        }
    } catch (error) {
        return next(error)
    }
}

//ANCHOR - Ubah barang
export async function ubahBarang(req: Request, res: Response, next: NextFunction) {
    try {
        const nobarcode: string | undefined = req.params.nobarcode
        const newData: UpdateIBarang = req.body

        if (nobarcode == undefined){
            return next(new Error('Barcode Kosong'))
        }

        const data: UpdateIBarang = {
            ...newData,
            nobarcode
        }

        const barang = await barangService.ubahBarang(data)

        if ('data' in barang) {
            return res.status(200).json({
                status: "success",
                data: barang.data
            });
        }
    } catch (error) {
        return next(error)
    }
}