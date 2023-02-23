import 'package:flutter/material.dart';

class VisualComponent extends StatefulWidget {
  final int duration;
  final Color color;
  VisualComponent({required this.duration, required this.color});

  @override
  State<VisualComponent> createState() => _VisualComponentState();
}

class _VisualComponentState extends State<VisualComponent>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController animController;
  @override
  void initState() {
    super.initState();
    animController = AnimationController(
        duration: Duration(milliseconds: widget.duration), vsync: this);
    final curvedAnimation =
        CurvedAnimation(parent: animController, curve: Curves.easeInOutSine);
    animation = Tween<double>(begin: 0, end: 100).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      });
    animController.repeat(reverse: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 10,
        decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(5)), // BoxDecoration
        height: animation.value); // Container
  }
}

class MusicVisiulizer extends StatelessWidget {
  MusicVisiulizer({Key? key}) : super(key: key);

  List<Color> colors = [
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.redAccent,
    Colors.yellowAccent
  ];
  List<int> duration = [900, 700, 600, 800, 500];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List<Widget>.generate(
            10,
            (index) => VisualComponent(
                  color: colors[index % 4],
                  duration: duration[index % 5],
                )),
      ),
    );
  }
}
