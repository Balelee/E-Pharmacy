enum OrderDetailStatus {
  disponible,
  indisponible,
  iconnu,
}

extension OrderDetailStatusExtension on OrderDetailStatus {
  String get label {
    switch (this) {
      case OrderDetailStatus.disponible:
        return "Disponible";
      case OrderDetailStatus.indisponible:
        return "Indisponible";
      default:
        return "Inconnu";
    }
  }

  String get name {
    return toString().split('.').last;
  }
}

OrderDetailStatus orderStatusFromString(String? value) {
  switch (value?.toLowerCase()) {
    case 'disponible':
      return OrderDetailStatus.disponible;
    case 'indisponible':
      return OrderDetailStatus.indisponible;
    default:
      return OrderDetailStatus.iconnu;
  }
}
