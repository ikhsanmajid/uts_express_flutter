import { PrismaClient } from "@prisma/client";
import { ISupplier, UpdateISupplier } from "../../types/kasir";

const prisma = new PrismaClient();

export async function lihatSupplier() {
    try {
        const supplier = await prisma.supplier.findMany({
            select: {
                id_sup: true,
                nama: true,
                alamat: true,
                no_hp: true
            }
        });
        return { data: supplier };
    } catch (error) {
        throw error
    }
}

export async function tambahSupplier(data: ISupplier) {
    try {
        const supplier = await prisma.supplier.create({
            data: {
                nama: data.nama,
                alamat: data.alamat,
                no_hp: data.no_hp
            }
        });
        return { data: supplier };
    } catch (error) {
        throw error
    }

}

export async function hapusSupplier(id_sup : number) {
    try {
        const supplier = await prisma.supplier.delete({
            where: {
                id_sup: id_sup
            }
        })
        return { data: supplier };
    } catch (error) {
        throw error
    }
}

export async function ubahSupplier(data: UpdateISupplier) {
    try {
        const supplier = await prisma.supplier.update({
            data: {
                nama: data.nama,
                alamat: data.alamat,
                no_hp: data.no_hp
            },
            where: {
                id_sup: data.id_sup
            }
        })

        return { data: supplier }
    } catch (error) {
        throw error
    }
}