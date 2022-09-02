import 'package:flutter/material.dart';
import 'package:flutter_fest/application/UI/widgets/schedule_row/schedule_row_widget.dart';
import 'package:flutter_fest/resources/resources.dart';

class ScheduleWidget extends StatelessWidget {
  const ScheduleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          const _LogoWidget(),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(topInset: topInset),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            ScheduleRowWidget.single(),
            ScheduleRowWidget.single(),
            ScheduleRowWidget.single(),
            ScheduleRowWidget.single(),
            ScheduleRowWidget.single(),
            ScheduleRowWidget.single(),
          ])),
        ],
      ),
    );
  }
}

class _LogoWidget extends StatelessWidget {
  const _LogoWidget();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 204,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(AppImages.sheduleBg),
            ),
            Positioned(
              left: 20,
              top: 84,
              child: Image.asset(AppImages.sheduleFfLogo),
            ),
            Positioned(
              right: 20,
              top: 64,
              child: Image.asset(AppImages.sheduleSurfLogo),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double _height = 56;
  final double topInset;

  _SliverAppBarDelegate({required this.topInset});

  @override
  double get maxExtent => _height + topInset;

  @override
  double get minExtent => _height + topInset;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return _SectionsButtonsWidget(topInset: topInset);
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class _SectionsButtonsWidget extends StatelessWidget {
  final double topInset;
  const _SectionsButtonsWidget({required this.topInset});

  @override
  Widget build(BuildContext context) {
    const totalItem = 4;
    const itemGradientWidth = 2;
    const halfItemGradientPoint = itemGradientWidth / 2;
    const endGradientPoint =
        totalItem * itemGradientWidth + halfItemGradientPoint;
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView.separated(
          padding: EdgeInsets.only(left: 20.0, right: 20, top: topInset),
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            final currentGradientStarPoint =
                halfItemGradientPoint + index * itemGradientWidth;
            final currentGradientEndPoint =
                endGradientPoint - currentGradientStarPoint;
            return Center(
              child: SizedBox(
                height: 36,
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
                        gradient: LinearGradient(
                          begin: Alignment(-currentGradientStarPoint, 0.0),
                          end: Alignment(
                              currentGradientEndPoint.toDouble(), 0.0),
                          colors: const [Color(0xFF00BD13), Color(0xFF170AF4)],
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(80.0)),
                      ),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text('Секция $index'),
                      ))),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              width: 10,
            );
          }),
    );
  }
}