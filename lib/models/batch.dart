class Batch {
  Message? message;

  Batch({this.message});

  Batch.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message {
  String? culItem;
  String? culFarm;
  String? culBatchNo;
  String? culBatchNoCode;
  String? culSubfarm;
  String? culCert;
  String? culSeed;
  double? culHarvestSize;
  String? culHarvestUom;
  String? culHarvestStartDate;
  String? culHarvestEndDate;
  List<CulTransaction>? culTransaction;

  Message(
      {this.culItem,
      this.culFarm,
      this.culBatchNo,
      this.culBatchNoCode,
      this.culSubfarm,
      this.culCert,
      this.culSeed,
      this.culHarvestSize,
      this.culHarvestUom,
      this.culHarvestStartDate,
      this.culHarvestEndDate,
      this.culTransaction});

  Message.fromJson(Map<String, dynamic> json) {
    culItem = json['cul_item'];
    culFarm = json['cul_farm'];
    culBatchNo = json['cul_batch_no'];
    culBatchNoCode = json['cul_batch_no_code'];
    culSubfarm = json['cul_subfarm'];
    culCert = json['cul_cert'];
    culSeed = json['cul_seed'];
    culHarvestSize = json['cul_harvest_size'];
    culHarvestUom = json['cul_harvest_uom'];
    culHarvestStartDate = json['cul_harvest_start_date'];
    culHarvestEndDate = json['cul_harvest_end_date'];
    if (json['cul_transaction'] != null) {
      culTransaction = <CulTransaction>[];
      json['cul_transaction'].forEach((v) {
        culTransaction!.add(new CulTransaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cul_item'] = this.culItem;
    data['cul_farm'] = this.culFarm;
    data['cul_batch_no'] = this.culBatchNo;
    data['cul_batch_no_code'] = this.culBatchNoCode;
    data['cul_subfarm'] = this.culSubfarm;
    data['cul_cert'] = this.culCert;
    data['cul_seed'] = this.culSeed;
    data['cul_harvest_size'] = this.culHarvestSize;
    data['cul_harvest_uom'] = this.culHarvestUom;
    data['cul_harvest_start_date'] = this.culHarvestStartDate;
    data['cul_harvest_end_date'] = this.culHarvestEndDate;
    if (this.culTransaction != null) {
      data['cul_transaction'] =
          this.culTransaction!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CulTransaction {
  String? transType;
  String? transDate;
  double? transQuantity;
  String? transUom;
  String? transDescription;

  CulTransaction(
      {this.transType,
      this.transDate,
      this.transQuantity,
      this.transUom,
      this.transDescription});

  CulTransaction.fromJson(Map<String, dynamic> json) {
    transType = json['trans_type'];
    transDate = json['trans_date'];
    transQuantity = json['trans_quantity'];
    transUom = json['trans_uom'];
    transDescription = json['trans_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trans_type'] = this.transType;
    data['trans_date'] = this.transDate;
    data['trans_quantity'] = this.transQuantity;
    data['trans_uom'] = this.transUom;
    data['trans_description'] = this.transDescription;
    return data;
  }
}
