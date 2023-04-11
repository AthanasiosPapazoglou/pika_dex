import 'package:flutter/material.dart';
import 'package:pika_dex/data/type_dynamics.dart';
import 'package:pika_dex/themes/app_themes.dart';

class TypeFilteringModal extends StatelessWidget {
  const TypeFilteringModal({
    Key? key,
  }) : super(key: key);

  Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return AppThemes.darkTheme.backgroundColor;
      }
      return AppThemes.darkTheme.backgroundColor;
    }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: double.maxFinite,
        child: ListView.builder(
          itemCount: 18,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16, 6, 16, 6),
              child: Container(
                color:  pokemonTypeColors[index],
                height: 48,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: 
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(6),
                          color: Colors.red,
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
            );
          },
        ),
      ),
    );
  }
}
