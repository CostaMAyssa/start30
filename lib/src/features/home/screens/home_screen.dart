import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/widgets.dart';
import 'dart:async';

/// Tela inicial do aplicativo
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Definição da fonte padrão para todo o sistema
  final TextTheme textTheme = GoogleFonts.montserratTextTheme().copyWith(
    displayLarge: GoogleFonts.montserrat(
      fontWeight: FontWeight.bold,
    ),
    displayMedium: GoogleFonts.montserrat(
      fontWeight: FontWeight.bold,
    ),
    displaySmall: GoogleFonts.montserrat(
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: GoogleFonts.montserrat(
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: GoogleFonts.montserrat(
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: GoogleFonts.montserrat(
      fontWeight: FontWeight.w600,
    ),
    titleLarge: GoogleFonts.montserrat(
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.montserrat(
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.montserrat(
      fontWeight: FontWeight.w500,
    ),
    bodyLarge: GoogleFonts.montserrat(),
    bodyMedium: GoogleFonts.montserrat(),
    bodySmall: GoogleFonts.montserrat(),
  );

  // Chave para a seção "Como funciona"
  final GlobalKey _howItWorksKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _ctaKey = GlobalKey();

  void _scrollToSection(BuildContext context, GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Obtém o tamanho da tela para responsividade
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;
    final bool isTablet = screenSize.width >= 768 && screenSize.width < 1024;
    final double horizontalPadding = isMobile ? 24 : 80;
    final double maxWidth = 1200.0;
    
    // Aplica o tema de texto personalizado
    Theme.of(context).textTheme.merge(textTheme);

    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      extendBodyBehindAppBar: true,
      appBar: _buildModernAppBar(context, isMobile),
      drawer: isMobile ? _buildDrawer(context) : null,
      floatingActionButton: _buildModernWhatsAppButton(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 40,
                vertical: isMobile ? 60 : 120,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF080808),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 15,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Elemento decorativo sutil
                  Positioned(
                    right: isMobile ? -100 : 0,
                    top: isMobile ? -50 : 50,
                    child: Container(
                      width: isMobile ? 200 : 400,
                      height: isMobile ? 200 : 400,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withOpacity(0.03),
                            Colors.transparent,
                          ],
                          radius: 0.8,
                        ),
                      ),
                    ),
                  ),
                  // Elemento decorativo sutil 2
                  Positioned(
                    left: isMobile ? -150 : -100,
                    bottom: isMobile ? -100 : -50,
                    child: Container(
                      width: isMobile ? 250 : 350,
                      height: isMobile ? 250 : 350,
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            Colors.white.withOpacity(0.02),
                            Colors.transparent,
                          ],
                          radius: 0.7,
                        ),
                      ),
                    ),
                  ),
                  // Conteúdo principal
                  isMobile
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: double.infinity,
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            padding: EdgeInsets.only(left: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Subtítulo com mais refinamento tipográfico
                                Text(
                                  'TRANSFORMANDO IDEIAS',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withOpacity(0.75),
                                    letterSpacing: 2.0,
                                  ),
                                ),
                                SizedBox(height: 20),
                                
                                // Título principal com tipografia mais elegante
                                Text(
                                  'A IDEIA QUE VOCÊ CARREGA MERECE CHEGAR AO MUNDO EM 30 DIAS',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    height: 1.2,
                                    letterSpacing: 0,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 24),
                                
                                // Badge de serviços mais sutil
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16, 
                                    vertical: 8
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.1),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    'Consultoria estratégica + desenvolvimento de software',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.9),
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16),
                                
                                // Descrição adicional refinada
                                Container(
                                  width: double.infinity,
                                  child: Text(
                                    'Chega de só imaginar. A Start30 te ajuda a transformar sua ideia em um negócio digital validado, pronto para o mercado.',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.7),
                                      height: 1.6,
                                      letterSpacing: 0.1,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 28),
                                
                                // Botão CTA mais compacto e elegante
                                Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white.withOpacity(0.03),
                                          blurRadius: 15,
                                          spreadRadius: 0,
                                          offset: const Offset(0, 4),
                                        ),
                                      ],
                                    ),
                                    width: 180,
                                    height: 48,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, '/register');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF080808),
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          side: BorderSide(
                                            color: Colors.white.withOpacity(0.8),
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Lançar sua ideia',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Center(
                          child: Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 60),
                                // Subtítulo TRANSFORME SUA IDEIA EM 30 DIAS como título principal
                                Text(
                                  'TRANSFORMANDO IDEIAS',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withOpacity(0.75),
                                    letterSpacing: 2.0,
                                  ),
                                ),
                                const SizedBox(height: 32),
                                
                                // Título principal em grande destaque
                                Text(
                                  'A IDEIA QUE VOCÊ CARREGA\nMERECE CHEGAR AO MUNDO\nEM 30 DIAS',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 58,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    height: 1.2,
                                    letterSpacing: -0.5,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 40),
                                
                                // Badge de serviços mais sutil
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.white.withOpacity(0.1),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    'Consultoria estratégica + desenvolvimento de software',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16,
                                      color: Colors.white.withOpacity(0.9),
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                
                                // Descrição adicional refinada
                                Container(
                                  width: maxWidth * 0.55,
                                  child: Text(
                                    'Chega de só imaginar. A Start30 te ajuda a transformar sua ideia em um negócio digital validado, pronto para o mercado.',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 17,
                                      color: Colors.white.withOpacity(0.7),
                                      height: 1.6,
                                      letterSpacing: 0.1,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40),
                                
                                // Botão CTA
                                SizedBox(
                                  width: 340,
                                  child: StripeButton(
                                    text: 'Lançar sua ideia',
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/register');
                                    },
                                    isSecondary: true,
                                    width: 340,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ],
              ),
            ),

            // Banner de diferencial de velocidade
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 18 : 32,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: -5,
                    offset: const Offset(0, -10),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: -5,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(isMobile ? 8 : 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.speed_rounded,
                          color: Colors.white,
                          size: isMobile ? 20 : 32,
                        ),
                      ),
                      SizedBox(width: isMobile ? 12 : 16),
                      Flexible(
                        child: Text(
                          'Entregamos seu negócio digital em 30 dias enquanto outros levam meses.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                            fontSize: isMobile ? 13 : 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Como funciona
            Container(
              key: _howItWorksKey,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 60 : 100,
              ),
              color: const Color(0xFF080808),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Como funciona',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 28 : 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Nosso processo em 3 etapas simples para transformar sua ideia em realidade',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 16 : 18,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 64),
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildStepCard(
                            icon: Icons.lightbulb_outline,
                            title: 'Validação',
                            description: 'Validamos sua ideia com pesquisas de mercado e definição de público-alvo.',
                            step: '01',
                            isMobile: isMobile,
                          ),
                          _buildStepCard(
                            icon: Icons.code,
                            title: 'Desenvolvimento',
                            description: 'Criamos um MVP funcional com foco nas funcionalidades essenciais.',
                            step: '02',
                            isMobile: isMobile,
                          ),
                          _buildStepCard(
                            icon: Icons.rocket_launch,
                            title: 'Lançamento',
                            description: 'Preparamos sua estratégia de lançamento e aquisição de clientes.',
                            step: '03',
                            isMobile: isMobile,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Cases de sucesso
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 60 : 100,
              ),
              color: const Color(0xFF050505),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Histórias de sucesso',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 28 : 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Empresas que transformaram suas ideias em negócios digitais de sucesso',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 16 : 18,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildCaseCard(
                            title: 'GreenMarket',
                            description: 'Marketplace sustentável que conecta produtores orgânicos a consumidores',
                            result: 'Lançamento em 28 dias e 300+ usuários no primeiro mês',
                            tag: 'E-commerce',
                            isMobile: isMobile,
                          ),
                          _buildCaseCard(
                            title: 'HealthTrack',
                            description: 'Aplicativo de monitoramento de saúde para pacientes com condições crônicas',
                            result: 'MVP validado com 50 usuários-teste e investimento de R\$500 mil',
                            tag: 'Saúde',
                            isMobile: isMobile,
                          ),
                          _buildCaseCard(
                            title: 'EduConnect',
                            description: 'Plataforma que conecta professores particulares a estudantes',
                            result: 'Faturamento de R\$30 mil no primeiro trimestre após o lançamento',
                            tag: 'Educação',
                            isMobile: isMobile,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Depoimentos
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 60 : 100,
              ),
              color: const Color(0xFF080808),
              decoration: null,
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'O que nossos clientes dizem',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 28 : 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildTestimonialCard(
                            name: 'João Silva',
                            role: 'CEO, GreenMarket',
                            testimonial: 'A Start30 transformou minha ideia em um negócio real em tempo recorde. O processo foi transparente e a equipe extremamente dedicada.',
                            isMobile: isMobile,
                          ),
                          _buildTestimonialCard(
                            name: 'Mariana Costa',
                            role: 'Fundadora, HealthTrack',
                            testimonial: 'Não imaginei que seria possível ter um MVP tão completo em apenas 30 dias. A metodologia deles realmente funciona!',
                            isMobile: isMobile,
                          ),
                          _buildTestimonialCard(
                            name: 'Carlos Mendes',
                            role: 'Fundador, EduConnect',
                            testimonial: 'A Start30 não apenas desenvolveu nosso produto, mas também nos guiou em todo o processo de validação e lançamento. Superou todas as expectativas.',
                            isMobile: isMobile,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Planos e preços
            Container(
              key: _plansKey,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 60 : 100,
              ),
              color: const Color(0xFF050505),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Nossos planos',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 28 : 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Escolha o plano ideal para transformar sua ideia em realidade',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 16 : 18,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      Wrap(
                        spacing: 24,
                        runSpacing: 24,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildPlanCard(
                            title: 'Validação',
                            price: 'R\$ 3.900',
                            description: 'Ideal para testar sua ideia no mercado',
                            features: [
                              'Análise de mercado',
                              'Definição de público-alvo',
                              'Protótipo simples',
                              'Testes com usuários reais',
                              '15 dias de duração',
                            ],
                            recommended: false,
                            isMobile: isMobile,
                          ),
                          _buildPlanCard(
                            title: 'MVP Completo',
                            price: 'R\$ 9.900',
                            description: 'Nossa solução mais popular para lançar seu produto',
                            features: [
                              'Tudo do plano Validação',
                              'MVP funcional',
                              'Identidade visual',
                              'Estratégia de lançamento',
                              '30 dias de duração',
                            ],
                            recommended: true,
                            isMobile: isMobile,
                          ),
                          _buildPlanCard(
                            title: 'Aceleração',
                            price: 'R\$ 15.900',
                            description: 'Para quem busca crescimento rápido',
                            features: [
                              'Tudo do plano MVP Completo',
                              'Estratégia de aquisição',
                              'Integração com APIs',
                              'Suporte dedicado',
                              '45 dias de duração',
                            ],
                            recommended: false,
                            isMobile: isMobile,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // FAQ
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 60 : 100,
              ),
              decoration: null,
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Perguntas frequentes',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 28 : 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      _buildFaqItem(
                        question: 'E se minha ideia ainda não estiver madura?',
                        answer: 'Sem problema! Nosso processo de validação inclui refinar sua ideia. Trabalhamos com você para desenvolvê-la antes de começar a construção do produto.',
                        isMobile: isMobile,
                      ),
                      _buildFaqItem(
                        question: 'O que acontece depois dos 30 dias?',
                        answer: 'Ao final dos 30 dias, você terá um produto funcional pronto para o mercado. Oferecemos planos de suporte contínuo e evolução para ajudar você a crescer após o lançamento.',
                        isMobile: isMobile,
                      ),
                      _buildFaqItem(
                        question: 'Posso pagar parcelado?',
                        answer: 'Sim! Oferecemos parcelamento em até 12x nos cartões de crédito ou condições personalizadas para pagamentos à vista.',
                        isMobile: isMobile,
                      ),
                      _buildFaqItem(
                        question: 'Vocês desenvolvem qualquer tipo de aplicação?',
                        answer: 'Trabalhamos com uma ampla gama de aplicações web e mobile. Durante a consulta inicial, avaliamos seu projeto para confirmar que podemos entregar com a qualidade que você merece.',
                        isMobile: isMobile,
                      ),
                      _buildFaqItem(
                        question: 'Como funciona o processo de trabalho?',
                        answer: 'Utilizamos metodologia ágil com sprints semanais. Você terá reuniões regulares com a equipe e acesso a uma plataforma para acompanhar o progresso em tempo real.',
                        isMobile: isMobile,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // CTA
            Container(
              key: _ctaKey,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 60 : 100,
              ),
              color: const Color(0xFF080808),
              decoration: null,
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Pronto para transformar\nsua ideia em realidade?',
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
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 20 : 40,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.03),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.08),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          'Comece hoje mesmo e tenha seu negócio digital funcionando em 30 dias.',
                          style: GoogleFonts.poppins(
                            fontSize: isMobile ? 15 : 17,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          textAlign: TextAlign.center,
                        ),
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

            // Footer
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 40 : 60,
              ),
              color: const Color(0xFF050505),
              decoration: null,
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    children: [
                      if (isMobile)
                        _buildMobileFooter()
                      else
                        _buildDesktopFooter(),
                      const SizedBox(height: 40),
                      const Divider(color: Colors.white10),
                      const SizedBox(height: 24),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 24,
                        runSpacing: 24,
                        children: [
                          Text(
                            '© 2024 Start30. Todos os direitos reservados.',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 14,
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildSocialIcon(Icons.public),
                              const SizedBox(width: 16),
                              _buildSocialIcon(Icons.photo_camera),
                              const SizedBox(width: 16),
                              _buildSocialIcon(Icons.business),
                            ],
                          ),
                        ],
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

  // Widget para botão de navegação no AppBar com design moderno
  Widget _buildModernNavButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white.withOpacity(0.9),
          size: 18,
        ),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w500,
            fontSize: 15,
          ),
        ),
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.08)),
          backgroundColor: MaterialStateProperty.all(Colors.white.withOpacity(0.03)),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  // Widget para botão de ação principal com design moderno
  Widget _buildModernActionButton({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 38,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondary.withOpacity(0.9),
            AppColors.secondary.withOpacity(0.7),
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white.withOpacity(0.95),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
        child: Text(label),
      ),
    );
  }

  // Botão moderno do WhatsApp
  Widget _buildModernWhatsAppButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0, right: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF25D366).withOpacity(0.25),
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () async {
          final whatsappUrl = Uri.parse('https://wa.me/5500000000000?text=Olá,%20gostaria%20de%20saber%20mais%20sobre%20o%20Start30');
          try {
            if (await url_launcher.canLaunchUrl(whatsappUrl)) {
              await url_launcher.launchUrl(whatsappUrl);
            } else {
              throw 'Não foi possível abrir o WhatsApp';
            }
          } catch (e) {
            // Em caso de erro, mostrar uma mensagem 
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Não foi possível abrir o WhatsApp. Por favor, tente novamente.'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        tooltip: 'Fale conosco pelo WhatsApp',
        backgroundColor: const Color(0xFF25D366).withOpacity(0.9),
        foregroundColor: Colors.white.withOpacity(0.95),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        child: const FaIcon(
          FontAwesomeIcons.whatsapp,
          size: 26,
        ),
      ),
    );
  }

  // Widget para o drawer mobile
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0A0A0A),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black.withOpacity(0.9),
                    Color(0xFF111111),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.secondary.withOpacity(0.9),
                          AppColors.secondary.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'S30',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Start30',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Transforme sua ideia',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.home_rounded,
                    label: 'Início',
                    onTap: () {
                      Navigator.pop(context);
                    },
                    isHighlighted: true,
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.lightbulb_outline,
                    label: 'Como funciona',
                    onTap: () {
                      Navigator.pop(context);
                      _scrollToSection(context, _howItWorksKey);
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.business_rounded,
                    label: 'Sobre nós',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/about');
                    },
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.login_rounded,
                    label: 'Entrar',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                  const Divider(
                    color: Colors.white10,
                    thickness: 1,
                    height: 40,
                    indent: 16,
                    endIndent: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, '/register');
                        },
                        icon: const Icon(Icons.rocket_launch),
                        label: const Text('Começar Agora'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF080808),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: Colors.white,
                              width: 1.5,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '© 2024 Start30',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para itens do drawer
  Widget _buildDrawerItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isHighlighted = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.secondary.withOpacity(0.1),
        highlightColor: Colors.white.withOpacity(0.05),
        child: Container(
          decoration: BoxDecoration(
            color: isHighlighted ? Colors.white.withOpacity(0.05) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isHighlighted 
                ? Border.all(color: AppColors.secondary.withOpacity(0.5), width: 1) 
                : null,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Icon(
                icon,
                color: isHighlighted ? AppColors.secondary : Colors.white70,
                size: 24,
              ),
              const SizedBox(width: 16),
              Text(
                label,
                style: TextStyle(
                  color: isHighlighted ? Colors.white : Colors.white70,
                  fontSize: 16,
                  fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para card de etapa atualizado com efeito glassmorphism
  Widget _buildStepCard({
    required IconData icon,
    required String title,
    required String description,
    required String step,
    required bool isMobile,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: isMobile ? double.infinity : 300,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text(
                    step,
                    style: GoogleFonts.poppins(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white10,
                    ),
                  ),
                ],
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
        ),
      ),
    );
  }

  // Widget para footer mobile
  Widget _buildMobileFooter() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'S30',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'Start30',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'comece rápido. alcance o sucesso',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 48,
          runSpacing: 32,
          children: [
            _buildFooterLinks(
              'Empresa',
              ['Sobre nós', 'Contato', 'Carreiras'],
            ),
            _buildFooterLinks(
              'Serviços',
              ['Planos', 'Consultoria', 'Suporte'],
            ),
            _buildFooterLinks(
              'Legal',
              ['Termos de Uso', 'Privacidade', 'Cookies'],
            ),
          ],
        ),
      ],
    );
  }

  // Widget para footer desktop
  Widget _buildDesktopFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      'S30',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Start30',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'comece rápido. alcance o sucesso',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
        _buildFooterLinks(
          'Empresa',
          ['Sobre nós', 'Contato', 'Carreiras'],
        ),
        _buildFooterLinks(
          'Serviços',
          ['Planos', 'Consultoria', 'Suporte'],
        ),
        _buildFooterLinks(
          'Legal',
          ['Termos de Uso', 'Privacidade', 'Cookies'],
        ),
      ],
    );
  }

  // Widget para links do footer
  Widget _buildFooterLinks(String title, List<String> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: GestureDetector(
            onTap: () {},
            child: Text(
              link,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
        )),
      ],
    );
  }

  // Widget para ícone de rede social
  Widget _buildSocialIcon(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white10,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  // Widget para case card
  Widget _buildCaseCard({
    required String title,
    required String description,
    required String result,
    required String tag,
    required bool isMobile,
  }) {
    return Container(
      width: isMobile ? double.infinity : 320,
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tag,
              style: GoogleFonts.poppins(
                color: AppColors.secondary,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
          const Divider(color: Colors.white10),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.check_circle_outline,
                color: AppColors.success,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  result,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Widget para card de depoimento com efeito glassmorphism
  Widget _buildTestimonialCard({
    required String name,
    required String role,
    required String testimonial,
    required bool isMobile,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: isMobile ? double.infinity : 320,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.format_quote,
                color: AppColors.secondary,
                size: 32,
              ),
              const SizedBox(height: 16),
              Text(
                testimonial,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        name.substring(0, 1),
                        style: GoogleFonts.poppins(
                          color: AppColors.secondary,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        role,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget para card de plano com efeito glassmorphism
  Widget _buildPlanCard({
    required String title,
    required String price,
    required String description,
    required List<String> features,
    required bool recommended,
    required bool isMobile,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: isMobile ? double.infinity : 320,
          decoration: BoxDecoration(
            color: recommended 
                ? Colors.black.withOpacity(0.7) 
                : Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: recommended 
                  ? AppColors.secondary.withOpacity(0.5) 
                  : Colors.white.withOpacity(0.1),
              width: recommended ? 2 : 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (recommended)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                    ),
                  ),
                  child: Text(
                    'Mais popular',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          price,
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 4),
                          child: Text(
                            'à vista',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      description,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(color: Colors.white10),
                    const SizedBox(height: 24),
                    ...features.map((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: AppColors.secondary,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              feature,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.white,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: Builder(
                        builder: (context) => ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: recommended ? AppColors.secondary : Colors.white10,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text(recommended ? 'Escolher este plano' : 'Selecionar'),
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

  // Widget para item de FAQ
  Widget _buildFaqItem({
    required String question,
    required String answer,
    required bool isMobile,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            expandedAlignment: Alignment.topLeft,
            childrenPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            iconColor: AppColors.secondary,
            collapsedIconColor: Colors.white70,
            title: Text(
              question,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            children: [
              Text(
                answer,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Chaves adicionais para as novas seções
  final GlobalKey _plansKey = GlobalKey();

  PreferredSizeWidget _buildModernAppBar(BuildContext context, bool isMobile) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      toolbarHeight: isMobile ? 60 : 70,
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.4),
                ],
              ),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.05),
                  width: 0.5,
                ),
              ),
            ),
          ),
        ),
      ),
      title: Row(
        children: [
          Container(
            width: isMobile ? 34 : 40,
            height: isMobile ? 34 : 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.secondary.withOpacity(0.9),
                  AppColors.secondary.withOpacity(0.7),
                ],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondary.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'S30',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 14 : 15,
                ),
              ),
            ),
          ),
          SizedBox(width: isMobile ? 8 : 10),
          Flexible(
            child: Text(
              'Start30',
              style: TextStyle(
                color: Colors.white.withOpacity(0.95),
                fontWeight: FontWeight.w600,
                fontSize: isMobile ? 18 : 20,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        if (!isMobile) ...[
          _buildModernNavButton(
            context: context, 
            icon: Icons.lightbulb_outline, 
            label: 'Como funciona',
            onPressed: () => _scrollToSection(context, _howItWorksKey),
          ),
          _buildModernNavButton(
            context: context, 
            icon: Icons.business, 
            label: 'Sobre nós',
            onPressed: () => Navigator.pushNamed(context, '/about'),
          ),
          _buildModernNavButton(
            context: context, 
            icon: Icons.login, 
            label: 'Entrar',
            onPressed: () => Navigator.pushNamed(context, '/login'),
          ),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: _buildModernActionButton(
              context: context,
              label: 'Começar',
              onPressed: () => Navigator.pushNamed(context, '/register'),
            ),
          ),
        ] else ...[
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            icon: const Icon(
              Icons.login_rounded,
              color: Colors.white,
              size: 24,
            ),
            tooltip: 'Entrar',
          ),
          const SizedBox(width: 8),
        ],
      ],
      leading: isMobile
          ? Builder(
              builder: (context) => IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  color: Colors.white.withOpacity(0.9),
                  size: 26,
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
                tooltip: 'Menu',
              ),
            )
          : null,
    );
  }
}

/// Painter para criar um padrão de pontos (inspirado no Stripe)
class DotPatternPainter extends CustomPainter {
  final Color dotColor;
  final double dotSize;
  final double spacing;

  DotPatternPainter({
    required this.dotColor,
    this.dotSize = 2,
    this.spacing = 20,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dotColor
      ..style = PaintingStyle.fill;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 