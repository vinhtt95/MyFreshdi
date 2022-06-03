const demoApiUrl = "/location/search/?query=Chicago";
const getLocalUrl = "/location/search/?query";
const fetchWeatherUrl = "/location/";

class ProdEnvironment {
  final baseUrl = "https://rpc.freshdi.com";
  final baseApi = "/api";
  final baseVersion = "/method";
  final receiveTimeout = 2 * 60 * 1000;
  final connectTimeout = 2 * 60 * 1000;

  String get apiUrl => "$baseUrl$baseApi$baseVersion";
}

final environment = ProdEnvironment();

const batchDetail = '/freshdi.data.test.batch.get_batch_detail';
