/// Modelo para os planos da Start30
class PlanModel {
  final String id;
  final String title;
  final String price;
  final String description;
  final List<String> features;
  final bool isPopular;

  PlanModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.features,
    this.isPopular = false,
  });

  /// Lista de planos da Start30
  static List<PlanModel> getPlans() {
    return [
      PlanModel(
        id: 'essential',
        title: 'Plano Essencial',
        price: '1.497',
        description: 'Validação de Ideia',
        features: [
          'Pesquisa de mercado simplificada',
          'Definição de público-alvo',
          'Estruturação básica do modelo de negócios',
          'Protótipo ou conceito básico',
          'Suporte por 30 dias',
        ],
        isPopular: false,
      ),
      PlanModel(
        id: 'intermediate',
        title: 'Plano Intermediário',
        price: '2.997',
        description: 'MVP Funcional',
        features: [
          'Tudo do plano essencial',
          'Protótipo funcional',
          'Estratégia de monetização',
          'Teste com primeiros clientes',
          'Suporte por 60 dias',
        ],
        isPopular: true,
      ),
      PlanModel(
        id: 'premium',
        title: 'Plano Premium',
        price: '4.997',
        description: 'Produto Pronto para Escalar',
        features: [
          'Tudo dos planos anteriores',
          'Produto pronto para lançamento',
          'Suporte na estratégia de vendas',
          'Automação inicial com IA',
          'Suporte por 90 dias',
        ],
        isPopular: false,
      ),
    ];
  }
} 