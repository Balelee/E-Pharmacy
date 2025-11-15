import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharmix/app/data/models/request.dart';
import 'package:pharmix/generated/locales.g.dart';

class RequestCard extends StatefulWidget {
  final Request request;
  final VoidCallback? onCancel;
  final VoidCallback? onTap;

  const RequestCard({
    Key? key,
    required this.request,
    required this.onTap,
    this.onCancel,
  }) : super(key: key);

  @override
  State<RequestCard> createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  bool _showDetails = false;

  @override
  Widget build(BuildContext context) {
    final r = widget.request;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // — Titre + Statut
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Requête ${r.number}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    // Texte du statut
                    Text(
                      r.statusLabel,
                      style: TextStyle(
                        color: r.statusColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    // Si en attente → loader
                    if (r.status.toLowerCase() == 'enattent') ...[
                      const SizedBox(width: 13),
                      const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            const SizedBox(height: 4),

            // — Produits + Date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${r.requestDetails.length} produits sélectionnés",
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                  ),
                ),
                Text(
                  r.amount.contains("FCFA") ? r.amount : "${r.amount} FCFA",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // — Détails supplémentaires (affichage conditionnel)
            if (_showDetails)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: r.requestDetails.map((d) {
                  print("status ${r.status.trim().toLowerCase()}");
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: d.statusColor!.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            d.imageUrl ?? '',
                            width: 45,
                            height: 45,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.medication, size: 40),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                d.productName ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${d.quantity} × ${d.priceUnitaire} FCFA",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

            // — Bas de carte (voir plus / annuler)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => setState(() => _showDetails = !_showDetails),
                  child: Text(
                    _showDetails ? "voir moins" : "voir plus",
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (r.status.trim().toLowerCase() == 'enattent')
                  ElevatedButton(
                    onPressed: widget.onCancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade50,
                      foregroundColor: Colors.redAccent,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      LocaleKeys.cancel.tr,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
