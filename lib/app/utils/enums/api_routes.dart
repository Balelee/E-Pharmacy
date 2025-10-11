enum ApiRoutes {
  login('users/login'),
  register('users/register'),
  logout('users/logout'),
  resendOtp('phones/resend-otp'),
  verifyOtp('users/verifyOtp'),
  products('products?page={pageKey}&q={query}&filter={filter}'),
  searchProduct(
      'products/search-product?query={query}&page={page}&limit={limit}'),
  getUserRequests('requests'),
  newUserRequests('requests'),
  requestspharmacies('requests-w-pharmacien?status={status}'),
  requestsTRpharmacies('requests-tr-pharmacien?status={status}'),
  pharmacies('pharmacies?page={pageKey}&q={query}'),
  adminUsers('admin/users'),
  adminUpdateUsers('admin/users/{user}'),
  tips('tips'),
  pillremember('pilrembers'),
  getremenbers('pilrembers'),
  requestResponse("requests/{requestId}/pharmacies/response");

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
