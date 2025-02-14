// Convert the 'harga_perton' property of Vendor nodes from string to integer
MATCH (v:vendor)
SET v.harga_perton = toInteger(v.harga_perton);

// Convert the 'tanggal_pengiriman' property of Shipment nodes from string to a datetime object
// The string is parsed as a date in the format 'MM/dd/YYYY HH:mm:ss', with '00:00:00' added as the default time
MATCH (s:shipment)
SET s.tanggal_pengiriman = datetime({ epochMillis: apoc.date.parse(s.tanggal_pengiriman + " 00:00:00", 'ms', 'MM/dd/YYYY HH:mm:ss') })