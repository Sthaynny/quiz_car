import 'package:adaptable_screen/adaptable_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_car/app/shared/presentation/widgets/primary_button_widget.dart';
import 'package:quiz_car/core/styles/app_styles.dart';
import 'package:quiz_car/core/utils/strings.dart';
import 'package:share/share.dart';

class ResultadoScreen extends StatelessWidget {
  const ResultadoScreen({
    Key? key,
    required this.titulo,
    required this.totalPerguntas,
    required this.result,
    required this.totalRespostasCorretas,
    required this.percentual,
  }) : super(key: key);
  final String titulo;
  final int totalPerguntas;
  final int totalRespostasCorretas;
  final bool result;
  final double percentual;

  String get getPercentual => percentual.toPrecision(2).toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 100.h),
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              result ? AppImages.sucesso : AppImages.atencao,
              height: 180.h,
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Text(
                    result ? Strings.parabens : Strings.menssgemTriste,
                    style: AppTextStyles.notoSansBold(
                      color: AppColors.preto,
                      fontSize: 30.ssp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text.rich(
                  TextSpan(
                    text: Strings.voceFinalizou,
                    style: AppTextStyles.notoSansRegular(
                      color: AppColors.preto,
                      fontSize: 13.ssp,
                    ),
                    children: [
                      TextSpan(
                          text: '$titulo\n',
                          style: AppTextStyles.notoSansBold(
                            color: AppColors.preto,
                            fontSize: 13.ssp,
                          )),
                      TextSpan(
                        text: Strings.resultadoQuestionario(
                          respostasCorretas: totalRespostasCorretas.toString(),
                          totalPerguntas: totalPerguntas.toString(),
                          percentual: getPercentual,
                        ),
                        style: AppTextStyles.notoSansRegular(
                          color: AppColors.preto,
                          fontSize: 13.ssp,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 68),
                  child: PrimaryButtonWidget.azul(
                    label: Strings.compartilhar,
                    onTap: () {
                      Share.share(
                        Strings.campartilharMensagem(
                          titulo: titulo,
                          percentual: getPercentual,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 68),
                  child: PrimaryButtonWidget.branco(
                    label: Strings.voltarInicio,
                    onTap: () {
                      Get.back();
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
