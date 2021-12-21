// To parse this JSON data, do
//
//     final publicServicesResponse = publicServicesResponseFromJson(jsonString);

import 'dart:convert';

PublicServicesResponse publicServicesResponseFromJson(String str) =>
    PublicServicesResponse.fromJson(json.decode(str));

String publicServicesResponseToJson(PublicServicesResponse data) =>
    json.encode(data.toJson());

class PublicServicesResponse {
  PublicServicesResponse({
    this.result,
    this.message,
    this.data,
  });

  bool result;
  String message;
  List<Datum> data;

  factory PublicServicesResponse.fromJson(Map<String, dynamic> json) =>
      PublicServicesResponse(
        result: json["result"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.serviceName,
    this.serviceId,
    this.serviceBanner,
    this.allServices,
  });

  String serviceName;
  int serviceId;
  dynamic serviceBanner;
  List<AllService> allServices;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        serviceName: json["service_name"],
        serviceId: json["service_id"],
        serviceBanner: json["service_banner"],
        allServices: List<AllService>.from(
            json["all_services"].map((x) => AllService.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "service_name": serviceName,
        "service_id": serviceId,
        "service_banner": serviceBanner,
        "all_services": List<dynamic>.from(allServices.map((x) => x.toJson())),
      };
}

class AllService {
  AllService({
    this.serviceId,
    this.serviceName,
    this.serviceIcon,
    this.serviceUrl,
  });

  int serviceId;
  String serviceName;
  String serviceIcon;
  String serviceUrl;

  factory AllService.fromJson(Map<String, dynamic> json) => AllService(
        serviceId: json["service_id"],
        serviceName: json["service_name"],
        serviceIcon: json["service_icon"],
        serviceUrl: json["service_url"],
      );

  Map<String, dynamic> toJson() => {
        "service_id": serviceId,
        "service_name": serviceName,
        "service_icon": serviceIcon,
        "service_url": serviceUrl,
      };
}
