/// Warehouse

// Ensure 'id_gudang' is unique for Warehouse nodes
CREATE CONSTRAINT warehouse
FOR (w:Warehouse)
REQUIRE w.id_gudang IS UNIQUE;

// Load Warehouse data from CSV and create/update nodes
CALL apoc.load.csv(
'scm_data/warehouse.csv', {
  sep:',',
  header: true
}
)
YIELD map
MERGE (w:Warehouse { id_gudang:map.id_gudang })
 SET
w.nama_gudang = map.phone,
w.kota = map.kota,
w.kapasitas = map.kapasitas,
w.jumlah_perton = map.jumlah_perton,
w.alamat = map.alamat;

/// Shipment

// Ensure 'no_shipment' is unique for Shipment nodes
CREATE CONSTRAINT shipment
FOR (s:Shipment)
REQUIRE s.no_shipment IS UNIQUE;

// Load Shipment data from CSV and create/update nodes
CALL apoc.load.csv(
'scm_data/shipment.csv', {
  sep:',',
  header: true
}
)
YIELD map
MERGE (s:Shipment { no_shipment:map.no_shipment })
 SET
s.id_pelanggan = map.material_shipped,
s.tanggal_pengiriman = map.nama_pelanggan,
s.addr_pelanggan = map.kapasitas,
s.kota_pelanggan = map.kota,
s.warehouse = map.warehouse,
s.id_truck = map.id_truck,
s.jumlah_pesan = map.jumlah_pesan;

/// Vendor

// Ensure 'id_vendor' is unique for Vendor nodes
CREATE CONSTRAINT vendor
FOR (v:vendor)
REQUIRE v.id_vendor IS UNIQUE;

// Load Warehouse data from CSV and create/update nodes
CALL apoc.load.csv(
'scm_data/vendor.csv', {
  sep:',',
  header: true
}
)
YIELD map
MERGE (v:vendor { id_vendor:map.id_vendor })
 SET
v.nama_supplier = map.nama_supplier,
v.nama_bk = map.nama_bk,
v.harga_perton = map.harga_perton,
v.alamat = map.alamat,
v.no_telepon = map.no_telepon,
v.alamat_pelanggan = map.alamat_pelanggan,
v.jumlah_perton = map.jumlah_perton,
v.email = map.email;

/// Pelanggan

// Ensure 'id_pelanggan' is unique for Pelanggan nodes
CREATE CONSTRAINT pelanggan
FOR (p:pelanggan)
REQUIRE p.id_pelanggan IS UNIQUE;

// Load Warehouse data from CSV and create/update nodes
CALL apoc.load.csv(
'scm_data/pelanggan.csv', {
  sep:',',
  header: true
}
)
YIELD map
MERGE (p:pelanggan { id_pelanggan:map.id_pelanggan })
 SET
p.nama_pelanggan = map.nama_pelanggan,
p.alamat_pelanggan = map.alamat_pelanggan,
p.kota = map.kota,
p.kode_pos = map.kode_pos,
p.no_telepon = map.no_telepon;

/// Truck

// Ensure 'id_truck' is unique for Truck nodes
CREATE CONSTRAINT truck
FOR (t:truck)
REQUIRE t.id_truck IS UNIQUE;

// Load Warehouse data from CSV and create/update nodes
CALL apoc.load.csv(
'scm_data/truck.csv', {
  sep:',',
  header: true
}
)
YIELD map
MERGE (t:truck { id_truck:map.id_truck })
 SET
t.nama_truck = map.nama_truck,
t.plat_nomor = map.plat_nomor,
t.kapasitas_perton = map.kapasitas_perton,
t.jenis_truck = map.jenis_truck,
t.rpm = map.rpm,
t.cooling_system = map.cooling_system,
t.pressure_system = map.pressure_system,
t.battery_system = map.battery_system;

/// Route

// Ensure 'no_route' is unique for Route nodes
CREATE CONSTRAINT route
FOR (r:route)
REQUIRE r.no_route IS UNIQUE;

// Load Warehouse data from CSV and create/update nodes
CALL apoc.load.csv(
'scm_data/route.csv', {
  sep:',',
  header: true
}
)
YIELD map
MERGE (r:route { no_route:map.no_route })
 SET
r.id_truck = map.id_truck,
r.id_gudang= map.id_gudang,
r.asal = map.asal,
r.tujuan = map.tujuan,
r.jarak_tempuh_km = map.jarak_tempuh_km,
r.waktu_tempuh_jam = map.waktu_tempuh_jam,
r.id_pelanggan=map.id_pelanggan;

/// Invoice

// Ensure 'no_invoice' is unique for Invoice nodes
CREATE CONSTRAINT invoice
FOR (i:invoice)
REQUIRE i.no_invoice IS UNIQUE;

// Load Warehouse data from CSV and create/update nodes
CALL apoc.load.csv(
'scm_data/invoice.csv', {
  sep:',',
  header: true
}
)
YIELD map
MERGE (i:invoice { no_invoice:map.no_invoice })
 SET
i.no_shipment = map.no_shipment,
i.batch = map.batch,
i.id_cust = map.id_cust,
i.addr_cust = map.addr_cust,
i.warehouse = map.warehouse,
i.plat_no = map.plat_no ,
i.jumlah = map.jumlah;

/// Pabrik

// Ensure 'id_pabrik' is unique for Pabrik nodes
CREATE CONSTRAINT pabrik
FOR (p:pabrik)
REQUIRE p.id_pabrik IS UNIQUE;

// Load Pabrik data from CSV and create/update nodes
LOAD CSV WITH HEADERS FROM 'file:///pabrik.csv' AS row
CREATE (p:pabrik {
id_pabrik: row.id_pabrik,
id_gudang: row.id_gudang,
nama_pabrik: row.nama_pabrik,
alamat :row.alamat,
kota: row.kota,
Crusher_Sensor_Getaran: row.Crusher_Sensor_Getaran,
Crusher_Sensor_Suhu: row.Crusher_Sensor_Suhu,
Crusher_Sensor_Keausan: row.Crusher_Sensor_Keausan,
Proportioning_Equipment_Sensor_Timbangan : row.Proportioning_Equipment_Sensor_Timbangan,
Grinding_Mill_Sensor_Getaran: row.Grinding_Mill_Sensor_Getaran,
Grinding_Mill_Sensor_Suhu: row.Grinding_Mill_Sensor_Suhu,
Preheater_Tower_Sensor_Suhu: row.Preheater_Tower_Sensor_Suhu,
Preheater_Tower_Sensor_Gas: row.Preheater_Tower_Sensor_Gas,
Kiln_Sensor_Suhu: row.Kiln_Sensor_Suhu,
Kiln_Sensor_Gas: row.Kiln_Sensor_Gas,
Kiln_Sensor_Kebocoran: row.Kiln_Sensor_Kebocoran
});

/// Distribution_center

// Ensure 'id_dc' is unique for Distribution_center nodes
CREATE CONSTRAINT distribution_center
FOR (d:distribution_center)
REQUIRE d.id_dc IS UNIQUE;

// Load Distribution_center data from CSV and create/update nodes
LOAD CSV WITH HEADERS FROM 'file:///distribution_center.csv' AS row
CREATE (d:distribution_center {
id_dc: row.id_dc,
kota_kabupaten: row.kota_kabupaten,
latitute: row.latitute,
longitute :row.longitute});
