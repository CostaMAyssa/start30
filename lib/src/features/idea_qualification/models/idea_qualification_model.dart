/// Modelo para armazenar os dados do formulário de qualificação de ideias
class IdeaQualificationModel {
  final String name;
  final String email;
  final String phone;
  final String businessArea;
  final String ideaDescription;
  final String targetAudience;
  final String budget;
  final String timeline;
  final List<String> selectedGoals;
  final DateTime submissionDate;

  IdeaQualificationModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.businessArea,
    required this.ideaDescription,
    required this.targetAudience,
    required this.budget,
    required this.timeline,
    required this.selectedGoals,
    required this.submissionDate,
  });

  /// Converter o modelo para JSON para envio por email ou API
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'businessArea': businessArea,
      'ideaDescription': ideaDescription,
      'targetAudience': targetAudience,
      'budget': budget,
      'timeline': timeline,
      'selectedGoals': selectedGoals,
      'submissionDate': submissionDate.toIso8601String(),
    };
  }

  /// Método para criar um modelo a partir de um mapa JSON
  factory IdeaQualificationModel.fromJson(Map<String, dynamic> json) {
    return IdeaQualificationModel(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      businessArea: json['businessArea'] as String,
      ideaDescription: json['ideaDescription'] as String,
      targetAudience: json['targetAudience'] as String,
      budget: json['budget'] as String,
      timeline: json['timeline'] as String,
      selectedGoals: List<String>.from(json['selectedGoals']),
      submissionDate: DateTime.parse(json['submissionDate'] as String),
    );
  }
} 