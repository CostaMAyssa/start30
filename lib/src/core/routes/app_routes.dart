import 'package:flutter/material.dart';
import '../../features/auth/screens/screens.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/plans/screens/plans_screen.dart';
import '../../features/payment/screens/payment_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/about/screens/about_screen.dart';
import '../../features/plans/models/plan_model.dart';
import '../../features/idea_qualification/screens/idea_form_screen.dart';
import '../../features/code_grana/screens/code_grana_screen.dart';

/// Classe que define as rotas do aplicativo
class AppRoutes {
  /// Rota inicial do aplicativo
  static const String initial = '/';
  
  /// Rota para a tela de login
  static const String login = '/login';
  
  /// Rota para a tela de cadastro
  static const String register = '/register';
  
  /// Rota para a tela inicial
  static const String home = '/home';
  
  /// Rota para a tela de planos
  static const String plans = '/plans';
  
  /// Rota para a tela de pagamento
  static const String payment = '/payment';
  
  /// Rota para a tela de perfil
  static const String profile = '/profile';

  /// Rota para a tela sobre
  static const String about = '/about';
  
  /// Rota para o formulário de qualificação de ideias
  static const String ideaForm = '/idea_form';
  
  /// Rota para a loja CodeGrana
  static const String codeGrana = '/code-grana';
  
  /// Gera as rotas do aplicativo
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initial:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      
      case register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      
      case home:
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      
      case plans:
        return MaterialPageRoute(
          builder: (_) => const PlansScreen(),
        );
      
      case payment:
        final plan = settings.arguments as PlanModel;
        return MaterialPageRoute(
          builder: (_) => PaymentScreen(plan: plan),
        );
      
      case profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );

      case about:
        return MaterialPageRoute(
          builder: (_) => const AboutScreen(),
        );
        
      case ideaForm:
        return MaterialPageRoute(
          builder: (_) => const IdeaFormScreen(),
        );
      
      case codeGrana:
        return MaterialPageRoute(
          builder: (_) => const CodeGranaScreen(),
        );
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Rota não encontrada: ${settings.name}'),
            ),
          ),
        );
    }
  }
} 