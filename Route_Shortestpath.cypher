// Route Shortest-path: Calculates the top 3 shortest delivery routes using Yen's algorithm
CALL gds.graph.project(
'myGraph',
['Warehouse', 'distribution_center', 'customer'],
['GOING_TO', 'SEND_TO'],
{
  relationshipProperties: 'distance'
}
)

MATCH (source:Warehouse { id_gudang: '9' }), (target:customer {id_cust: '3'})
CALL gds.shortestPath.yens.stream('myGraph', {
  sourceNode: source,
  targetNode: target,
  k: 3,
  relationshipWeightProperty: 'distance'
  })
  YIELD index, sourceNode, targetNode, totalCost, nodeIds, costs, path
  RETURN
  Index+1 AS Urutan,
  gds.util.asNode(sourceNode).id_gudang AS NodeSumber,
  gds.util.asNode(targetNode).id_cust AS NodeTarget,
  totalCost AS JarakTotal,
  Costs AS Jarak,
  nodes(path) AS NodeYangDilalui
   ORDER BY Urutan
