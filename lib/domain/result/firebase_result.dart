
import 'package:ecommerce_flutter_app/domain/result/status_code.dart';

class FirebaseResult {  
  final StatusCode statusCode;
  final String message;
  FirebaseResult({required this.statusCode, required this.message});
}