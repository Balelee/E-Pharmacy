enum OrderStatusEnum {
  enattente('enattent', "En Attente"),
  traite('traite', "Traité"),
  annule('annule', "Annulé"),
  expire('expire', "Expiré");

  final String value;
  final String label;
  const OrderStatusEnum(this.value, this.label);
}
