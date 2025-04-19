import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/widgets.dart';
import '../models/idea_qualification_model.dart';
import '../services/idea_qualification_service.dart';
import '../../../core/widgets/stripe_text_field.dart';

/// Tela de qualificação de ideias - formulário rápido e eficiente
class IdeaFormScreen extends StatefulWidget {
  const IdeaFormScreen({super.key});

  @override
  State<IdeaFormScreen> createState() => _IdeaFormScreenState();
}

class _IdeaFormScreenState extends State<IdeaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _service = IdeaQualificationService();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ideaDescriptionController = TextEditingController();
  final _targetAudienceController = TextEditingController();
  
  bool _isLoading = false;
  int _currentStep = 0;
  String _selectedBusiness = '';
  String _selectedBudget = '';
  String _selectedTimeline = '';
  final List<String> _selectedGoals = [];

  // Lista de áreas de negócio
  final List<String> _businessAreas = [
    'E-commerce',
    'Educação',
    'Saúde e bem-estar',
    'Finanças',
    'Serviços profissionais',
    'Tecnologia',
    'Outro',
  ];

  // Lista de orçamentos
  final List<String> _budgetOptions = [
    'Até R\$15.000',
    'R\$15.000 - R\$30.000',
    'R\$30.000 - R\$50.000',
    'Acima de R\$50.000',
  ];

  // Lista de prazos
  final List<String> _timelineOptions = [
    '30 dias (urgente)',
    '1-2 meses',
    '2-3 meses',
    'Mais de 3 meses',
  ];

  // Lista de objetivos
  final List<String> _goalOptions = [
    'Validar ideia de negócio',
    'Lançar produto/serviço no mercado',
    'Automatizar processos da empresa',
    'Criar nova fonte de receita',
    'Melhorar experiência dos clientes',
    'Expandir para novos mercados',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ideaDescriptionController.dispose();
    _targetAudienceController.dispose();
    super.dispose();
  }

  // Avança para o próximo passo do formulário
  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep += 1;
      });
    } else {
      _submitForm();
    }
  }

  // Volta para o passo anterior do formulário
  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep -= 1;
      });
    }
  }

  // Envia o formulário
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Criar o modelo com os dados do formulário
      final qualification = IdeaQualificationModel(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        businessArea: _selectedBusiness,
        ideaDescription: _ideaDescriptionController.text,
        targetAudience: _targetAudienceController.text,
        budget: _selectedBudget,
        timeline: _selectedTimeline,
        selectedGoals: List.from(_selectedGoals),
        submissionDate: DateTime.now(),
      );

      // Enviar via serviço
      final success = await _service.submitQualification(qualification);

      // Pontuação para análise interna
      final score = _service.scoreQualification(qualification);
      debugPrint('Pontuação da qualificação: $score/100');

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      if (success) {
        // Mostrar diálogo de sucesso em vez de SnackBar
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            backgroundColor: const Color(0xFF1A1A1A),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: AppColors.secondary.withOpacity(0.3)),
            ),
            title: Row(
              children: [
                Icon(Icons.check_circle, color: AppColors.success, size: 28),
                const SizedBox(width: 12),
                Text(
                  'Recebemos seu projeto!',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'O que acontece agora?',
                  style: GoogleFonts.poppins(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF25D366).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.chat,
                        color: const Color(0xFF25D366),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Nossa equipe entrará em contato pelo WhatsApp para agendar nossa primeira reunião.',
                        style: GoogleFonts.poppins(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(); // Retorna para a página anterior
                },
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.secondary,
                ),
                child: Text(
                  'Entendi',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      } else {
        // Mostrar erro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Erro ao enviar projeto. Tente novamente mais tarde.',
              style: GoogleFonts.poppins(),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  // Função que retorna a decoração personalizada para os campos de texto
  InputDecoration _getCustomInputDecoration({String? hintText}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.poppins(
        color: Colors.grey[300],
        fontSize: 14,
      ),
      filled: true,
      fillColor: const Color(0xFF0A0A0A),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.secondary.withOpacity(0.7),
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.secondary,
          width: 2.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.error,
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.error,
          width: 2,
        ),
      ),
      errorStyle: const TextStyle(color: AppColors.error),
    );
  }

  // Widget de campo de texto personalizado
  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String label,
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: GoogleFonts.poppins(color: Colors.white),
          decoration: _getCustomInputDecoration(hintText: hintText),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;
    
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          'Qualificação Rápida',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : screenSize.width * 0.1,
            vertical: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Vamos conhecer sua ideia',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Preencha este formulário rápido para que possamos avaliar como ajudar a transformar sua ideia em um negócio digital de sucesso.',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 16 : 18,
                  color: Colors.white.withOpacity(0.85),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.secondary.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.secondary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Após o envio, nossa equipe analisará suas informações e entrará em contato via WhatsApp para agendar uma conversa sobre seu projeto.',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: (_currentStep + 1) / 3,
                backgroundColor: Colors.white10,
                color: AppColors.secondary,
                minHeight: 6,
                borderRadius: BorderRadius.circular(8),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Passo ${_currentStep + 1} de 3',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Container(
                padding: EdgeInsets.all(isMobile ? 24 : 40),
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white10),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Passo 1: Dados pessoais
                      if (_currentStep == 0) ...[
                        Text(
                          'Informações de contato',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _buildCustomTextField(
                          controller: _nameController,
                          label: 'Seu nome',
                          hintText: 'Digite seu nome completo',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, informe seu nome';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildCustomTextField(
                          controller: _emailController,
                          label: 'Seu e-mail',
                          hintText: 'exemplo@email.com',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, informe seu e-mail';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                              return 'Por favor, informe um e-mail válido';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildCustomTextField(
                          controller: _phoneController,
                          label: 'Seu telefone',
                          hintText: '(00) 00000-0000',
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, informe seu telefone';
                            }
                            return null;
                          },
                        ),
                      ],
                      
                      // Passo 2: Detalhes da ideia
                      if (_currentStep == 1) ...[
                        Text(
                          'Sobre sua ideia',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Área de atuação',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: _businessAreas.map((area) {
                            return ChoiceChip(
                              label: Text(area),
                              selected: _selectedBusiness == area,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedBusiness = selected ? area : '';
                                });
                              },
                              backgroundColor: const Color(0xFF111111),
                              selectedColor: AppColors.secondary.withOpacity(0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: _selectedBusiness == area 
                                    ? AppColors.secondary 
                                    : AppColors.secondary.withOpacity(0.5),
                                  width: _selectedBusiness == area ? 2 : 1,
                                ),
                              ),
                              labelStyle: GoogleFonts.poppins(
                                color: _selectedBusiness == area
                                    ? AppColors.secondary
                                    : Colors.white,
                                fontSize: 14,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        _buildCustomTextField(
                          controller: _ideaDescriptionController,
                          label: 'Descreva brevemente sua ideia ou negócio',
                          hintText: 'Conte-nos sobre sua ideia ou projeto...',
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, descreva sua ideia ou projeto';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        _buildCustomTextField(
                          controller: _targetAudienceController,
                          label: 'Quem é o público-alvo da sua ideia?',
                          hintText: 'Descreva quem são seus clientes ideais',
                          maxLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, descreva o público-alvo da sua ideia';
                            }
                            return null;
                          },
                        ),
                      ],
                      
                      // Passo 3: Orçamento, prazos e objetivos
                      if (_currentStep == 2) ...[
                        Text(
                          'Expectativas e objetivos',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Qual orçamento você tem em mente?',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.85),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: _budgetOptions.map((budget) {
                            return ChoiceChip(
                              label: Text(budget),
                              selected: _selectedBudget == budget,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedBudget = selected ? budget : '';
                                });
                              },
                              backgroundColor: const Color(0xFF111111),
                              selectedColor: AppColors.secondary.withOpacity(0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: _selectedBudget == budget 
                                    ? AppColors.secondary 
                                    : AppColors.secondary.withOpacity(0.5),
                                  width: _selectedBudget == budget ? 2 : 1,
                                ),
                              ),
                              labelStyle: GoogleFonts.poppins(
                                color: _selectedBudget == budget
                                    ? AppColors.secondary
                                    : Colors.white,
                                fontSize: 14,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Qual é o seu prazo ideal?',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.85),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: _timelineOptions.map((timeline) {
                            return ChoiceChip(
                              label: Text(timeline),
                              selected: _selectedTimeline == timeline,
                              onSelected: (selected) {
                                setState(() {
                                  _selectedTimeline = selected ? timeline : '';
                                });
                              },
                              backgroundColor: const Color(0xFF111111),
                              selectedColor: AppColors.secondary.withOpacity(0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: _selectedTimeline == timeline 
                                    ? AppColors.secondary 
                                    : AppColors.secondary.withOpacity(0.5),
                                  width: _selectedTimeline == timeline ? 2 : 1,
                                ),
                              ),
                              labelStyle: GoogleFonts.poppins(
                                color: _selectedTimeline == timeline
                                    ? AppColors.secondary
                                    : Colors.white,
                                fontSize: 14,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Quais são seus principais objetivos? (selecione até 3)',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white.withOpacity(0.85),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: _goalOptions.map((goal) {
                            return FilterChip(
                              label: Text(goal),
                              selected: _selectedGoals.contains(goal),
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    if (_selectedGoals.length < 3) {
                                      _selectedGoals.add(goal);
                                    }
                                  } else {
                                    _selectedGoals.remove(goal);
                                  }
                                });
                              },
                              backgroundColor: const Color(0xFF111111),
                              selectedColor: AppColors.secondary.withOpacity(0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                                side: BorderSide(
                                  color: _selectedGoals.contains(goal) 
                                    ? AppColors.secondary 
                                    : AppColors.secondary.withOpacity(0.5),
                                  width: _selectedGoals.contains(goal) ? 2 : 1,
                                ),
                              ),
                              labelStyle: GoogleFonts.poppins(
                                color: _selectedGoals.contains(goal)
                                    ? AppColors.secondary
                                    : Colors.white,
                                fontSize: 14,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              showCheckmark: false,
                            );
                          }).toList(),
                        ),
                      ],
                      
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (_currentStep > 0)
                            OutlinedButton(
                              onPressed: _previousStep,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(color: AppColors.secondary.withOpacity(0.5)),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                foregroundColor: Colors.white,
                              ),
                              child: Text(
                                'Voltar',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          else
                            const SizedBox.shrink(),
                          StripeButton(
                            text: _currentStep < 2 
                                ? 'Continuar' 
                                : (_isLoading ? 'Enviando...' : 'Enviar'),
                            onPressed: _isLoading 
                                ? () {} 
                                : _nextStep,
                            isSecondary: true,
                            width: 160,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 