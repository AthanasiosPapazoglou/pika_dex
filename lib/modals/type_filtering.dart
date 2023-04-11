import 'package:flutter/material.dart';
import 'package:pika_dex/data/type_dynamics.dart';
import 'package:pika_dex/themes/app_themes.dart';

class TypeFilteringModal extends StatefulWidget {
  const TypeFilteringModal({
    required this.filterListCallback,
    required this.modalSheetLogicCoordinator,
    Key? key,
  }) : super(key: key);

  final Function filterListCallback;
  final Function modalSheetLogicCoordinator;

  @override
  State<TypeFilteringModal> createState() => _TypeFilteringModalState();
}

class _TypeFilteringModalState extends State<TypeFilteringModal> {

  List<bool> activeTypeFilters = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: 18,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                widget.filterListCallback(index);
                widget.modalSheetLogicCoordinator();
                setState(() {
                  activeTypeFilters[index] =
                      !activeTypeFilters[index];
                });
                // filterModalSheetLogicCoordinator();
              },
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 6, 16, 6),
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
                            color:
                                activeTypeFilters[
                                        index]
                                    ? Colors.green
                                    :
                                Colors.red,
                          ),
                          child: Center(
                            child: Icon(
                              activeTypeFilters[index]
                                  ? Icons
                                      .check_rounded
                                  :
                              Icons.cancel_outlined,
                            ),
                          ),
                          height: 32,
                          width: 32,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: Image.asset(
                            'assets/type_badges/${pokemonTypes[index]}.png'),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
