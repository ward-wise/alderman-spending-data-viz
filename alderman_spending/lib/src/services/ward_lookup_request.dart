import 'package:http/http.dart' as http;
import 'dart:convert';

Future<int> getWard(String address) async {
  const apiURL = "https://api.chicago.gov/els/forwardgeocoding/rest/geocode_3";

  final requestBody = {
    "ForwardGeocodeServiceInput3": {
      "systemId": "WARD_LOOKUP",
      "offsetFt": "20",
      "fullAddress": address,
      "getGeos": {"geographyName": "WARDS_2023"},
    }
  };

  final headers = {
    "Authorization": "Basic ZWxzX2NsaWVudF93YXJkZ2VvOnR2S0xANFM2N2Fw",
    "Content-Type": "application/json",
    "Host": "api.chicago.gov",
    "Origin": "https://gisapps.chicago.gov",
  };

  final response = await http.post(
    Uri.parse(apiURL),
    headers: headers,
    body: jsonEncode(requestBody),
  );

  // Check if the request was successful
  if (response.statusCode != 200) {
    throw Exception('API Request Failed');
  }

  final data = jsonDecode(response.body)["ForwardGeocodeServiceOutput3"];

  // Handle the response data containing geolocation information
  if (data["cleansingStatus"] != "ACTUAL") {
    if (data["cleansingStatusDescription"] == "BADSTREET") {
      throw Exception("Invalid street");
    }
    if (data["cleansingStatusDescription"] == "BADADDRESSNUM") {
      throw Exception("Invalid address number");
    } else {
      throw Exception("Invalid address");
    }
  }

  final wardNumberText = data["geoValues"][0]["geographyValue"];
  try {
    return int.parse(wardNumberText);
  } catch (e) {
    throw Exception(
        "Invalid ward number, expected integer, got $wardNumberText");
  }
}
