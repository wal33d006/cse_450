import 'package:http/http.dart' as http;

abstract class NetworkCall {
  Future<String> getUsers();

  Future<String> getTasks();
}

class HttpNetworkCall implements NetworkCall {
  @override
  Future<String> getUsers() async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/users');
    var response = await http.get(uri);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    return response.body;
  }

  @override
  Future<String> getTasks() async {
    return "";
  }
}

class FirebaseNetworkCall implements NetworkCall {
  @override
  Future<String> getUsers() async {
    // Firebase implementation
    // collection("users").get();

    return "[{'firstName' : 'Waleed', 'lastName' : 'Arshad'}]";
  }

  @override
  Future<String> getTasks() async {
    return "";
  }
}
