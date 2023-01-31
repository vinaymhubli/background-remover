import 'package:http/http.dart' as http;

class Api {
  static const apikey = "LE1udKdKK8bYmKYG8CtYEVts";
  static removeBg(String imagePath) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("https://api.remove.bg/v1.0/removebg"));
    request.files
        .add(await http.MultipartFile.fromPath("image_file", imagePath));
    request.headers.addAll({"X-API-Key": "LE1udKdKK8bYmKYG8CtYEVts"});
    final response = await request.send();
    if (response.statusCode == 200) {
      http.Response img = await http.Response.fromStream(response);
      return img.bodyBytes;
    } else {
      throw Exception("Error occurred with response ${response.statusCode}");
    }
  }
}
