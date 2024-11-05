import { PrismaClient } from "@prisma/client";
import { IBarang, UpdateIBarang } from "../../types/kasir";

const prisma = new PrismaClient();

export async function lihatBarang() {
    try {
        const barang = await prisma.barang.findMany({
            select: {
                nobarcode: true,
                nama: true,
                harga: true,
                stok: true
            }
        });
        return { data: barang };
    } catch (error) {
        throw error
    }
}

export async function tambahBarang(data: IBarang) {
    try {
        const barang = await prisma.barang.create({
            data: {
                nobarcode: data.nobarcode,
                nama: data.nama,
                harga: data.harga,
                stok: data.stok
            }
        });
        return { data: barang };
    } catch (error) {
        throw error
    }

}

export async function hapusBarang(nobarcode: string){
    try {
        const barang = await prisma.barang.delete({
            where: {
                nobarcode: nobarcode
            }
        })
        return { data: barang };
    } catch (error) {
        throw error
    }
}

export async function ubahBarang(data: UpdateIBarang) {
    try {
        const barang = await prisma.barang.update({
            data: {
                nobarcode: data.newnobarcode,
                nama: data.nama,
                harga: data.harga,
                stok: data.stok
            },
            where: {
                nobarcode: data.nobarcode
            }
        })

        return { data: barang }
    } catch (error) {
        throw error
    }
}