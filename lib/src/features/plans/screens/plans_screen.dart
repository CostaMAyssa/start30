import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/widgets.dart';
import '../models/plan_model.dart';

/// Tela de seleção de planos
class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = PlanModel.getPlans();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha seu plano'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho
            Text(
              'Transforme sua ideia em um negócio digital',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              'Escolha o plano que melhor se adapta às suas necessidades',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            
            const SizedBox(height: 32),
            
            // Lista de planos
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: plans.length,
              separatorBuilder: (context, index) => const SizedBox(height: 24),
              itemBuilder: (context, index) {
                final plan = plans[index];
                
                return PlanCard(
                  title: plan.title,
                  price: plan.price,
                  description: plan.description,
                  features: plan.features,
                  isPopular: plan.isPopular,
                  onSelect: () => _onSelectPlan(context, plan),
                );
              },
            ),
            
            const SizedBox(height: 32),
            
            // Informações adicionais
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.secondary.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.secondary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Informações importantes',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Text(
                    '• Todos os planos incluem suporte durante o período de desenvolvimento',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    '• Pagamento seguro processado pela Stripe',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    '• Garantia de satisfação ou seu dinheiro de volta em até 7 dias',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Rodapé
            Center(
              child: TextButton.icon(
                onPressed: () => _showContactDialog(context),
                icon: const Icon(Icons.support_agent),
                label: const Text('Precisa de ajuda? Fale conosco'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Navega para a tela de pagamento quando um plano é selecionado
  void _onSelectPlan(BuildContext context, PlanModel plan) {
    Navigator.of(context).pushNamed('/payment', arguments: plan);
  }

  /// Exibe um diálogo com informações de contato
  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Fale Conosco'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Entre em contato conosco para tirar suas dúvidas:'),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.email, size: 20, color: AppColors.secondary),
                const SizedBox(width: 8),
                Text(
                  'contato@start30.com.br',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone, size: 20, color: AppColors.secondary),
                const SizedBox(width: 8),
                Text(
                  '(XX) XXXXX-XXXX',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.public, size: 20, color: AppColors.secondary),
                const SizedBox(width: 8),
                Text(
                  'www.start30.com.br',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
} 