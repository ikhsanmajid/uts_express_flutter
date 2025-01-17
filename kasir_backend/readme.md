# REST API Kasir
REST API ini memiliki fitur untuk CRUD barang, supplier serta menambah dan menampilkan penjualan.  

REST API ini dibuat dengan menggunakan:
- **ExpressJS**
- **PrismaORM**
- **MySQL Database**

## Fitur
- [x] Supplier
- [x] Barang
- [x] Penjualan

## API Endpoint
### Supplier
#### 1. **Melihat Semua Supplier**
**Endpoint**: `GET /api/v1/kasir/supplier` \
**Deskripsi**: Menampilkan seluruh daftar supplier.

**Response**:
```json
    [
        {
            "id_sup": 1,
            "nama": "Ikhsan Mart",
            "alamat": "Surakarta",
            "no_hp": "08123456789"
        }
    ]
```
#### 2. **Menambah Supplier**
**Endpoint**: `POST /api/v1/kasir/supplier/tambah` \
**Deskripsi**: Menampilkan seluruh daftar supplier.

**Request**:
```json
{
  "nama": "Rendi",
  "alamat": "Surakarta",
  "no_hp": "0823456787"
}
```

**Response**:
```json
{
    "status": "success",
    "data": {
        "id_sup": 8,
        "nama": "Rendi",
        "alamat": "Surakarta",
        "no_hp": "0823456787"
    }
}
```

