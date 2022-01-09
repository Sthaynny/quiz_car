import 'package:get/get.dart';
import 'package:quiz_car/app/features/resultado/resultado_screen.dart';
import 'package:quiz_car/app/features/shared/domain/entities/quiz_entity.dart';
import 'package:quiz_car/app/features/shared/domain/entities/resposta_entity.dart';
import 'package:quiz_car/core/mixins/pop_up_mixin.dart';

class QuestionarioController extends GetxController with PopUpMixin {
  QuestionarioController() {
    _indexPergunta = Rx<int>(0);
  }
  void init({required QuizEntity quizEntity}) {
    _quiz = Rx(quizEntity);
  }

  late Rx<QuizEntity> _quiz;
  late Rx<int> _indexPergunta;

  QuizEntity get quiz => _quiz.value;
  int get tamanhoQuiz => quiz.perguntas.length;

  int get indexPergunta => _indexPergunta.value;
  int get indexPerguntaUsuario => _indexPergunta.value + 1;
  bool get ultimaPergunta =>
      _indexPergunta.value == (quiz.perguntas.length - 1);

  RespostaEntity? get respostaSelecionada =>
      quiz.perguntas[indexPergunta].respostaSelecionada;

  set setRespostaSelecionada(RespostaEntity resposta) {
    quiz.perguntas[indexPergunta].respostaSelecionada = resposta;
    update();
  }

  get perguntaAtual => quiz.perguntas[indexPergunta];

  RespostaEntity? get respotaSelecionada =>
      quiz.perguntas[indexPergunta].respostaSelecionada;

  void get proximoPergunta {
    if (ultimaPergunta) {
      int totalPerguntasCorretas = 0;
      for (var pergunta in quiz.perguntas) {
        if (pergunta.respostaSelecionada != null &&
            pergunta.respostaSelecionada!.correta) {
          totalPerguntasCorretas++;
        }
      }
      final double percentual = (totalPerguntasCorretas / tamanhoQuiz) * 100;
      irParaResultado(percentual, totalPerguntasCorretas);
    } else {
      _indexPergunta.value++;
    }
    update();
  }

  void get voltarPergunta {
    _indexPergunta.value--;
    update();
  }

  ///Navegação

  Future<void> fecharQuestionario() async {
    final result = await popUpConfirmacao();
    if (result != null && result) {
      Get.back();
    }
  }

  void irParaResultado(double percentual, int totalPerguntasCorretas) {
    Get.off(
      ResultadoScreen(
        titulo: quiz.titulo,
        totalPerguntas: tamanhoQuiz,
        result: percentual >= 70.0,
        totalRespostasCorretas: totalPerguntasCorretas,
        percentual: percentual,
      ),
      transition: Transition.fade,
    );
  }
}
