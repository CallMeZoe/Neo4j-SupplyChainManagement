// Truck Problems Maintenance: Monitors truck engine parameters and identifies issues
MATCH (t:truck)
WHERE
NOT (700 <= t.rpm <= 2500) OR
NOT (30 <= t.pressure_system <= 70) OR
NOT (80 <= t.cooling_system <= 95) OR
NOT (23 <= t.battery_system <= 25)
RETURN t.nama_truck AS NamaTruk,
t.plat_nomor AS PlatNomor,
CASE
  WHEN 700 <= t.rpm <= 2500 THEN "Baik"
  ELSE "Terjadi masalah"
END AS KeadaanMesin,
CASE
  WHEN 30 <= t.pressure_system <= 70 THEN "Baik"
  ELSE "Terjadi masalah"
END AS KeadaanPressureSystem,
CASE
  WHEN 80 <= t.cooling_system <= 95 THEN "Baik"
  ELSE "Terjadi masalah"
END AS KeadaanCoolingSystem,
CASE
  WHEN 23 <= t.battery_system <= 25 THEN "Baik"
  ELSE "Terjadi masalah"
END AS KeadaanAki
