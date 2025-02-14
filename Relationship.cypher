// Create a relationship between Warehouse and Shipment nodes
MATCH (w:Warehouse), (s:Shipment)
WHERE w.id_gudang = s.warehouse
CREATE (w)-[:HAS_SHIPMENT]->(s);

// Create a relationship between Truck and Route nodes
MATCH (t:truck), (r:route)
WHERE t.id_truck = r.id_truck
CREATE (t)-[:ON_ROUTE]->(r);

// Create a relationship between Factory (Pabrik) and Vendor nodes
MATCH (p:pabrik)
MATCH (v:vendor)
WITH p, v
MERGE (p)-[:HAS_VENDOR]->(v)
 SET p.nama_bk = v.nama_bk; // Set the factory's raw material name (nama_bk) to match the vendor's raw material name

// Create a relationship between Shipment and Truck nodes
MATCH (s:Shipment), (t:truck)
WHERE s.id_truck = t.id_truck
CREATE (s)-[:IS_USING]->(t);

// Create a relationship between Route and Customer nodes
MATCH (r:route), (p:pelanggan)
WHERE r.id_pelanggan = p.id_pelanggan
CREATE (r)-[:DELIVERY_TO]->(p);

// Create a relationship between Customer and Route nodes
MATCH (c:customer), (r:route)
WHERE c.id_cust = r.id_pelanggan
MERGE (r)-[:DELIVERY_TO]->(c);

// Create a relationship between Warehouse and Distribution Center nodes
// Calculate the distance between their geographic coordinates
MATCH (w:Warehouse)
MATCH (d:distribution_center)
WITH w, d,
point({ longitude: w.longitude, latitude: w.latitude }) AS firstPoint,
point({ longitude: d.longitude, latitude: d.latitude }) AS secondPoint
MERGE (w)-[r:GOING_TO]->(d)
 SET r.distance = point.distance(firstPoint, secondPoint);

// Create a relationship between Distribution Center and Customer nodes
// Calculate the distance between their geographic coordinates
MATCH (c:customer)
MATCH (d:distribution_center)
WITH c, d,
point({ longitude: c.longitude, latitude: c.latitude }) AS firstPoint,
point({ longitude: d.longitude, latitude: d.latitude }) AS secondPoint
MERGE (d)-[r:SEND_TO]->(c)
 SET r.distance = point.distance(firstPoint, secondPoint); 
