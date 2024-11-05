export interface IBarang {
    nobarcode: string;
    nama: string;
    harga: number;
    stok: number;
}

interface UpdateIBarang extends IBarang {
    newnobarcode?: string;
}