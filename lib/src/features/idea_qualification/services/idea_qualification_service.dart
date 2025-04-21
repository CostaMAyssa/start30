import 'package:flutter/material.dart';
import '../models/idea_qualification_model.dart';

/// Serviço responsável por processar e enviar os dados do formulário de qualificação
class IdeaQualificationService {
  /// Email para onde serão enviados os formulários de qualificação
  static const String targetEmail = 'startupstart30@gmail.com';

  /// Envia os dados do formulário para o email configurado
  /// Retorna true se o envio for bem-sucedido
  Future<bool> submitQualification(IdeaQualificationModel qualification) async {
    try {
      // Aqui seria implementada a lógica de envio real, usando
      // um serviço como Firebase, SendGrid, SMTP etc.
      
      // Para fins de demonstração, vamos simular um envio
      await Future.delayed(const Duration(seconds: 2));
      
      // Formatar os dados para o email
      final emailBody = _formatEmailBody(qualification);
      debugPrint('Enviando email para $targetEmail com os dados:');
      debugPrint(emailBody);
      
      // Retorna sucesso (em produção, verificaria a resposta da API)
      return true;
    } catch (e) {
      debugPrint('Erro ao enviar email: $e');
      return false;
    }
  }

  /// Formata os dados do formulário para envio por email
  String _formatEmailBody(IdeaQualificationModel qualification) {
    return '''
NOVA QUALIFICAÇÃO DE IDEIA - ${qualification.submissionDate}

DADOS PESSOAIS:
Nome: ${qualification.name}
Email: ${qualification.email}
Telefone: ${qualification.phone}

DETALHES DA IDEIA:
Área de Negócio: ${qualification.businessArea}
Descrição: ${qualification.ideaDescription}
Público-alvo: ${qualification.targetAudience}

RESTRIÇÕES:
Orçamento: ${qualification.budget}
Prazo desejado: ${qualification.timeline}

OBJETIVOS:
${qualification.selectedGoals.map((goal) => '- $goal').join('\n')}

---
Enviado automaticamente pelo sistema de qualificação Start30.
    ''';
  }

  /// Pontua a qualificação da ideia com base nas respostas
  /// Retorna uma pontuação de 0 a 100
  int scoreQualification(IdeaQualificationModel qualification) {
    int score = 0;
    
    // Pontua com base no preenchimento dos campos essenciais
    if (qualification.ideaDescription.length > 100) score += 20;
    if (qualification.targetAudience.isNotEmpty) score += 15;
    
    // Pontua com base no orçamento
    if (qualification.budget == 'R\$1.500 - R\$3.000') score += 15;
    if (qualification.budget == 'R\$3.000 - R\$5.000') score += 20;
    if (qualification.budget == 'Acima de R\$5.000') score += 25;
    
    // Pontua com base no prazo
    if (qualification.timeline == '1-2 meses') score += 20;
    if (qualification.timeline == '2-3 meses') score += 15;
    
    // Pontua com base nos objetivos selecionados
    if (qualification.selectedGoals.contains('Validar ideia de negócio')) score += 10;
    if (qualification.selectedGoals.contains('Lançar produto/serviço no mercado')) score += 10;
    
    return score;
  }
} 