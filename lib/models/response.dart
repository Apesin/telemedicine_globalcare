class GResponse {
  final bool isSuccessful;
  final String errorMessage;
  final Map<dynamic, dynamic> extraData;

  GResponse({
    required this.isSuccessful,
      required this.errorMessage,
     required this.extraData,
  });
}
