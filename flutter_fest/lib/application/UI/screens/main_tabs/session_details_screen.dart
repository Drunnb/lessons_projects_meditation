import 'package:flutter/material.dart';
import 'package:flutter_fest/application/UI/themes/app_colors.dart';
import 'package:flutter_fest/application/UI/themes/app_text_style.dart';
import 'package:flutter_fest/application/UI/themes/app_theme.dart';
import 'package:flutter_fest/resources/resources.dart';

class SessionDetailsScreen extends StatelessWidget {
  const SessionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const _AddToFavoriteWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: maxScreenWidth,
          ),
          child: ListView(
            children: const [
              _HeaderWidget(),
              _SessionTitleWidget(),
              _SessionDiscriptionWidget(),
              _ScheduleInfoWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddToFavoriteWidgetConfiguration {
  final String text;
  final String icon;
  final Color iconColor;
  final Color? backgroundColor;
  final LinearGradient? backgroundGradient;

  static const favorite = _AddToFavoriteWidgetConfiguration(
    text: 'В программе',
    icon: AppImages.bookmarkFull,
    iconColor: AppColors.green,
    backgroundColor: AppColors.darkSecondary,
    backgroundGradient: null,
  );

  static const disFavorite = _AddToFavoriteWidgetConfiguration(
    text: 'В мою программу',
    icon: AppImages.bookmark,
    iconColor: AppColors.white88,
    backgroundColor: AppColors.darkSecondary,
    backgroundGradient: LinearGradient(
      colors: [
        AppColors.green,
        AppColors.blue,
      ],
    ),
  );

  const _AddToFavoriteWidgetConfiguration({
    required this.text,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.backgroundGradient,
  });
}

class _AddToFavoriteWidget extends StatelessWidget {
  final isFavorite = true;
  const _AddToFavoriteWidget();

  @override
  Widget build(BuildContext context) {
    final configuration = isFavorite
        ? _AddToFavoriteWidgetConfiguration.favorite
        : _AddToFavoriteWidgetConfiguration.disFavorite;
    return SizedBox(
      height: 48.0,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: maxScreenWidth),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  elevation: MaterialStateProperty.all(0),
                  minimumSize: MaterialStateProperty.all(Size.zero),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  )),
              child: Ink(
                  decoration: BoxDecoration(
                    gradient: configuration.backgroundGradient,
                    color: configuration.backgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(configuration.icon,
                            color: configuration.iconColor),
                        const SizedBox(width: 16.0),
                        Text(configuration.text),
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        _SpeakerInfoWidget(),
      ],
    );
  }
}

class _SpeakerInfoWidget extends StatelessWidget {
  const _SpeakerInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 375 / 312,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 124),
                Flexible(
                  flex: 56,
                  child: Text(
                    'Алексей\nЧулпин',
                    style: AppTextStyle.speakerName.copyWith(
                      color: AppColors.white88,
                    ),
                  ),
                ),
                const Spacer(flex: 24),
                Flexible(
                  flex: 40,
                  child: Text(
                    'Ведущий\nразработчик МТС',
                    style: AppTextStyle.bookTextItalic.copyWith(
                      color: AppColors.white88,
                    ),
                  ),
                ),
                const Spacer(flex: 68),
              ],
            ),
          ),
          const Placeholder(),
        ],
      ),
    );
  }
}

class _SessionTitleWidget extends StatelessWidget {
  const _SessionTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 32.0, right: 20),
      child: Text(
        'Субьективность в оценке дизанайна ',
        style: AppTextStyle.stainbeckText.copyWith(
          color: AppColors.white88,
        ),
      ),
    );
  }
}

class _SessionDiscriptionWidget extends StatelessWidget {
  const _SessionDiscriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 16.0, right: 20),
      child: Text(
        'Текст описание краткое лецкии. Что будем, раскрытие темы. Думаю, что на три или четыре строки, текста нет, так что пишу,что думаю бла бла бла...',
        style: AppTextStyle.bookText.copyWith(
          color: AppColors.white88,
        ),
      ),
    );
  }
}

class _ScheduleInfoWidget extends StatelessWidget {
  const _ScheduleInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}