import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class MIAlarmCustomModalAnatiomPage extends StatefulWidget {
  const MIAlarmCustomModalAnatiomPage({Key? key}) : super(key: key);

  @override
  State<MIAlarmCustomModalAnatiomPage> createState() =>
      _MIAlarmCustomModalAnatiomPageState();
}

class _MIAlarmCustomModalAnatiomPageState
    extends State<MIAlarmCustomModalAnatiomPage>
    with SingleTickerProviderStateMixin {
  int? openTileId;
  double? screenSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    screenSize ??= MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top + kToolbarHeight);
  }

  final ScrollController _scrollController = ScrollController();

  late AnimationController _animationController;

  Tween<double>? modalTopPosition;
  Tween<double>? modalHeight;
  Tween<double>? modalWidth;
  Tween<double>? modalBorderRadius;
  Tween<double>? modalPadding;

  final verticalModalPadding = 15.0;
  final modalExpandedSize = 250.0;
  final tileSize = 70.0;
  late double verticalTopMovement;
  late double verticalBottomMovememnt;

  @override
  void initState() {
    super.initState();

    // amount by which top of the tile should expand in normal case
    verticalTopMovement = (modalExpandedSize / 2) - (tileSize / 2);

    // amount by which bottom of the tile should expand in normal case
    verticalBottomMovememnt = (tileSize / 2) + (modalExpandedSize / 2);

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.dismissed) {
          setState(() {
            openTileId = null;
          });
        }
      });
  }

  // initialize animation start values based on scrollcontroller's position
  void initializeAnimationStartValues(int tileId) {
    var initialTileTopPosition =
        (tileId - 1) * 70 - _scrollController.position.pixels;

    // if tileTop after expansion is going beyond the screen, stop it at 0
    if (initialTileTopPosition - verticalTopMovement < verticalModalPadding) {
      final finalTileTopPosition = 0 + verticalModalPadding;
      modalTopPosition = Tween<double>(
          begin: initialTileTopPosition, end: finalTileTopPosition);
    }

    // if bottom is flowing beyond the screen, stop it at acreen's bottom
    else if (initialTileTopPosition + verticalBottomMovememnt > screenSize!) {
      final finalTileTopPosition =
          screenSize! - (modalExpandedSize + verticalModalPadding);
      modalTopPosition = Tween<double>(
          begin: initialTileTopPosition, end: finalTileTopPosition);
      // normal case (tile is somewhere near the center of screen, so expansion on both top and bottom is equal)
    } else {
      final finalTileTopPosition = initialTileTopPosition - verticalTopMovement;
      modalTopPosition = Tween<double>(
          begin: initialTileTopPosition, end: finalTileTopPosition);
    }

    modalHeight = Tween<double>(begin: 70, end: modalExpandedSize);

    modalWidth = Tween<double>(
        begin: MediaQuery.of(context).size.width,
        end: MediaQuery.of(context).size.width * 0.92);

    modalBorderRadius = Tween<double>(begin: 0, end: 30.0);

    modalPadding = Tween<double>(begin: 0, end: 10.0);
  }

  void closeModal() {
    _animationController.reverse();
  }

  void onTileTap(int tileId) {
    initializeAnimationStartValues(tileId);
    setState(() {
      openTileId = tileId;
    });

    _animationController.forward();
  }

  final List<String> alarmTimes = [
    "06:33",
    "04:53",
    "07:23",
    "08:34",
    "04:31",
    "01:23",
    "06:32",
    "06:33",
    "08:34",
    "04:31",
    "04:53",
    "07:23",
    "08:34",
    "04:31",
    "01:23",
    "06:32",
    "01:23",
    "06:32",
    "06:33",
    "08:34",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MI Alarm Clock")),
      body: Stack(
        alignment: Alignment.center,
        children: [
          ListView(
            controller: _scrollController,
            children: [
              for (int i = 0; i < alarmTimes.length; i++)
                AlarmItem(
                    context: context,
                    alarmTime: alarmTimes[i],
                    id: i + 1,
                    onTap: (id) => onTileTap(id))
            ],
          ),
          if (openTileId != null)
            Positioned(
              child: GestureDetector(
                onTap: () {
                  closeModal();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: double.infinity,
                  color: Colors.grey[700]!.withOpacity(0.5),
                ),
              ),
            ),
          if (openTileId != null)
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Positioned(
                  top: modalTopPosition!.transform(_animationController.value),
                  child: Container(
                    height: modalHeight!.transform(_animationController.value),
                    width: modalWidth!.transform(_animationController.value),
                    padding: EdgeInsets.all(
                        modalPadding!.transform(_animationController.value)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(modalBorderRadius!.transform(
                            _animationController.value,
                          )),
                        ),
                        boxShadow: [
                          // display shadow only after the animation is complete
                          if (_animationController.value == 1)
                            BoxShadow(
                              color: Colors.grey[600]!,
                              blurRadius: 25,
                              // offset: const Offset(4, 8),
                            )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AlarmItem(
                          context: context,
                          id: 0,
                          alarmTime: alarmTimes[openTileId! - 1],
                          onTap: (_) {},
                        ),
                        // display this only after the animation is complete, to prevent overflow
                        if (_animationController.value == 1)
                          const AlarmTImeColumns(),
                        // display buttons only when modal height is above 150, to prevent overflow errors
                        if (modalHeight!.transform(_animationController.value) >
                            150)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: const [
                                ModalButton(text: "Settings"),
                                SizedBox(width: 20),
                                ModalButton(text: "OK"),
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                );
              },
              // child:
            )
        ],
      ),
    );
  }
}

class AlarmTImeColumns extends StatelessWidget {
  const AlarmTImeColumns({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("AM",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.grey,
                  )),
              SizedBox(height: 10),
              Text("PM",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.grey,
                  )),
              SizedBox(height: 10),
            ],
          ),
          Column(
            children: const [
              Text("08",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.grey,
                  )),
              SizedBox(height: 10),
              Text("09",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.grey,
                  )),
              SizedBox(height: 10),
              Text("10",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.grey,
                  )),
              SizedBox(height: 10),
            ],
          ),
          Column(
            children: const [
              Text("10",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.grey,
                  )),
              SizedBox(height: 10),
              Text("11",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.grey,
                  )),
              SizedBox(height: 10),
              Text("12",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.grey,
                  )),
              SizedBox(height: 10),
            ],
          )
        ],
      ),
    );
  }
}

class AlarmItem extends StatelessWidget {
  const AlarmItem({
    Key? key,
    required this.context,
    required this.alarmTime,
    required this.id,
    required this.onTap,
  }) : super(key: key);

  final BuildContext context;
  final String alarmTime;
  final int id;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListTile(
        onTap: () {
          onTap(id);
        },
        title: RichText(
          text: TextSpan(
            text: alarmTime,
            style: const TextStyle(fontSize: 26, color: Colors.grey),
            children: const [
              WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: SizedBox(width: 5)),
              TextSpan(text: "pm", style: TextStyle(fontSize: 12))
            ],
          ),
        ),
        subtitle: const Text(
          "Once",
          style: TextStyle(color: Colors.grey),
        ),
        trailing: Switch(value: false, onChanged: (_) {}),
      ),
    );
  }
}

class ModalButton extends StatelessWidget {
  const ModalButton({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        child: Text(text),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0.2),
          backgroundColor: MaterialStateProperty.all(Colors.grey[100]!),
          foregroundColor: MaterialStateProperty.all(Colors.black),
          padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 16.0,
            ),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(
                color: Colors.black.withOpacity(0.3),
                width: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
