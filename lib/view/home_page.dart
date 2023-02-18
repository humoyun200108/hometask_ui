import 'package:flutter/material.dart';
import 'package:hometask/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController editTitleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Homeprovider(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "You can check your notification here",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: Builder(builder: (context) {
            var provider = Provider.of<Homeprovider>(context);
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (provider.error.isNotEmpty) {
              return Center(
                child: Text(provider.error),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Dismissible(
                    background: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Colors.yellow,
                            child: const Icon(Icons.archive),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.red,
                          child: const Icon(Icons.delete),
                        ))
                      ],
                    ),
                    key: UniqueKey(),
                    onDismissed: (DismissDirection direction) {
                      if (direction == DismissDirection.startToEnd) {
                        provider.deleteElement(index);
                      } else if (direction == DismissDirection.endToStart) {
                        print("Archive");
                      }
                    },
                    child: ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(provider.data!
                                        .getAt(index)!
                                        .name
                                        .toString() +
                                    " ni qayta nomlash"),
                                content: Column(
                                  children: [
                                    TextFormField(
                                      controller: editTitleController,
                                      decoration: const InputDecoration(
                                        hintText: "Yangi nom kiriting",
                                      ),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          provider.editElementTitle(
                                              index, editTitleController.text);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("O'zgartirish"))
                                  ],
                                ),
                              );
                            });
                      },
                      leading: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://source.unsplash.com/random/")),
                      title: Text(provider.data!.get(index)!.name.toString()),
                      subtitle:
                          Text(provider.data!.get(index)!.phone.toString()),
                      trailing: const Icon(Icons.navigate_next),
                    ),
                  );
                },
                itemCount: provider.data!.length,
              );
            }
          }),
          bottomNavigationBar: Container(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  selectedItemColor: const Color(0xFFE8EAF6),
                  unselectedItemColor: Colors.white,
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.account_balance_wallet_outlined,
                          color: Colors.black,
                        ),
                        label: "wallet",
                        backgroundColor: Color(0xFFFFFFFF)),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.notifications_active_outlined,
                          color: Colors.black,
                        ),
                        label: "notifications",
                        backgroundColor: Color(0xFFFFFFFF)),
                    BottomNavigationBarItem(
                        icon: Icon(
                          Icons.person_outline,
                          color: Colors.black,
                        ),
                        label: "Saved",
                        backgroundColor: Color(0xFFFFFFFF)),
                  ]),
            ),
          ),
        );
      },
    );
  }
}
