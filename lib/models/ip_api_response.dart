class ApiResponse {
    String asn;
    String city;
    String continent_code;
    String country;
    double country_area;
    String country_calling_code;
    String country_capital;
    String country_code;
    String country_code_iso3;
    String country_name;
    double country_population;
    String country_tld;
    String currency;
    String currency_name;
    bool in_eu;
    String ip;
    String languages;
    double latitude;
    double longitude;
    String org;
    String postal;
    String region;
    String region_code;
    String timezone;
    String utc_offset;

    ApiResponse({this.asn, this.city, this.continent_code, this.country, this.country_area, this.country_calling_code, this.country_capital, this.country_code, this.country_code_iso3, this.country_name, this.country_population, this.country_tld, this.currency, this.currency_name, this.in_eu, this.ip, this.languages, this.latitude, this.longitude, this.org, this.postal, this.region, this.region_code, this.timezone, this.utc_offset});

    factory ApiResponse.fromJson(Map<String, dynamic> json) {
        return ApiResponse(
            asn: json['asn'], 
            city: json['city'], 
            continent_code: json['continent_code'], 
            country: json['country'], 
            country_area: json['country_area'], 
            country_calling_code: json['country_calling_code'], 
            country_capital: json['country_capital'], 
            country_code: json['country_code'], 
            country_code_iso3: json['country_code_iso3'], 
            country_name: json['country_name'], 
            country_population: json['country_population'], 
            country_tld: json['country_tld'], 
            currency: json['currency'], 
            currency_name: json['currency_name'], 
            in_eu: json['in_eu'], 
            ip: json['ip'], 
            languages: json['languages'], 
            latitude: json['latitude'], 
            longitude: json['longitude'], 
            org: json['org'], 
            postal: json['postal'], 
            region: json['region'], 
            region_code: json['region_code'], 
            timezone: json['timezone'], 
            utc_offset: json['utc_offset'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['asn'] = this.asn;
        data['city'] = this.city;
        data['continent_code'] = this.continent_code;
        data['country'] = this.country;
        data['country_area'] = this.country_area;
        data['country_calling_code'] = this.country_calling_code;
        data['country_capital'] = this.country_capital;
        data['country_code'] = this.country_code;
        data['country_code_iso3'] = this.country_code_iso3;
        data['country_name'] = this.country_name;
        data['country_population'] = this.country_population;
        data['country_tld'] = this.country_tld;
        data['currency'] = this.currency;
        data['currency_name'] = this.currency_name;
        data['in_eu'] = this.in_eu;
        data['ip'] = this.ip;
        data['languages'] = this.languages;
        data['latitude'] = this.latitude;
        data['longitude'] = this.longitude;
        data['org'] = this.org;
        data['postal'] = this.postal;
        data['region'] = this.region;
        data['region_code'] = this.region_code;
        data['timezone'] = this.timezone;
        data['utc_offset'] = this.utc_offset;
        return data;
    }
}