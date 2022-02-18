import 'package:dartz/dartz.dart';
import 'package:quiz_car/app/shared/domain/entities/quiz_entity.dart';
import 'package:quiz_car/app/shared/domain/repositories/iquiz_repository.dart';
import 'package:quiz_car/core/exceptions/erro.dart';

class SimuladoQuizUsercase {
  SimuladoQuizUsercase(this.repository);
  final IQuizRepository repository;
  Future<Either<ExceptionErro, QuizEntity>> call() {
    return repository.getSimulado();
  }
}
