import 'dart:convert';

DepremModel depremModelFromJson(String str) =>
    DepremModel.fromJson(json.decode(str));

String depremModelToJson(DepremModel data) => json.encode(data.toJson());

class DepremModel {
  final bool? status;
  final int? httpStatus;
  final int? serverloadms;
  final String? desc;
  final Metadata? metadata;
  final List<Result>? result;

  DepremModel({
    this.status,
    this.httpStatus,
    this.serverloadms,
    this.desc,
    this.metadata,
    this.result,
  });

  factory DepremModel.fromJson(Map<String, dynamic> json) => DepremModel(
        status: json["status"],
        httpStatus: json["httpStatus"],
        serverloadms: json["serverloadms"],
        desc: json["desc"],
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "httpStatus": httpStatus,
        "serverloadms": serverloadms,
        "desc": desc,
        "metadata": metadata?.toJson(),
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Metadata {
  final DateTime? dateStarts;
  final DateTime? dateEnds;
  final int? total;

  Metadata({
    this.dateStarts,
    this.dateEnds,
    this.total,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        dateStarts: json["date_starts"] == null
            ? null
            : DateTime.parse(json["date_starts"]),
        dateEnds: json["date_ends"] == null
            ? null
            : DateTime.parse(json["date_ends"]),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "date_starts": dateStarts?.toIso8601String(),
        "date_ends": dateEnds?.toIso8601String(),
        "total": total,
      };
}

class Result {
  final String? id;
  final String? earthquakeId;
  final String? provider;
  final String? title;
  final String? date;
  final double? mag;
  final double? depth;
  final Geojson? geojson;
  final LocationProperties? locationProperties;
  final dynamic rev;
  final DateTime? dateTime;
  final int? createdAt;
  final String? locationTz;

  Result({
    this.id,
    this.earthquakeId,
    this.provider,
    this.title,
    this.date,
    this.mag,
    this.depth,
    this.geojson,
    this.locationProperties,
    this.rev,
    this.dateTime,
    this.createdAt,
    this.locationTz,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        earthquakeId: json["earthquake_id"],
        provider: json["provider"],
        title: json["title"],
        date: json["date"],
        mag: json["mag"]?.toDouble(),
        depth: json["depth"]?.toDouble(),
        geojson:
            json["geojson"] == null ? null : Geojson.fromJson(json["geojson"]),
        locationProperties: json["location_properties"] == null
            ? null
            : LocationProperties.fromJson(json["location_properties"]),
        rev: json["rev"],
        dateTime: json["date_time"] == null
            ? null
            : DateTime.parse(json["date_time"]),
        createdAt: json["created_at"],
        locationTz: json["location_tz"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "earthquake_id": earthquakeId,
        "provider": provider,
        "title": title,
        "date": date,
        "mag": mag,
        "depth": depth,
        "geojson": geojson?.toJson(),
        "location_properties": locationProperties?.toJson(),
        "rev": rev,
        "date_time": dateTime?.toIso8601String(),
        "created_at": createdAt,
        "location_tz": locationTz,
      };
}

class Geojson {
  final String? type;
  final List<double>? coordinates;

  Geojson({
    this.type,
    this.coordinates,
  });

  factory Geojson.fromJson(Map<String, dynamic> json) => Geojson(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}

class LocationProperties {
  final ClosestCity? closestCity;
  final ClosestCity? epiCenter;
  final List<ClosestCity>? closestCities;
  final List<Airport>? airports;

  LocationProperties({
    this.closestCity,
    this.epiCenter,
    this.closestCities,
    this.airports,
  });

  factory LocationProperties.fromJson(Map<String, dynamic> json) =>
      LocationProperties(
        closestCity: json["closestCity"] == null
            ? null
            : ClosestCity.fromJson(json["closestCity"]),
        epiCenter: json["epiCenter"] == null
            ? null
            : ClosestCity.fromJson(json["epiCenter"]),
        closestCities: json["closestCities"] == null
            ? []
            : List<ClosestCity>.from(
                json["closestCities"]!.map((x) => ClosestCity.fromJson(x))),
        airports: json["airports"] == null
            ? []
            : List<Airport>.from(
                json["airports"]!.map((x) => Airport.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "closestCity": closestCity?.toJson(),
        "epiCenter": epiCenter?.toJson(),
        "closestCities": closestCities == null
            ? []
            : List<dynamic>.from(closestCities!.map((x) => x.toJson())),
        "airports": airports == null
            ? []
            : List<dynamic>.from(airports!.map((x) => x.toJson())),
      };
}

class Airport {
  final double? distance;
  final String? name;
  final String? code;
  final Geojson? coordinates;

  Airport({
    this.distance,
    this.name,
    this.code,
    this.coordinates,
  });

  factory Airport.fromJson(Map<String, dynamic> json) => Airport(
        distance: json["distance"]?.toDouble(),
        name: json["name"],
        code: json["code"],
        coordinates: json["coordinates"] == null
            ? null
            : Geojson.fromJson(json["coordinates"]),
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "name": name,
        "code": code,
        "coordinates": coordinates?.toJson(),
      };
}

class ClosestCity {
  final String? name;
  final int? cityCode;
  final double? distance;
  final int? population;

  ClosestCity({
    this.name,
    this.cityCode,
    this.distance,
    this.population,
  });

  factory ClosestCity.fromJson(Map<String, dynamic> json) => ClosestCity(
        name: json["name"],
        cityCode: json["cityCode"],
        distance: json["distance"]?.toDouble(),
        population: json["population"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "cityCode": cityCode,
        "distance": distance,
        "population": population,
      };
}
