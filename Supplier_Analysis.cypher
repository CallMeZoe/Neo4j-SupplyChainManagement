// Supplier Analysis: Finds the cheapest supplier for each raw material
MATCH (v:vendor)
WITH v.nama_bk AS namaBahanBaku, min(v.harga_perton) AS hargaMin
MATCH (vend:vendor {nama_bk: namaBahanBaku, harga_perton: hargaMin})
RETURN namaBahanBaku, hargaMin, collect(vend.nama_supplier) AS cheapestSupplier
