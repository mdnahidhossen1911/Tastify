class NetworkResponse {
  final Map<String, dynamic>? responseData;
  final bool isSuccess;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    this.responseData,
    this.errorMessage = 'Something went wrong!',
  });
}