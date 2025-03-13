enum ApiRoutes {
  login('users/login'),
  register('users/register'),
  logout('users/logout'),
  resendOtp('phones/resend-otp'),
  verifyOtp('users/verifyOtp');

  final String path;
  const ApiRoutes(this.path);

  /// Remplace les valeurs dynamiques dans l'URL
  String format(Map<String, String> params) {
    String formattedPath = path;
    params.forEach((key, value) {
      formattedPath = formattedPath.replaceAll('{$key}', value);
    });
    return formattedPath;
  }
}
