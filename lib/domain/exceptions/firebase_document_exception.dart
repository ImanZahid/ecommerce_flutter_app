class FirebaseDocumentNotFound implements Exception {
  final String message;
  FirebaseDocumentNotFound(this.message);

  @override
  String toString() => 'FirebaseDocumentNotFound :$this.message';
}