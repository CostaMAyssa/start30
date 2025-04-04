import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/widgets.dart';

/// Tela de perfil do usuário
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Simular etapas do projeto
  final List<ProjectStage> _stages = [
    ProjectStage(
      title: 'Validação da Ideia',
      description: 'Análise de mercado e validação do conceito',
      progress: 100,
      status: 'Concluído',
      date: '10/03/2024',
    ),
    ProjectStage(
      title: 'Definição de Requisitos',
      description: 'Levantamento de funcionalidades e escopo técnico',
      progress: 85,
      status: 'Em andamento',
      date: '18/03/2024',
    ),
    ProjectStage(
      title: 'Design de Interface',
      description: 'Criação de wireframes e protótipos de alta fidelidade',
      progress: 40,
      status: 'Em andamento',
      date: '25/03/2024',
    ),
    ProjectStage(
      title: 'Desenvolvimento',
      description: 'Codificação e implementação das funcionalidades',
      progress: 0,
      status: 'Pendente',
      date: '05/04/2024',
    ),
    ProjectStage(
      title: 'Testes',
      description: 'Testes de usabilidade e qualidade',
      progress: 0,
      status: 'Pendente',
      date: '20/04/2024',
    ),
    ProjectStage(
      title: 'Lançamento',
      description: 'Publicação e estratégia de marketing',
      progress: 0,
      status: 'Pendente',
      date: '30/04/2024',
    ),
  ];

  // Estatísticas do projeto
  final int _daysRemaining = 22;
  final int _tasksCompleted = 12;
  final int _totalTasks = 35;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final bool isMobile = screenSize.width < 768;
    final double horizontalPadding = isMobile ? 16 : 40;
    final double maxWidth = 1200.0;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          'Dashboard do Projeto',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white70),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout_outlined, color: Colors.white70),
            onPressed: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Elementos decorativos de fundo
          Positioned(
            top: -screenSize.height * 0.2,
            right: -screenSize.width * 0.2,
            child: Container(
              width: screenSize.width * 0.6,
              height: screenSize.width * 0.6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.secondary.withOpacity(0.15),
                    AppColors.secondary.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
          
          Positioned(
            bottom: -screenSize.height * 0.15,
            left: -screenSize.width * 0.15,
            child: Container(
              width: screenSize.width * 0.5,
              height: screenSize.width * 0.5,
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
          
          // Linhas decorativas sutis
          for (int i = 0; i < 5; i++)
            Positioned(
              top: screenSize.height * (i * 0.2),
              left: 0,
              right: 0,
              child: Container(
                height: 1,
                color: Colors.white.withOpacity(0.03),
              ),
            ),
          
          // Conteúdo principal
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: isMobile ? 24 : 40,
              ),
              child: Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Informações do projeto
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Foto do projeto
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    width: isMobile ? 60 : 100,
                                    height: isMobile ? 60 : 100,
                                    color: AppColors.secondary,
                                    child: Center(
                                      child: Text(
                                        'GP',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: isMobile ? 20 : 32,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                // Detalhes do projeto
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Green Planet App',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: isMobile ? 20 : 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Aplicativo para monitoramento ambiental',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white70,
                                          fontSize: isMobile ? 14 : 16,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'Status: Em desenvolvimento',
                                        style: GoogleFonts.poppins(
                                          color: AppColors.secondary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: isMobile ? 14 : 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            // Progresso geral
                            Text(
                              'Progresso Geral: 42%',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: 0.42,
                                minHeight: 10,
                                backgroundColor: Colors.white.withOpacity(0.1),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Estatísticas
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _buildStatCard(
                            isMobile: isMobile,
                            icon: Icons.calendar_today,
                            title: '$_daysRemaining',
                            subtitle: 'Dias Restantes',
                            color: const Color(0xFF2E90FA),
                          ),
                          _buildStatCard(
                            isMobile: isMobile,
                            icon: Icons.check_circle_outline,
                            title: '$_tasksCompleted/$_totalTasks',
                            subtitle: 'Tarefas Concluídas',
                            color: const Color(0xFF00BA88),
                          ),
                          _buildStatCard(
                            isMobile: isMobile,
                            icon: Icons.schedule,
                            title: '2',
                            subtitle: 'Reuniões Agendadas',
                            color: AppColors.secondary,
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Etapas do projeto
                      Text(
                        'Acompanhamento do Desenvolvimento',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: isMobile ? 18 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _stages.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          return _buildStageCard(_stages[index], isMobile);
                        },
                      ),
                      
                      const SizedBox(height: 32),
                      
                      // Contato do Gerente de Projeto
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Seu Gerente de Projeto',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 24,
                                  backgroundColor: AppColors.secondary.withOpacity(0.2),
                                  child: Text(
                                    'AF',
                                    style: GoogleFonts.poppins(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Amanda Ferreira',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'amanda@start30.com',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.chat_outlined, size: 18),
                                  label: const Text('Conversar'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.secondary,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required bool isMobile,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      width: isMobile ? double.infinity : 240,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStageCard(ProjectStage stage, bool isMobile) {
    Color statusColor;
    
    if (stage.status == 'Concluído') {
      statusColor = AppColors.success;
    } else if (stage.status == 'Em andamento') {
      statusColor = AppColors.secondary;
    } else {
      statusColor = Colors.white70;
    }
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stage.title,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      stage.description,
                      style: GoogleFonts.poppins(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isMobile) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    stage.status,
                    style: GoogleFonts.poppins(
                      color: statusColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ],
          ),
          if (isMobile) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                stage.status,
                style: GoogleFonts.poppins(
                  color: statusColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: stage.progress / 100,
                    minHeight: 10,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      stage.progress == 100 ? AppColors.success : AppColors.secondary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text(
                '${stage.progress}%',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.white70),
              const SizedBox(width: 8),
              Text(
                stage.date,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProjectStage {
  final String title;
  final String description;
  final int progress;
  final String status;
  final String date;

  ProjectStage({
    required this.title,
    required this.description,
    required this.progress,
    required this.status,
    required this.date,
  });
} 