import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/widgets.dart';

/// Tela de cadastro
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _projectNameController = TextEditingController();
  final _projectDescriptionController = TextEditingController();
  final _goalsController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _projectNameController.dispose();
    _projectDescriptionController.dispose();
    _goalsController.dispose();
    super.dispose();
  }

  void _submitProject() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simular envio do projeto
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      // Exibir mensagem de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Projeto enviado com sucesso! Entraremos em contato em breve.',
            style: GoogleFonts.poppins(),
          ),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 4),
        ),
      );

      // Navegar para a tela inicial
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, '/');
      });
    }
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
                'Conte-nos sobre seu projeto',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Queremos conhecer melhor sua ideia para ajudar você a transformá-la em um negócio digital de sucesso em apenas 30 dias.',
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 16 : 18,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
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
                      Text(
                        'Informações pessoais',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                      StripeTextField(
                        controller: _nameController,
                        label: 'Seu nome',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, informe seu nome';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      StripeTextField(
                        controller: _emailController,
                        label: 'Seu e-mail',
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
                      StripeTextField(
                        controller: _phoneController,
                        label: 'Seu telefone',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, informe seu telefone';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      Text(
                        'Detalhes do projeto',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                      StripeTextField(
                        controller: _projectNameController,
                        label: 'Nome do projeto/empresa',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, informe o nome do seu projeto';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      StripeTextField(
                        controller: _projectDescriptionController,
                        label: 'Descreva sua ideia ou projeto',
                        maxLines: 5,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, descreva seu projeto';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      StripeTextField(
                        controller: _goalsController,
                        label: 'Quais são seus principais objetivos com este projeto?',
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, informe seus objetivos';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      StripeButton(
                        text: _isLoading ? 'Enviando...' : 'Enviar projeto',
                        onPressed: _isLoading ? () {} : _submitProject,
                        isSecondary: true,
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Já tem uma conta?',
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                      child: Text(
                        'Entrar',
                        style: GoogleFonts.poppins(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 