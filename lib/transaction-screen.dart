import 'package:ad_bank/services/session_manager.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'nav-drawer.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key}) : super(key: key);

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  DatabaseReference refTransaction =
      FirebaseDatabase.instance.ref().child('Transactions');

  @override
  Widget build(BuildContext context) {
    String preDate = '';
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                  indicator: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    gradient: LinearGradient(
                      colors: [Colors.blue, Colors.cyanAccent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  tabs: [
                    Tab(
                      child: Text(
                        'COMPLETE',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    Tab(
                        child: Text(
                      "IN PROGRESS",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )),
                  ]),
              centerTitle: true,
              title: const Text("TRANSACTIONS"),
              elevation: 0,
              backgroundColor: Colors.indigo,
              actions: const [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Icon(Icons.settings),
                )
              ],
            ),
            drawer: const NavDrawer(),
            body: TabBarView(children: [
              FirebaseAnimatedList(
                  query: refTransaction.child(SessionController().userId.toString()),
                  sort: (a, b) {
                    return b.value.toString().compareTo(a.value.toString());
                  },
                  itemBuilder: (context, snapshot, animation, index) {
                    if (snapshot.exists) {
                      if (index == 0) {
                        preDate = snapshot.child('date').value.toString().substring(0, 10);
                        if(preDate == DateTime.now().toString().substring(0,10)){
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Center(child: Text('Today')),
                              const Divider(
                                thickness: 1,
                              ),
                              InkWell(
                                onTap: () {
                                  showMyDialog(
                                      snapshot.child('type').value.toString(),
                                      snapshot.child('ammount').value.toString(),
                                      snapshot.child('recieverName').value.toString(),
                                      snapshot.child('date').value.toString());
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    maxRadius: 20,
                                    child:
                                    snapshot.child('type').value.toString() ==
                                        'Transferred'
                                        ? const Icon(
                                        Icons.arrow_downward_outlined,
                                        color: Colors.red,
                                        size: 30)
                                        : const Icon(
                                      Icons.arrow_upward_outlined,
                                      color: Colors.green,
                                      size: 30,
                                    ),
                                  ),
                                  title: snapshot
                                      .child('type')
                                      .value
                                      .toString() ==
                                      'Transferred'
                                      ? Text(
                                      '${snapshot.child('type').value} to account ${snapshot.child('toAcc').value.toString()}')
                                      : Text(
                                      '${snapshot.child('type').value} from account ${snapshot.child('fromAcc').value.toString()}'),
                                  subtitle: Text(
                                      'Message: ${snapshot.child('message').value}'),
                                  trailing: Text(
                                    'RS ${snapshot.child('ammount').value.toString()}',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          );
                        }else{
                          return Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Center(child: Text(preDate)),
                              const Divider(
                                thickness: 1,
                              ),
                              InkWell(
                                onTap: () {
                                  showMyDialog(
                                      snapshot.child('type').value.toString(),
                                      snapshot.child('ammount').value.toString(),
                                      snapshot
                                          .child('recieverName')
                                          .value
                                          .toString(),
                                      snapshot.child('date').value.toString());
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    maxRadius: 20,
                                    child:
                                    snapshot.child('type').value.toString() ==
                                        'Transferred'
                                        ? const Icon(
                                        Icons.arrow_downward_outlined,
                                        color: Colors.red,
                                        size: 30)
                                        : const Icon(
                                      Icons.arrow_upward_outlined,
                                      color: Colors.green,
                                      size: 30,
                                    ),
                                  ),
                                  title: snapshot
                                      .child('type')
                                      .value
                                      .toString() ==
                                      'Transferred'
                                      ? Text(
                                      '${snapshot.child('type').value} to account ${snapshot.child('toAcc').value.toString()}')
                                      : Text(
                                      '${snapshot.child('type').value} from account ${snapshot.child('fromAcc').value.toString()}'),
                                  subtitle: Text(
                                      'Message: ${snapshot.child('message').value}'),
                                  trailing: Text(
                                    'RS ${snapshot.child('ammount').value.toString()}',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                      }else{
                        if (snapshot.child('date').value.toString().substring(0, 10) != preDate) {
                          preDate = snapshot.child('date').value.toString().substring(0, 10);
                          if(preDate == DateTime.now().toString().substring(0,10)){
                            return Column(
                              children: [
                                const Divider(
                                  thickness: 1,
                                ),
                                const Center(child: Text("Today")),
                                const Divider(
                                  thickness: 1,
                                ),
                                InkWell(
                                  onTap: () {
                                    showMyDialog(
                                        snapshot.child('type').value.toString(),
                                        snapshot
                                            .child('ammount')
                                            .value
                                            .toString(),
                                        snapshot
                                            .child('recieverName')
                                            .value
                                            .toString(),
                                        snapshot.child('date').value.toString());
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      maxRadius: 20,
                                      child: snapshot
                                          .child('type')
                                          .value
                                          .toString() ==
                                          'Transferred'
                                          ? const Icon(
                                          Icons.arrow_downward_outlined,
                                          color: Colors.red,
                                          size: 30)
                                          : const Icon(
                                        Icons.arrow_upward_outlined,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                    ),
                                    title: snapshot
                                        .child('type')
                                        .value
                                        .toString() ==
                                        'Transferred'
                                        ? Text(
                                        '${snapshot.child('type').value} to account ${snapshot.child('toAcc').value.toString()}')
                                        : Text(
                                        '${snapshot.child('type').value} from account ${snapshot.child('fromAcc').value.toString()}'),
                                    subtitle: Text(
                                        'Message: ${snapshot.child('message').value}'),
                                    trailing: Text(
                                      'RS ${snapshot.child('ammount').value.toString()}',
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }else{
                            return Column(
                              children: [
                                const Divider(
                                  thickness: 1,
                                ),
                                Center(child: Text(preDate)),
                                const Divider(
                                  thickness: 1,
                                ),
                                InkWell(
                                  onTap: () {
                                    showMyDialog(
                                        snapshot.child('type').value.toString(),
                                        snapshot
                                            .child('ammount')
                                            .value
                                            .toString(),
                                        snapshot
                                            .child('recieverName')
                                            .value
                                            .toString(),
                                        snapshot.child('date').value.toString());
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      maxRadius: 20,
                                      child: snapshot
                                          .child('type')
                                          .value
                                          .toString() ==
                                          'Transferred'
                                          ? const Icon(
                                          Icons.arrow_downward_outlined,
                                          color: Colors.red,
                                          size: 30)
                                          : const Icon(
                                        Icons.arrow_upward_outlined,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                                    ),
                                    title: snapshot
                                        .child('type')
                                        .value
                                        .toString() ==
                                        'Transferred'
                                        ? Text(
                                        '${snapshot.child('type').value} to account ${snapshot.child('toAcc').value.toString()}')
                                        : Text(
                                        '${snapshot.child('type').value} from account ${snapshot.child('fromAcc').value.toString()}'),
                                    subtitle: Text(
                                        'Message: ${snapshot.child('message').value}'),
                                    trailing: Text(
                                      'RS ${snapshot.child('ammount').value.toString()}',
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            );
                          }

                        } else {
                          return InkWell(
                            onTap: () {
                              showMyDialog(
                                  snapshot.child('type').value.toString(),
                                  snapshot.child('ammount').value.toString(),
                                  snapshot
                                      .child('recieverName')
                                      .value
                                      .toString(),
                                  snapshot.child('date').value.toString());
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                maxRadius: 20,
                                child: snapshot
                                            .child('type')
                                            .value
                                            .toString() ==
                                        'Transferred'
                                    ? const Icon(Icons.arrow_downward_outlined,
                                        color: Colors.red, size: 30)
                                    : const Icon(
                                        Icons.arrow_upward_outlined,
                                        color: Colors.green,
                                        size: 30,
                                      ),
                              ),
                              title: snapshot.child('type').value.toString() ==
                                      'Transferred'
                                  ? Text(
                                      '${snapshot.child('type').value} to account ${snapshot.child('toAcc').value.toString()}')
                                  : Text(
                                      '${snapshot.child('type').value} from account ${snapshot.child('fromAcc').value.toString()}'),
                              subtitle: Text(
                                  'Message: ${snapshot.child('message').value}'),
                              trailing: Text(
                                'RS ${snapshot.child('ammount').value.toString()}',
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }
                      }
                    } else {
                      return const Center(child: Text("No Transaction Found"));
                    }
                  }),
              const Center(child: Text('No Record Found')),
            ])));
  }

  Future<void> showMyDialog(
      String type, String ammount, String recieverName, String date) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          icon: type == "Transferred"
              ? const Image(
                  image: AssetImage(
                    'assets/images/transfer.png',
                  ),
                  color: Colors.red,
                  height: 30,
                )
              : const Image(
                  image: AssetImage(
                    'assets/images/received.png',
                  ),
                  color: Colors.green,
                  height: 30,
                ),
          title: type == "Transferred"
              ? const Text("Ammount Transfer Details")
              : const Text("Ammount Received Details"),
          content: SizedBox(
            height: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Ammount: $ammount',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: type == "Transferred"
                      ? Text(
                          'Transfer to $recieverName',
                          style: const TextStyle(fontSize: 16),
                        )
                      : Text(
                          'Received from $recieverName',
                          style: const TextStyle(fontSize: 16),
                        ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Date: $date")),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK")),

          ],
        );
      },
    );
  }
}
