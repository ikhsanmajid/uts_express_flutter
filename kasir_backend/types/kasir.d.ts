export interface IBarang {
    nobarcode: string;
    nama: string;
    harga: number;
    stok: number;
}

export interface UpdateIBarang extends IBarang {
    newnobarcode?: string;
}

//INTERFACE FOR SUPPLIER

export interface ISupplier {
    id_sup?: number; // optional because it's auto-incremented
    nama: string;
    alamat: string;
    no_hp: string;
}

export interface UpdateISupplier extends ISupplier {
    id_sup: number; // Required to identify which supplier to update
    nama?: string;
    alamat?: string;
    no_hp?: string;
}
