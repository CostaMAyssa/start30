import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/widgets.dart';

// Modelo de produto para demonstração
class Product {
  final String name;
  final String category;
  final String technology;
  final String description;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.technology,
    required this.imageUrl,
  });
}

// Classe para desenhar o padrão de pontos
class _DotPatternPainter extends CustomPainter {
  final Color dotColor;
  final double dotSize;
  final double spacing;

  _DotPatternPainter({
    required this.dotColor,
    required this.dotSize,
    required this.spacing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = dotColor
      ..strokeWidth = dotSize
      ..strokeCap = StrokeCap.round;

    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(
          Offset(x, y),
          dotSize / 2,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Tela da loja CodeGrana - produtos digitais prontos para uso
class CodeGranaScreen extends StatefulWidget {
  const CodeGranaScreen({Key? key}) : super(key: key);

  @override
  State<CodeGranaScreen> createState() => _CodeGranaScreenState();
}

class _CodeGranaScreenState extends State<CodeGranaScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'Todos';
  String _selectedTechnology = 'Todos';
  final GlobalKey _productsKey = GlobalKey();
  final GlobalKey _highlightsKey = GlobalKey();

  // Lista de categorias
  final List<String> _categories = [
    'Todos',
    'Automação',
    'Clínicas',
    'E-commerce',
    'Educação',
    'Finanças',
    'Marketing',
  ];

  // Lista de tecnologias
  final List<String> _technologies = [
    'Todos',
    'Node.js',
    'Python',
    'N8N',
    'Google Sheets',
    'Flutter',
    'React',
  ];

  // Lista de produtos de demonstração
  final List<Product> _products = [
    Product(
      name: 'Bot de Agendamento',
      category: 'Automação',
      technology: 'N8N',
      description: 'Sistema automatizado para gerenciamento de agendamentos online.',
      price: 297.00,
      imageUrl: 'assets/images/products/bot_agendamento.jpg',
    ),
    Product(
      name: 'Dashboard Financeiro',
      category: 'Finanças',
      technology: 'React',
      description: 'Painel de controle completo para gestão financeira de pequenas empresas.',
      price: 497.00,
      imageUrl: 'assets/images/products/dashboard_financeiro.jpg',
    ),
    Product(
      name: 'Sistema de Clínica',
      category: 'Clínicas',
      technology: 'Flutter',
      description: 'Aplicativo completo para gestão de clínicas médicas e estéticas.',
      price: 897.00,
      imageUrl: 'assets/images/products/sistema_clinica.jpg',
    ),
    Product(
      name: 'Automação de Marketing',
      category: 'Marketing',
      technology: 'Python',
      description: 'Ferramenta para automação de campanhas de marketing em múltiplos canais.',
      price: 347.00,
      imageUrl: 'assets/images/products/automacao_marketing.jpg',
    ),
    Product(
      name: 'E-commerce Básico',
      category: 'E-commerce',
      technology: 'Node.js',
      description: 'Loja virtual pronta para personalização e lançamento rápido.',
      price: 597.00,
      imageUrl: 'assets/images/products/ecommerce_basico.jpg',
    ),
    Product(
      name: 'Plataforma EAD',
      category: 'Educação',
      technology: 'React',
      description: 'Sistema completo para cursos online com área de membros.',
      price: 797.00,
      imageUrl: 'assets/images/products/plataforma_ead.jpg',
    ),
  ];

  // Filtra os produtos com base nos critérios selecionados
  List<Product> get filteredProducts {
    return _products.where((product) {
      // Filtro por categoria
      bool matchesCategory = _selectedCategory == 'Todos' || 
                             product.category == _selectedCategory;
      
      // Filtro por tecnologia
      bool matchesTechnology = _selectedTechnology == 'Todos' || 
                              product.technology == _selectedTechnology;
      
      // Filtro por termo de busca
      bool matchesSearch = _searchController.text.isEmpty || 
                          product.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
                          product.description.toLowerCase().contains(_searchController.text.toLowerCase());
      
      return matchesCategory && matchesTechnology && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;
    final double horizontalPadding = isMobile ? 24 : 80;
    final double maxWidth = 1200.0;
    
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        toolbarHeight: isMobile ? 60 : 70,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
            _buildNavButton(
              context: context,
              label: 'Início',
              onPressed: () => Navigator.pushNamed(context, '/'),
            ),
            _buildNavButton(
              context: context,
              label: 'Como funciona',
              onPressed: () => Navigator.pushNamed(context, '/'),
            ),
            _buildNavButton(
              context: context,
              label: 'Sobre nós',
              onPressed: () => Navigator.pushNamed(context, '/about'),
            ),
            _buildNavButton(
              context: context,
              label: 'Entrar',
              onPressed: () => Navigator.pushNamed(context, '/login'),
            ),
            const SizedBox(width: 16),
            Padding(
              padding: const EdgeInsets.only(right: 24),
              child: _buildActionButton(
                context: context,
                label: 'Começar',
                onPressed: () => Navigator.pushNamed(context, '/idea_form'),
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
      ),
      drawer: isMobile ? _buildDrawer(context) : null,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              height: isMobile ? screenSize.height * 0.8 : screenSize.height * 0.7,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 40,
                vertical: isMobile ? 24 : 0,
              ),
              margin: EdgeInsets.only(top: isMobile ? kToolbarHeight + 16 : 0),
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
                      width: isMobile ? 200 : 500,
                      height: isMobile ? 200 : 500,
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
                      width: isMobile ? 250 : 450,
                      height: isMobile ? 250 : 450,
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
                  Positioned.fill(
                    child: Padding(
                      padding: EdgeInsets.only(top: isMobile ? 24 : 0),
                      child: Center(
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Container(
                            constraints: BoxConstraints(maxWidth: maxWidth),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Subtítulo com refinamento tipográfico
                                
                                Text(
                                  'ECONOMIZE TEMPO E DINHEIRO',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    fontSize: isMobile ? 11 : 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withOpacity(0.75),
                                    letterSpacing: isMobile ? 1.0 : 2.0,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                
                                // Título principal com tipografia mais elegante
                                Text(
                                  'CÓDIGOS PRONTOS PARA\nACELERAR SEU NEGÓCIO',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.montserrat(
                                    fontSize: isMobile ? 26 : 56,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    height: 1.15,
                                    letterSpacing: isMobile ? 0 : -0.5,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: isMobile ? 16 : 24),
                                
                                // Badge de serviços mais sutil
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 16 : 32, 
                                    vertical: isMobile ? 8 : 16
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
                                    'Produtos digitais com código-fonte liberado',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                      fontSize: isMobile ? 12 : 18,
                                      color: Colors.white.withOpacity(0.9),
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                                SizedBox(height: isMobile ? 16 : 24),
                                
                                // Descrição adicional refinada
                                Container(
                                  width: isMobile ? double.infinity : maxWidth * 0.7,
                                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 0),
                                  child: Text(
                                    'Adquira soluções digitais completas e personalizáveis. Economize meses de desenvolvimento e milhares de reais em investimento.',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.montserrat(
                                      fontSize: isMobile ? 14 : 20,
                                      color: Colors.white.withOpacity(0.7),
                                      height: 1.6,
                                      letterSpacing: 0.1,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                SizedBox(height: isMobile ? 24 : 40),
                                
                                // Botão para ver produtos
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Rolar para a seção de produtos
                                      Scrollable.ensureVisible(
                                        _productsKey.currentContext!,
                                        duration: const Duration(milliseconds: 800),
                                        curve: Curves.easeInOut,
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: isMobile ? 24 : 32,
                                        vertical: isMobile ? 16 : 20,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      elevation: 5,
                                    ),
                                    child: Text(
                                      'CONHEÇA NOSSOS PRODUTOS',
                                      style: GoogleFonts.montserrat(
                                        fontSize: isMobile ? 14 : 16,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ),
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
            
            // Banner de diferenciais
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 24 : 32,
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
                  child: isMobile 
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.code,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          Text(
                            'Economize até 90% do tempo e custo de desenvolvimento com nossos códigos prontos.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.code,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Flexible(
                            child: Text(
                              'Economize até 90% do tempo e custo de desenvolvimento com nossos códigos prontos.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                fontSize: 18,
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
            
            // Filtros e Barra de Busca
            Container(
              key: _productsKey,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 40 : 60,
              ),
              color: const Color(0xFF080808),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título da seção de busca
                  Text(
                    'Busca Inteligente',
                    style: GoogleFonts.inter(
                      fontSize: isMobile ? 18 : 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: isMobile ? 16 : 24),
                  // Campo de busca refinado
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A0A0A),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF2A2A2A)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 12 : 16, 
                        vertical: isMobile ? 2 : 4
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.white.withOpacity(0.6),
                            size: isMobile ? 16 : 18,
                          ),
                          SizedBox(width: isMobile ? 8 : 12),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: isMobile ? 12 : 13,
                                fontWeight: FontWeight.w400,
                              ),
                              cursorColor: AppColors.secondary,
                              decoration: InputDecoration(
                                hintText: 'Buscar produtos...',
                                hintStyle: GoogleFonts.inter(
                                  color: Colors.white.withOpacity(0.4),
                                  fontSize: isMobile ? 12 : 13,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: isMobile ? 12 : 14
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {});
                              },
                            ),
                          ),
                          if (_searchController.text.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _searchController.clear();
                                });
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.white.withOpacity(0.6),
                                size: isMobile ? 14 : 16,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Título da seção de categorias
                  Row(
                    children: [
                      Text(
                        'Categoria',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.7),
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Chips de categoria com design mais premium
                  Container(
                    height: 44,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _categories.map((category) {
                        final isSelected = _selectedCategory == category;
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.secondary : const Color(0xFF151515),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected 
                                    ? AppColors.secondary 
                                    : const Color(0xFF2A2A2A),
                                width: 1,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedCategory = category == _selectedCategory ? 'Todos' : category;
                                  });
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 12 : 16,
                                    vertical: isMobile ? 8 : 12,
                                  ),
                                  child: Text(
                                    category,
                                    style: GoogleFonts.inter(
                                      color: isSelected ? Colors.black : Colors.white,
                                      fontSize: isMobile ? 11 : 13,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Título da seção de tecnologias
                  Row(
                    children: [
                      Text(
                        'Tecnologia',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.7),
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Chips de tecnologia com design mais premium
                  Container(
                    height: 44,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _technologies.map((technology) {
                        final isSelected = _selectedTechnology == technology;
                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.secondary : const Color(0xFF151515),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected 
                                    ? AppColors.secondary 
                                    : const Color(0xFF2A2A2A),
                                width: 1,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedTechnology = technology == _selectedTechnology ? 'Todos' : technology;
                                  });
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 12 : 16,
                                    vertical: isMobile ? 8 : 12,
                                  ),
                                  child: Text(
                                    technology,
                                    style: GoogleFonts.inter(
                                      color: isSelected ? Colors.black : Colors.white,
                                      fontSize: isMobile ? 11 : 13,
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            
            // Seção de Destaques da Semana
            Container(
              key: _highlightsKey,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : screenSize.width * 0.1,
                vertical: isMobile ? 40 : 60,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF080808),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        width: 3,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              AppColors.secondary,
                              AppColors.secondary.withOpacity(0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Destaques da Semana',
                        style: GoogleFonts.inter(
                          fontSize: isMobile ? 18 : 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 8 : 10,
                          vertical: isMobile ? 3 : 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: AppColors.secondary.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          'PREMIUM',
                          style: GoogleFonts.inter(
                            color: AppColors.secondary,
                            fontSize: isMobile ? 8 : 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: isMobile ? 16 : 20),
                  Text(
                    'Soluções selecionadas a dedo para impulsionar seu negócio',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 14 : 16,
                      color: Colors.white.withOpacity(0.7),
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: isMobile ? 30 : 40),
                  // Grid de produtos
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 1 : screenSize.width < 1100 ? 2 : 3,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: isMobile
                          ? 0.75
                          : screenSize.width < 1100
                              ? 0.7
                              : 0.7,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return _buildProductCard(product, isMobile);
                    },
                  ),
                ],
              ),
            ),
            
            // Seção Como Funciona
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : screenSize.width * 0.1,
                vertical: isMobile ? 30 : 40,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF080808),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              margin: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : screenSize.width * 0.1,
                vertical: isMobile ? 30 : 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Como Funciona o CodeGrana',
                    style: GoogleFonts.poppins(
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Cada negócio à venda aqui é um projeto pronto, com documentação e arquivos completos para você começar a usar agora mesmo. Você recebe acesso ao código-fonte e suporte para integração básica.',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.85),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            
            // Rodapé
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : screenSize.width * 0.1,
                vertical: 60,
              ),
              color: const Color(0xFF080808),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: isMobile 
                        ? MainAxisAlignment.center 
                        : MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isMobile)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CodeGrana',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Negócios prontos para decolar',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Links Úteis',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildFooterLink('Sobre a Start30'),
                          _buildFooterLink('Outros produtos'),
                          _buildFooterLink('Contato / Suporte'),
                          _buildFooterLink('FAQ'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Divider(color: Colors.white.withOpacity(0.1)),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      '© 2024 Start30. Todos os direitos reservados.',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para cartão de produto com efeito glassmorphism
  Widget _buildProductCard(Product product, bool isMobile) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          width: isMobile ? double.infinity : 360,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagem do produto
              Container(
                height: isMobile ? 160 : 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Center(
                  child: Icon(
                    _getCategoryIcon(product.category),
                    size: isMobile ? 60 : 80,
                    color: AppColors.secondary.withOpacity(0.7),
                  ),
                ),
              ),
              
              Padding(
                padding: EdgeInsets.all(isMobile ? 16 : 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tag da categoria
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 10 : 12, 
                        vertical: isMobile ? 4 : 6
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.secondary.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        product.category,
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 12 : 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 12 : 16),
                    
                    // Nome do produto
                    Text(
                      product.name,
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 18 : 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: isMobile ? 6 : 8),
                    
                    // Tag de tecnologia
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        product.technology,
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 10 : 12,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 12 : 16),
                    
                    // Descrição
                    Text(
                      product.description,
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 13 : 15,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: isMobile ? 16 : 24),
                    
                    const Divider(color: Colors.white10),
                    SizedBox(height: isMobile ? 16 : 24),
                    
                    // Preço e Botão
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Preço',
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 12 : 14,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              'R\$ ${product.price.toStringAsFixed(2)}',
                              style: GoogleFonts.poppins(
                                fontSize: isMobile ? 20 : 24,
                                fontWeight: FontWeight.bold,
                                color: AppColors.secondary,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Ação para o botão de compra
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: isMobile ? 14 : 20, 
                              vertical: isMobile ? 10 : 12
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Ver detalhes',
                            style: GoogleFonts.poppins(
                              fontSize: isMobile ? 12 : 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
  
  // Função auxiliar para escolher ícone baseado na categoria
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Automação':
        return Icons.auto_fix_high;
      case 'Clínicas':
        return Icons.medical_services;
      case 'E-commerce':
        return Icons.shopping_cart;
      case 'Educação':
        return Icons.school;
      case 'Finanças':
        return Icons.attach_money;
      case 'Marketing':
        return Icons.trending_up;
      default:
        return Icons.code;
    }
  }

  // Widget para links do rodapé
  Widget _buildFooterLink(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          // Ação do link
        },
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  // Widget para botão de navegação no AppBar com design moderno
  Widget _buildNavButton({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
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
  Widget _buildActionButton({
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
                    const Color(0xFF111111),
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
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                  // Item CodeGrana com destaque especial
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.secondary.withOpacity(0.5), width: 1),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        splashColor: AppColors.secondary.withOpacity(0.2),
                        highlightColor: AppColors.secondary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.white,
                                size: 24,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                'CodeGrana',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  _buildDrawerItem(
                    context: context,
                    icon: Icons.lightbulb_outline,
                    label: 'Como funciona',
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/');
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
                          Navigator.pushNamed(context, '/idea_form');
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
} 