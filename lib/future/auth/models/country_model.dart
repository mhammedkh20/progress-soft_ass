class CountryModel {
  String? status;
  String? country;
  String? countryCode;
  String? region;
  String? regionName;
  String? city;
  String? zip;
  double? lat;
  double? lon;
  String? timezone;
  String? isp;
  String? org;
  String? query;
  String? name;
  String? isoCode;
  String? iso3Code;
  String? phoneCode;

  CountryModel({
    this.status,
    this.country,
    this.countryCode,
    this.region,
    this.regionName,
    this.city,
    this.zip,
    this.lat,
    this.lon,
    this.timezone,
    this.isp,
    this.org,
    this.query,
    this.isoCode,
    this.iso3Code,
    this.phoneCode,
    this.name,
  });

  factory CountryModel.fromMapForLocal(Map<String, String> map) => CountryModel(
        name: map['name']!,
        isoCode: map['isoCode']!,
        iso3Code: map['iso3Code']!,
        phoneCode: map['phoneCode']!,
      );

  CountryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    country = json['country'];
    countryCode = json['countryCode'];
    region = json['region'];
    regionName = json['regionName'];
    city = json['city'];
    zip = json['zip'];
    lat = json['lat'];
    lon = json['lon'];
    timezone = json['timezone'];
    isp = json['isp'];
    org = json['org'];
    query = json['query'];
  }
}
