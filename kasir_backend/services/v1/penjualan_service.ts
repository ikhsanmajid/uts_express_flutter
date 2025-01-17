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
        const penjualan: IPenjualan = await prisma.penjualan.create({
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

        return { data: penjualan }

    } catch (error) {
        throw error
    }
}