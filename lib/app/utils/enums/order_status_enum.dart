enum OrderStatusEnum {
  enattente('enattent', "En Attente"),
  traite('traite', "Traité"),
  annule('annule', "Annulé"),
  expire('expire', "Expiré");

  final String value;
  final String label;
  const OrderStatusEnum(this.value, this.label);
}

enum OrderPharmacyStatusEnum {
  enattente('enattent', "En Attente"),
  traite('accepted', "Traité"),
  refused('refused', "Réfusé");

  final String value;
  final String label;
  const OrderPharmacyStatusEnum(this.value, this.label);
}
