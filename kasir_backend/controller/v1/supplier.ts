import { NextFunction, Request, Response } from "express";
import * as supplierService from "../../services/v1/supplier_service";
import { ISupplier, UpdateISupplier } from "../../types/kasir";



//ANCHOR - Tambah supplier
export async function tambahSupplier(req: Request, res: Response, next: NextFunction) {
    try {
        const { nama, alamat, no_hp } = req.body;

        const data : ISupplier = {
            nama: String(nama) ?? "",
            alamat: String(alamat) ?? "",
            no_hp: String(no_hp) ?? ""
        }
        
        const supplier = await supplierService.tambahSupplier(data);
        
        if ('data' in supplier) {
            return res.status(201).json({
                status: "success",
                data: supplier.data
            });
        }
    } catch (error) {
        return next(error)
    }
}

//ANCHOR - Lihat supplier
export async function lihatSupplier(req: Request, res: Response, next: NextFunction) {
    try {
        const supplier = await supplierService.lihatSupplier();
                
        if ('data' in supplier) {
            return res.status(200).json({
                status: "success",
                data: supplier.data
            });
        }

    } catch (error) {
        return next(error)
    }


}

//ANCHOR - Hapus supplier
export async function hapusSupplier(req: Request, res: Response, next: NextFunction) {
    try {
        const id_sup: number | undefined = parseInt(req.params.id_sup)

        if (isNaN(id_sup)) {
            return next(new Error('Supplier ID is missing or invalid'));
        }

        const supplier = await supplierService.hapusSupplier(id_sup)

        if ('data' in supplier) {
            return res.status(200).json({
                status: "success",
                data: supplier.data
            });
        }
    } catch (error) {
        return next(error)
    }
}

//ANCHOR - Ubah supplier
export async function ubahSupplier(req: Request, res: Response, next: NextFunction) {
    try {
        const id_sup = parseInt(req.params.id_sup);
        const newData: UpdateISupplier = req.body

        if (isNaN(id_sup)) {
            return next(new Error('Supplier ID is missing or invalid'));
        }

        const data: UpdateISupplier = {
            ...newData,
            id_sup
        }

        const supplier = await supplierService.ubahSupplier(data)

        if ('data' in supplier) {
            return res.status(200).json({
                status: "success",
                data: supplier.data
            });
        }
    } catch (error) {
        return next(error)
    }
}