import 'package:flutter/material.dart';
import 'package:pika_dex/data/type_dynamics.dart';
import 'package:pika_dex/themes/app_themes.dart';

class TypeFilteringModal extends StatefulWidget {
  const TypeFilteringModal({
    required this.filterListCallback,
    required this.modalSheetLogicCoordinator,
    required this.copyOfFilterList,
    Key? key,
  }) : super(key: key);

  final Function filterListCallback;
  final Function modalSheetLogicCoordinator;
  final List<bool> copyOfFilterList;

  @override
  State<TypeFilteringModal> createState() => _TypeFilteringModalState();
}

class _TypeFilteringModalState extends State<TypeFilteringModal> {
  List<bool> activeTypeFilters = [];

  @override
  void initState() {
    super.initState();
    activeTypeFilters = List.from(widget.copyOfFilterList);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
      },
      child: Column(
        children: [
          Icon(
            Icons.drag_handle_rounded,
            size: 42,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.maxFinite,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
                crossAxisSpacing: 0,
                mainAxisSpacing: 1,
              ),
              itemCount: 18,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    widget.filterListCallback(index);
                    widget.modalSheetLogicCoordinator();
                    setState(() {
                      activeTypeFilters[index] = !activeTypeFilters[index];
                    });
                  },
                  child: Padding(
                    padding: EdgeInsetsDirectional.all(8),
                    child: Container(
                      color: activeTypeFilters[index]
                          ? pokemonTypeColors[index]
                          : Colors.grey.shade400,
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: activeTypeFilters[index]
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              child: Center(
                                child: Icon(
                                  activeTypeFilters[index]
                                      ? Icons.check_rounded
                                      : Icons.cancel_outlined,
                                ),
                              ),
                              height: 32,
                              width: 32,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: Image.asset(
                              'assets/type_badges/${pokemonTypes[index]}.png',
                              scale: 1.1,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
