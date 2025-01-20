import { penjualan, PrismaClient } from "@prisma/client";
import { IPenjualan } from "../../types/kasir";

const prisma = new PrismaClient();

export async function lihatPenjualan(): Promise<{ data: IPenjualan[] }> {
    try {
        const penjualan: IPenjualan[] = await prisma.penjualan.findMany({
            select: {
                id: true,
                nonota: true,
                nobarcode: true,
                noBarcodeFK: {
                    select: {
                        nama: true
                    }
                },
                jumlah: true
            }
        })

        return { data: penjualan }

    } catch (error) {
        throw error
    }
}

export async function tambahPenjualan( data: IPenjualan ): Promise<{ data: IPenjualan }> {
    try {

        const transaction: IPenjualan = await prisma.$transaction(async (tx) => {
            const checkProduk = await tx.barang.findFirst({
                select: {
                    stok: true
                },
                where: {
                    nobarcode: data.nobarcode
                }
            })

            if(checkProduk){
                if (checkProduk.stok - Number(data.jumlah) < 0){
                    throw new Error("Stok Kurang")
                }

                const subtractProduk = await tx.barang.update({
                    data: {
                        stok: Number(checkProduk.stok)-Number(data.jumlah)
                    },
                    where: {
                        nobarcode: data.nobarcode
                    }
                })

                const addPenjualan = await tx.penjualan.create({
                    data: {
                        nonota: data.nonota,
                        nobarcode: data.nobarcode,
                        jumlah: data.jumlah
                    },
                    select: {
                        id: true,
                        nonota: true,
                        nobarcode: true,
                        jumlah: true
                    }
                })

                return addPenjualan
            }

            throw new Error("Produk Tidak Ada")
        })


        return { data: transaction }

    } catch (error) {
        throw error
    }
}