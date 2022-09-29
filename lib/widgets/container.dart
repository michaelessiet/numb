import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:numb/theme/theme.dart';
import 'package:velocity_x/velocity_x.dart';

final box = GetStorage();

class NumbContainer extends StatelessWidget {
  final Widget child;
  const NumbContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    String? routename = ModalRoute.of(context)?.settings.name;
    return Scaffold(
      appBar: VxAppBar(
        title: 'Numb'.text.semiBold.size(32).make(),
        brightness: Theme.of(context)
            .appBarTheme
            .systemOverlayStyle!
            .statusBarBrightness,
        centerTitle: false,
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        automaticallyImplyLeading: false,
        actions: [
          const Icon(Icons.settings_outlined).p12().onTap(() {
            showModalBottomSheet(
              context: context,
              backgroundColor: Theme.of(context).backgroundColor,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              builder: (context) => Column(
                children: [
                  Divider(
                    color: Theme.of(context).primaryIconTheme.color,
                    thickness: 7.5,
                    height: 40,
                  ).w(40).cornerRadius(40),
                  ListTile(
                      leading: Text(
                        'Theme',
                        style: Theme.of(context).primaryTextTheme.bodyLarge,
                      ),
                      trailing: HStack([
                        Icon(
                          Icons.sunny,
                          color: Theme.of(context).primaryIconTheme.color,
                        ),
                        CupertinoSwitch(
                          value: box.read('darkMode'),
                          activeColor: Theme.of(context)
                              .primaryTextTheme
                              .bodyMedium!
                              .color,
                          onChanged: ((value) {
                            appTheme.toggleTheme();
                          }),
                        ),
                        Icon(
                          Icons.dark_mode,
                          color: Theme.of(context).primaryIconTheme.color,
                        )
                      ])),
                  ListTile(
                    leading: Text(
                      'Help/Instructions ⓘ',
                      style: Theme.of(context).primaryTextTheme.bodyLarge,
                    ),
                    onTap: () => routename == 'help' ? context.pop() : Navigator.pushNamed(context, 'help'),
                  )
                ],
              )
                  .backgroundColor(Theme.of(context).backgroundColor)
                  .h(200)
                  .cornerRadius(20),
            );
          })
        ],
      ),
      body: child,
    );
  }
}
