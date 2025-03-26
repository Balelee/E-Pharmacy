enum ApiRoutes {
  login('users/login'),
  register('users/register'),
  logout('users/logout'),
  resendOtp('phones/resend-otp'),
  verifyOtp('users/verifyOtp'),
  filterProduct('filterProduct'),
  products('products?page={pageKey}&q={query}&filter={filter}'),
  ordersProduct('orders');

  final String path;
  const ApiRoutes(this.path);

  /// Remplace les valeurs dynamiques dans l'URL
  String format(Map<String, dynamic> params) {
    String formattedPath = path;
    params.forEach((key, value) {
      formattedPath = formattedPath.replaceAll(
        '{$key}',
       value != null ? Uri.encodeComponent(value.toString()) : '',
      );
    });
     formattedPath = formattedPath
        .replaceAll(RegExp(r'[?&][^=]+=$'), '')
        .replaceAll(RegExp(r'\?&'), '?') 
        .replaceAll(RegExp(r'\?$'), ''); 

    return formattedPath;
  }
}
