import 'package:flutter/material.dart';
import 'package:game_template/src/common/spidermodel.dart';
import 'package:game_template/src/games_services/spider_generator.dart';
import 'package:game_template/src/widgets/spider.dart';
import 'package:provider/provider.dart';

class SpiderScrolling extends StatefulWidget {
  const SpiderScrolling({super.key});

  @override
  State<SpiderScrolling> createState() => _SpiderScrollingState();
}

class _SpiderScrollingState extends State<SpiderScrolling> with TickerProviderStateMixin {
  List<AnimationController> spiderCtrls = [];
  List<Widget> spiderWidgets = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 0), () {
      spiderCtrls.forEach((element) => element.forward());
    });
  }

  @override
  void dispose() {
    spiderCtrls.forEach((element) {
      element.dispose();
    });

    super.dispose();
  }

  Widget getSpider(AnimationController ctrl, SpiderModel sp) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(sp.xPosition, sp.y1Position),
        end: Offset(sp.xPosition, sp.y2Position),
      ).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeInOut)),
      child: Spider(),
    );
  }

  @override
  Widget build(BuildContext context) {

    SpiderGenerator sg = Provider.of<SpiderGenerator>(context, listen: false);
    sg.releaseSpiders(context);

    return Consumer<SpiderGenerator>(
      builder: (context, sGen, child) {
        return Stack(
          children: List.generate(
            sGen.spiders.length, (index) {

              var spiderModel = sGen.spiders[index];
              var spiderCtrl = AnimationController(vsync: this,
                duration: Duration(seconds: spiderModel.speed.toInt())
              );

              spiderCtrls.add(spiderCtrl);

              return SlideTransition(
                position: Tween<Offset>(
                  begin: Offset(spiderModel.xPosition, spiderModel.y1Position),
                  end: Offset(spiderModel.xPosition, spiderModel.y2Position),
                ).animate(CurvedAnimation(parent: spiderCtrl, curve: Curves.linear)),
                child: Spider(),
              );
            })
        );
      }
    );
  }
}