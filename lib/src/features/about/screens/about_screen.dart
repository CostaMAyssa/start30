import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/widgets.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;
    final double horizontalPadding = isMobile ? 24 : 80;
    final double maxWidth = 1200.0;

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
        child: Column(
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 60 : 100,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF111111),
                    Color(0xFF0A0A0A),
                  ],
                ),
              ),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Nossa História',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 32 : 56,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Conheça a jornada que nos trouxe até aqui e nossa missão de transformar ideias em negócios digitais de sucesso.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 16 : 20,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // História
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 60 : 100,
              ),
              color: const Color(0xFF111111),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildStorySection(
                        year: '2020',
                        title: 'O Início',
                        description: 'A Start30 nasceu da percepção de que muitos empreendedores tinham ótimas ideias, mas enfrentavam dificuldades para transformá-las em negócios digitais. Nossa missão começou com o objetivo de simplificar esse processo.',
                        isMobile: isMobile,
                      ),
                      const SizedBox(height: 64),
                      _buildStorySection(
                        year: '2021',
                        title: 'Crescimento e Evolução',
                        description: 'Desenvolvemos nossa metodologia única de 30 dias, combinando validação de ideias, desenvolvimento ágil e estratégias de lançamento. Nossos primeiros clientes começaram a ver resultados impressionantes.',
                        isMobile: isMobile,
                      ),
                      const SizedBox(height: 64),
                      _buildStorySection(
                        year: '2022',
                        title: 'Expansão',
                        description: 'Expandimos nossa equipe e aperfeiçoamos nossos processos. Começamos a atender clientes em todo o Brasil, ajudando dezenas de empreendedores a realizar seus sonhos.',
                        isMobile: isMobile,
                      ),
                      const SizedBox(height: 64),
                      _buildStorySection(
                        year: '2023',
                        title: 'Inovação Contínua',
                        description: 'Lançamos novas soluções e ferramentas para tornar o processo ainda mais eficiente. Nossa comunidade de empreendedores cresceu e se fortaleceu.',
                        isMobile: isMobile,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Valores
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 60 : 100,
              ),
              color: AppColors.primary,
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Nossos Valores',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 28 : 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 64),
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildValueCard(
                            icon: Icons.speed,
                            title: 'Agilidade',
                            description: 'Acreditamos que rapidez e eficiência são essenciais para o sucesso.',
                            isMobile: isMobile,
                          ),
                          _buildValueCard(
                            icon: Icons.lightbulb,
                            title: 'Inovação',
                            description: 'Buscamos constantemente novas soluções e abordagens criativas.',
                            isMobile: isMobile,
                          ),
                          _buildValueCard(
                            icon: Icons.handshake,
                            title: 'Compromisso',
                            description: 'Dedicação total ao sucesso de nossos clientes.',
                            isMobile: isMobile,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // CTA
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 60 : 100,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1A1A1A),
                    Color(0xFF0A0A0A),
                  ],
                ),
              ),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Faça parte dessa história',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 28 : 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Junte-se a nós e transforme sua ideia em um negócio digital de sucesso.',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 16 : 18,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      StripeButton(
                        text: 'Começar agora',
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        isSecondary: true,
                        width: isMobile ? double.infinity : 250,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStorySection({
    required String year,
    required String title,
    required String description,
    required bool isMobile,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMobile) ...[
          Container(
            width: 100,
            child: Text(
              year,
              style: GoogleFonts.poppins(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: AppColors.secondary,
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isMobile)
                Text(
                  year,
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
              if (isMobile) const SizedBox(height: 16),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 24 : 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: GoogleFonts.poppins(
                  fontSize: isMobile ? 16 : 18,
                  color: Colors.white70,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildValueCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isMobile,
  }) {
    return Container(
      width: isMobile ? double.infinity : 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.secondary,
              size: 30,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
} 