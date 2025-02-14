// Demand Forecasting: Implements node regression pipeline for order prediction

//Pipeline

CALL gds.alpha.pipeline.nodeRegression.create('pipe2')

CALL gds.alpha.pipeline.nodeRegression.addNodeProperty('pipe2', 'fastRP', {
  mutateProperty: 'embedding',
  embeddingDimension: 256,
  randomSeed: 25
})

CALL gds.alpha.pipeline.nodeRegression.selectFeatures('pipe2', ['embedding', 'epoch','epoch-1','epoch-2'])
YIELD name, featureProperties

CALL gds.alpha.pipeline.nodeRegression.configureSplit('pipe2', {
  testFraction: 0.2,
  validationFolds: 5
}) YIELD splitConfig

CALL gds.alpha.pipeline.nodeRegression.addLinearRegression('pipe2')
YIELD parameterSpace

CALL gds.alpha.pipeline.nodeRegression.addRandomForest('pipe2', {numberOfDecisionTrees: 5})
YIELD parameterSpace

CALL gds.alpha.pipeline.nodeRegression.addLinearRegression('pipe2', {maxEpochs: 500, penalty: {range: [1e-4, 1e2]}})
YIELD parameterSpace
RETURN parameterSpace.RandomForest AS randomForestSpace, parameterSpace.LinearRegression AS linearRegressionSpace

CALL gds.alpha.pipeline.nodeRegression.configureAutoTuning('pipe2', {
  maxTrials: 100
}) YIELD autoTuningConfig

//Training

CALL gds.graph.project('myGraph3', {
    pengiriman: { properties: ['epoch','epoch-1','epoch-2', 'total_jumlah_pesan'] },
    unknown_shipment: { properties: ['epoch','epoch-1','epoch-2']}
  },
  '*'
)

CALL gds.alpha.pipeline.nodeRegression.train('myGraph3', {
  pipeline: 'pipe2',
  targetNodeLabels: ['pengiriman'],
  modelName: 'nr-pipeline-model',
  targetProperty: 'total_jumlah_pesan',
  randomSeed: 25,
  concurrency: 1,
  metrics: ['MEAN_SQUARED_ERROR']
}) YIELD modelInfo
RETURN
  modelInfo.bestParameters AS winningModel,
  modelInfo.metrics.MEAN_SQUARED_ERROR.train.avg AS AvgTrainScore,
  modelInfo.metrics.MEAN_SQUARED_ERROR.outerTrain AS OuterTrainScore,
  modelInfo.metrics.MEAN_SQUARED_ERROR.test AS TestScore


//Predict

CALL gds.alpha.pipeline.nodeRegression.predict.stream('myGraph3', {
  modelName: 'nr-pipeline-model',
  targetNodeLabels: ['unknown_shipment']
}) YIELD nodeId, predictedValue
WITH gds.util.asNode(nodeId) AS shipmentNode, predictedValue AS PrediksiPesanan
RETURN
  shipmentNode.tanggal_pengiriman AS TanggalPengiriman, PrediksiPesanan
  ORDER BY TanggalPengiriman
