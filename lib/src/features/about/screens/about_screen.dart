import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section com paralaxe sutil
            Container(
              width: double.infinity,
              height: screenSize.height * 0.6,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF111111),
                    const Color(0xFF000000),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Elementos decorativos (círculos gradiente)
                  Positioned(
                    top: -100,
                    right: -100,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.secondary.withOpacity(0.3),
                            AppColors.secondary.withOpacity(0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -120,
                    left: -80,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withOpacity(0.03),
                            Colors.white.withOpacity(0),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Conteúdo principal
                  Center(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Nossa História',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: isMobile ? 40 : 72,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.1,
                              letterSpacing: -1,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            constraints: BoxConstraints(maxWidth: 800),
                            child: Text(
                              'Conheça a jornada que nos trouxe até aqui e nossa missão de transformar ideias em negócios digitais de sucesso.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 16 : 20,
                                color: Colors.white.withOpacity(0.8),
                                height: 1.5,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // História com cards em estilo glassmorphism
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 80 : 120,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF0A0A0A),
                    AppColors.primary,
                  ],
                ),
              ),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildJourneyStage(
                        stage: 'Origem',
                        title: 'A Visão',
                        description: 'A Start30 nasceu da paixão por empreendedorismo da fundadora Mayssa, que ainda aos 16 anos já trabalhava na gestão do ambiente escolar de sua mãe. Aos 23 anos, ela identificou uma necessidade clara: muitos empreendedores têm ideias brilhantes, mas enfrentam inúmeras barreiras técnicas e estratégicas para concretizá-las no mundo digital.',
                        icon: Icons.lightbulb_outline,
                        isMobile: isMobile,
                      ),
                      
                      if (!isMobile) _buildConnector(),
                      
                      _buildJourneyStage(
                        stage: 'Metodologia',
                        title: 'O Método Revolucionário',
                        description: 'Desenvolvemos uma abordagem revolucionária que vai além de simplesmente entregar software. Nosso método único combina treinamento, consultoria e desenvolvimento, permitindo que empreendedores validem suas ideias, construam um modelo de negócio disruptivo e lancem um produto digital completo em apenas 30 dias.',
                        icon: Icons.speed,
                        isMobile: isMobile,
                        isReversed: !isMobile,
                      ),
                      
                      if (!isMobile) _buildConnector(),
                      
                      _buildJourneyStage(
                        stage: 'Expansão',
                        title: 'Crescimento Sustentável',
                        description: 'Com uma proposta que não se limita a ser uma software house tradicional, expandimos nossa visão para entregar não apenas produtos digitais, mas também formar empreendedores com mentalidade digital. Fornecemos todo o conhecimento necessário junto com um sistema de software funcional e validado para o mercado.',
                        icon: Icons.trending_up,
                        isMobile: isMobile,
                      ),
                      
                      if (!isMobile) _buildConnector(),
                      
                      _buildJourneyStage(
                        stage: 'Inovação',
                        title: 'Evolução Constante',
                        description: 'Hoje, continuamos a aprimorar nossa metodologia, focando em democratizar o acesso à tecnologia e ao empreendedorismo digital. Nossa missão é permitir que pessoas com grandes ideias, independentemente de seu conhecimento técnico, possam transformá-las em negócios digitais de sucesso.',
                        icon: Icons.rocket_launch,
                        isMobile: isMobile,
                        isReversed: !isMobile,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Valores em cards com gradiente
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 80 : 120,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary,
                    const Color(0xFF0A0A0A),
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
                        'Nossos Valores Fundamentais',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 32 : 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        constraints: BoxConstraints(maxWidth: 700),
                        child: Text(
                          'Valores que norteiam cada aspecto de nosso trabalho e definem quem somos',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 16 : 18,
                            color: Colors.white.withOpacity(0.7),
                            height: 1.5,
                          ),
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
                            description: 'Acreditamos que rapidez e eficiência são essenciais para validar ideias e permitir que empreendedores vejam resultados concretos rapidamente.',
                            isMobile: isMobile,
                            gradientColors: [
                              const Color(0xFF2E90FA),
                              const Color(0xFF1F6AB7),
                            ],
                          ),
                          _buildValueCard(
                            icon: Icons.lightbulb,
                            title: 'Democratização',
                            description: 'Trabalhamos para que o acesso ao empreendedorismo digital seja possível para todos, contribuindo para um mundo com mais igualdade de oportunidades.',
                            isMobile: isMobile,
                            gradientColors: [
                              AppColors.secondary,
                              AppColors.secondary.withOpacity(0.7),
                            ],
                          ),
                          _buildValueCard(
                            icon: Icons.handshake,
                            title: 'Compromisso Total',
                            description: 'Dedicação completa ao sucesso de nossos clientes, ajudando empreendedores que começam do zero a alcançarem seus objetivos e realizarem seu potencial.',
                            isMobile: isMobile,
                            gradientColors: [
                              const Color(0xFF00BA88),
                              const Color(0xFF00856B),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // CTA com design moderno
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 80 : 120,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF0A0A0A),
                    const Color(0xFF111111),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: isMobile ? double.infinity : 800),
                      padding: const EdgeInsets.all(48),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.05),
                            Colors.white.withOpacity(0.02),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Faça parte dessa história',
                            style: GoogleFonts.poppins(
                              fontSize: isMobile ? 28 : 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            constraints: BoxConstraints(maxWidth: 600),
                            child: Text(
                              'Estamos construindo um futuro onde qualquer pessoa com uma ideia brilhante pode transformá-la em um negócio digital de sucesso. Venha fazer parte dessa transformação.',
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 16 : 18,
                                color: Colors.white.withOpacity(0.8),
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 40),
                          StripeButton(
                            text: 'Iniciar minha jornada',
                            onPressed: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            isSecondary: true,
                            width: isMobile ? double.infinity : 300,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Conector visual entre as etapas (apenas para desktop)
  Widget _buildConnector() {
    return Container(
      margin: const EdgeInsets.only(left: 35),
      width: 2,
      height: 60,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.secondary.withOpacity(0.7),
            AppColors.secondary.withOpacity(0.3),
          ],
        ),
      ),
    );
  }

  // Card para cada etapa da jornada
  Widget _buildJourneyStage({
    required String stage,
    required String title,
    required String description,
    required IconData icon,
    required bool isMobile,
    bool isReversed = false,
  }) {
    final stageCard = Container(
      margin: EdgeInsets.only(bottom: isMobile ? 40 : 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: -5,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.secondary,
                        AppColors.secondary.withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.secondary.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: -5,
                      ),
                    ],
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          stage,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        description,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Para layout desktop, permite alternar o lado do ícone
    if (!isMobile && isReversed) {
      return Row(
        children: [
          const Spacer(),
          Container(
            width: 600,
            child: stageCard,
          ),
        ],
      );
    }

    return isMobile
        ? stageCard
        : Row(
            children: [
              Container(
                width: 600,
                child: stageCard,
              ),
              const Spacer(),
            ],
          );
  }

  // Card para valores
  Widget _buildValueCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isMobile,
    required List<Color> gradientColors,
  }) {
    return Container(
      width: isMobile ? double.infinity : 330,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.05),
            Colors.white.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: gradientColors[0].withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: -5,
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Colors.white.withOpacity(0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
} 