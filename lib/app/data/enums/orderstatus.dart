enum OrderStatus {
  enattent,
  traite,
  annule,
  iconnu,

}

extension OrderStatusExtension on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.enattent:
        return "En attente";
      case OrderStatus.traite:
        return "Traité";
      case OrderStatus.annule:
        return "Annulé";
      default:
        return "Inconnu";
    }
  }

  String get name {
    return toString().split('.').last;
  }
}

OrderStatus orderStatusFromString(String? value) {
  switch (value?.toLowerCase()) {
    case 'enattent':
      return OrderStatus.enattent;
    case 'traite':
      return OrderStatus.traite;
    case 'annule':
      return OrderStatus.annule;
    default:
      return OrderStatus.iconnu;
  }
}
