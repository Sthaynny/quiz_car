import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/direcao_defensiva_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/legislacao_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/mecanica_basica_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/meio_ambiente_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/primeiros_socorros_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/domain/usecases/simulado_quiz_usercase.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/components/quiz_button_widget.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/controller/home_controller.dart';
import 'package:habilitacao_quiz/app/features/home/presentation/home_screen.dart';
import 'package:habilitacao_quiz/app/shared/utils/keys_home.dart';
import 'package:habilitacao_quiz/app/shared/data/models/questoes_model.dart';
import 'package:habilitacao_quiz/app/shared/presentation/widgets/car_quiz_widget.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/utils.dart';

class _MockDirecaoDefesivaQuizUsercase extends Mock
    implements DirecaoDefesivaQuizUsercase {}

class _MockLegislacaoQuizUsercase extends Mock
    implements LegislacaoQuizUsercase {}

class _MockMeioAmbienteQuizUsercase extends Mock
    implements MeioAmbienteQuizUsercase {}

class _MockPrimeirosSocorrosQuizUsercase extends Mock
    implements PrimeirosSocorrosQuizUsercase {}

class _MockMecanicaBasicaQuizUsercase extends Mock
    implements MecanicaBasicaQuizUsercase {}

class _MockSimuladoQuizUsercase extends Mock implements SimuladoQuizUsercase {}

Widget makeTestable(Widget widget) => GetMaterialApp(home: widget);

void main() {
  late HomeController homeController;
  late _MockDirecaoDefesivaQuizUsercase direcaoDefesivaQuizUsercase;
  late _MockLegislacaoQuizUsercase legislacaoQuizUsercase;
  late _MockMeioAmbienteQuizUsercase meioAmbienteQuizUsercase;
  late _MockPrimeirosSocorrosQuizUsercase primeirosSocorrosQuizUsercase;
  late _MockMecanicaBasicaQuizUsercase mecanicaBasicaQuizUsercase;
  late _MockSimuladoQuizUsercase simuladoQuizUsercase;
  final quizEntity = QuizModel.fromMap(tMapQuizModel);

  setUp(() {
    direcaoDefesivaQuizUsercase = _MockDirecaoDefesivaQuizUsercase();
    legislacaoQuizUsercase = _MockLegislacaoQuizUsercase();
    meioAmbienteQuizUsercase = _MockMeioAmbienteQuizUsercase();
    primeirosSocorrosQuizUsercase = _MockPrimeirosSocorrosQuizUsercase();
    mecanicaBasicaQuizUsercase = _MockMecanicaBasicaQuizUsercase();
    simuladoQuizUsercase = _MockSimuladoQuizUsercase();
    homeController = HomeController(
      direcaoDefesivaQuizUsercase: direcaoDefesivaQuizUsercase,
      legislacaoQuizUsercase: legislacaoQuizUsercase,
      meioAmbienteQuizUsercase: meioAmbienteQuizUsercase,
      primeirosSocorrosQuizUsercase: primeirosSocorrosQuizUsercase,
      mecanicaBasicaQuizUsercase: mecanicaBasicaQuizUsercase,
      simuladoQuizUsercase: simuladoQuizUsercase,
    );
  });
  testWidgets(
    'Home Screen inicializar tela',
    (WidgetTester tester) async {
      await tester.pumpWidget(makeTestable(HomeScreen(
        controller: homeController,
      )));
      final Finder scaffoldFinder = find.byType(Scaffold);
      expect(scaffoldFinder, findsOneWidget);
      final Finder quizCarFinder = find.byType(CarQuizWidget);
      expect(quizCarFinder, findsOneWidget);
      final Finder quizButtonFinder = find.byType(QuizButtonWidget);
      expect(quizButtonFinder, findsNWidgets(6));
    },
  );
  testWidgets(
    'Home Screen - click direcao  defenciva',
    (WidgetTester tester) async {
      when(
        () => direcaoDefesivaQuizUsercase(),
      ).thenAnswer(
        (invocation) async => Right(quizEntity),
      );
      await tester
          .pumpWidget(makeTestable(HomeScreen(controller: homeController)));

      final Finder butaodirecaoDefenciva =
          find.byKey(KeysEnum.direcaoDefenciva.converteKey);

      expect(butaodirecaoDefenciva, findsOneWidget);
    },
  );
}
