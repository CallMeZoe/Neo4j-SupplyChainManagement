// Production Machines Maintenance: Checks sensor status for multiple equipment in the factory
MATCH (p:pabrik)
WHERE
NOT (p.Crusher_Sensor_Getaran = 'Baik') OR
NOT (p.Crusher_Sensor_Suhu = 'Baik') OR
NOT (p.Crusher_Sensor_Keausan = 'Baik') OR
NOT (p.Proportioning_Equipment_Sensor_Timbangan = 'Baik') OR
NOT (p.Grinding_Mill_Sensor_Getarann = 'Baik') OR
NOT (p.Grinding_Mill_Sensor_Suhu = 'Baik') OR
NOT (p.Preheater_Tower_Sensor_Suhu = 'Baik') OR
NOT (p.Preheater_Tower_Sensor_Gas = 'Baik') OR
NOT (p.Kiln_Sensor_Suhu = 'Baik') OR
NOT (p.Kiln_Sensor_Gas = 'Baik') OR
NOT (p.Kiln_Sensor_Kebocoran = 'Baik')
RETURN p.nama_pabrik AS NamaPabrik,
p.alamat AS AlamatPabrik,
CASE
  WHEN (p.Crusher_Sensor_Getaran = 'Baik') AND (p.Crusher_Sensor_Suhu = 'Baik') AND (p.Crusher_Sensor_Keausan = 'Baik') THEN "Baik"
  ELSE "Terjadi masalah"
END AS KeadaanCrusher,
CASE
  WHEN p.Proportioning_Equipment_Sensor_Timbangan = 'Baik' THEN "Baik"
  ELSE "Terjadi masalah"
END AS KeadaanProportioningEquipment,
CASE
  WHEN (p.Grinding_Mill_Sensor_Getarann = 'Baik') AND (p.Grinding_Mill_Sensor_Suhu = 'Baik') THEN "Baik"
  ELSE "Terjadi masalah"
END AS KeadaanGrindingMill,
CASE
  WHEN (p.Preheater_Tower_Sensor_Suhu = 'Baik') AND (p.Preheater_Tower_Sensor_Gas = 'Baik') THEN "Baik"
  ELSE "Terjadi masalah"
END AS KeadaanPreheaterTower,
CASE
  WHEN (p.Kiln_Sensor_Suhu = 'Baik') AND (p.Kiln_Sensor_Gas = 'Baik') AND (p.Kiln_Sensor_Kebocoran = 'Baik') THEN "Baik"
  ELSE "Terjadi masalah"
END AS KeadaanKiln
