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
    
    return Scaffold(
      backgroundColor: const Color(0xFF080808),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.8),
                Colors.black.withOpacity(0.0),
              ],
            ),
          ),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.secondary,
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                color: AppColors.secondary,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              'CodeGrana',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [
                      AppColors.secondary,
                      AppColors.secondary.withOpacity(0.8),
                    ],
                  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Seção Hero
            Container(
              width: double.infinity,
              height: isMobile ? screenSize.height * 0.4 : screenSize.height * 0.4,
              decoration: BoxDecoration(
                color: const Color(0xFF080808),
              ),
              child: Stack(
                children: [
                  // Elementos decorativos
                  Positioned(
                    top: -50,
                    right: -50,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.secondary.withOpacity(0.1),
                            Colors.transparent,
                          ],
                          stops: const [0.2, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: isMobile ? 60 : 100,
                    left: -80,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppColors.secondary.withOpacity(0.08),
                            Colors.transparent,
                          ],
                          stops: const [0.2, 1.0],
                        ),
                      ),
                    ),
                  ),
                  // Padrão de pontos para dar textura
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.4,
                      child: CustomPaint(
                        painter: _DotPatternPainter(
                          dotColor: Colors.white.withOpacity(0.15),
                          dotSize: 1,
                          spacing: 20,
                        ),
                      ),
                    ),
                  ),
                  // Conteúdo principal
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 24 : screenSize.width * 0.1,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        // Texto destacado elegante
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
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
                            'COLEÇÃO PREMIUM',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.2,
                              color: AppColors.secondary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Título principal com efeito laranja
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [
                              AppColors.secondary,
                              AppColors.secondary.withOpacity(0.8),
                              AppColors.secondary,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Text(
                            'Negócios prontos\npara decolar.',
                            style: GoogleFonts.poppins(
                              fontSize: isMobile ? 28 : 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 1.1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          width: isMobile ? double.infinity : screenSize.width * 0.5,
                          child: Text(
                            'O CodeGrana é a loja oficial de produtos digitais da Start30. Aqui você encontra soluções prontas, validadas e com código-fonte liberado.',
                            style: GoogleFonts.poppins(
                              fontSize: isMobile ? 14 : 16,
                              color: Colors.white.withOpacity(0.8),
                              height: 1.5,
                              letterSpacing: 0.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Seção de busca
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : screenSize.width * 0.1,
                vertical: 40,
              ),
              margin: const EdgeInsets.only(top: 0),
              decoration: BoxDecoration(
                color: const Color(0xFF080808),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título da seção de busca
                  Text(
                    'Busca Inteligente',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Campo de busca refinado
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A0A0A),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFF2A2A2A)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.white.withOpacity(0.6),
                            size: 18,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              cursorColor: AppColors.secondary,
                              decoration: InputDecoration(
                                hintText: 'Buscar produtos...',
                                hintStyle: GoogleFonts.inter(
                                  color: Colors.white.withOpacity(0.4),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(vertical: 14),
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
                                size: 16,
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    category,
                                    style: GoogleFonts.inter(
                                      color: isSelected ? Colors.black : Colors.white,
                                      fontSize: 13,
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    technology,
                                    style: GoogleFonts.inter(
                                      color: isSelected ? Colors.black : Colors.white,
                                      fontSize: 13,
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
              key: _productsKey,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : screenSize.width * 0.1,
                vertical: 60,
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
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
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
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Soluções selecionadas a dedo para impulsionar seu negócio',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.7),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // Grid de produtos
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: isMobile ? 1 : 3,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: isMobile ? 0.8 : 0.7,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return _buildProductCard(product);
                    },
                  ),
                ],
              ),
            ),
            
            // Seção Como Funciona
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 24 : screenSize.width * 0.1,
                vertical: 40,
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
                horizontal: isMobile ? 24 : screenSize.width * 0.1,
                vertical: 40,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Como Funciona o CodeGrana',
                    style: GoogleFonts.poppins(
                      fontSize: 24,
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

  // Widget para card de produto
  Widget _buildProductCard(Product product) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF151515),
            const Color(0xFF0A0A0A),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem premium com overlay gradiente
            Stack(
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    image: DecorationImage(
                      image: AssetImage('assets/images/placeholder_dark.jpg'),
                      fit: BoxFit.cover,
                      opacity: 0.7,
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                        stops: const [0.6, 1.0],
                      ),
                    ),
                  ),
                ),
                // Ícone central
                Positioned.fill(
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.secondary.withOpacity(0.4),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.secondary.withOpacity(0.2),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.code,
                        size: 32,
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ),
                // Tag da categoria
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: AppColors.secondary.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.sell,
                          color: AppColors.secondary,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          product.category,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Tag de tecnologia
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Text(
                      product.technology,
                      style: GoogleFonts.poppins(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nome do produto
                    Text(
                      product.name,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    // Descrição
                    Text(
                      product.description,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.7),
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    // Preço e botões de ação
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Preço com formatação premium
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.secondary.withOpacity(0.1),
                                Colors.transparent,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Text(
                            'R\$ ${product.price.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..shader = LinearGradient(
                                  colors: [
                                    AppColors.secondary,
                                    AppColors.secondary.withOpacity(0.8),
                                  ],
                                ).createShader(const Rect.fromLTWH(0.0, 0.0, 120.0, 30.0)),
                            ),
                          ),
                        ),
                        // Botão de compra premium
                        Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.secondary,
                                AppColors.secondary.withOpacity(0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.secondary.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                // Lógica de compra
                              },
                              borderRadius: BorderRadius.circular(18),
                              child: Center(
                                child: Icon(
                                  Icons.shopping_cart,
                                  color: Colors.black,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Botão Ver detalhes
                    SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: OutlinedButton(
                        onPressed: () {
                          // Lógica para ver detalhes
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: AppColors.secondary.withOpacity(0.3),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Ver detalhes',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
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
    );
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
} 