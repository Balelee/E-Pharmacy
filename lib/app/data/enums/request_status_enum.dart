enum RequestStatusEnum {
  enattente('enattent', "En Attente"),
  traite('traite', "Traité"),
  annule('annule', "Annulé"),
  expire('expire', "Expiré");

  final String value;
  final String label;
  const RequestStatusEnum(this.value, this.label);
}

enum RequestPharmacyStatusEnum {
  enattente('enattent', "En attente"),
  traite('accepted', "Traité"),
  refused('refused', "Réfusé");

  final String value;
  final String label;
  const RequestPharmacyStatusEnum(this.value, this.label);
}
