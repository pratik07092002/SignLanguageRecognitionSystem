import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
Future<String> sendImage(File _selectedImage) async {
  var request = http.MultipartRequest('POST', Uri.parse('http://10.0.2.2:5000/upload'));
  request.files.add(await http.MultipartFile.fromPath('image', _selectedImage.path));

  try {
    var response = await request.send().timeout(Duration(seconds: 20));

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var responseData = json.decode(responseBody);

      // Assuming predicted_char is the key for the predicted character in the response
      String predictedChar = responseData['predicted_char'];

      return "$predictedChar";
    } else {
      return "Unable to Upload";
    }

  } catch (e) {
    return "Error: $e";
  }
}
