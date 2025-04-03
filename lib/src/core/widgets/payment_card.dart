import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Card para pagamento inspirado no design da Stripe
class PaymentCard extends StatelessWidget {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cardType;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const PaymentCard({
    super.key,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cardType,
    this.isSelected = false,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.secondary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Ícone do cartão (Visa, Mastercard, etc.)
            Container(
              width: 48,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: _getCardIcon(cardType),
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Informações do cartão
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Número do cartão
                  Text(
                    '•••• •••• •••• ${cardNumber.substring(cardNumber.length - 4)}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  
                  const SizedBox(height: 4),
                  
                  // Nome do titular e data de expiração
                  Text(
                    '$cardHolderName | Expira em $expiryDate',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            
            // Ícone de seleção ou exclusão
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.secondary,
                size: 24,
              )
            else if (onDelete != null)
              IconButton(
                onPressed: onDelete,
                icon: const Icon(
                  Icons.delete_outline,
                  color: AppColors.textLight,
                  size: 24,
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Retorna o ícone do tipo de cartão
  Widget _getCardIcon(String cardType) {
    switch (cardType.toLowerCase()) {
      case 'visa':
        return Text(
          'VISA',
          style: TextStyle(
            color: Colors.blue[800],
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        );
      case 'mastercard':
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            ),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.amber[700],
              ),
            ),
          ],
        );
      case 'amex':
        return Text(
          'AMEX',
          style: TextStyle(
            color: Colors.blue[800],
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        );
      default:
        return const Icon(
          Icons.credit_card,
          size: 20,
          color: Colors.black54,
        );
    }
  }
} 