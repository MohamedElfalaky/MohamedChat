// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mohamed_chat/View/Screens/Contact/contact_controller.dart';

import '../../../Data/Cubits/GetUsers/get_users_cubit.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // ContactController.asyncLoadAllData();
    context.read<GetUsersCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            automaticallyImplyLeading: false,
            title: Text("contact"),
          ),
          backgroundColor: Colors.grey[300],
          body: BlocBuilder<GetUsersCubit, GetUsersState>(
            builder: (context, state) {
              return RefreshIndicator(
                  onRefresh: () async {
                    context.read<GetUsersCubit>().getUsers();
                  },
                  child: state is GetUsersSuccess
                      ? CustomScrollView(
                          slivers: [
                            SliverPadding(
                              padding: EdgeInsets.symmetric(),
                              sliver: SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                // var item = ContactController.contactList[index];
                                return InkWell(
                                  onTap: () {
                                    ContactController.goChat(
                                        state.myList[index], context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 1,
                                                color: Colors.grey
                                                    .withOpacity(0.5)))),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 10),
                                    // padding: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 60,
                                          width: 60,
                                          // decoration: BoxDecoration(shape: BoxShape.circle),
                                          child: CachedNetworkImage(
                                              imageUrl:
                                                  "${state.myList[index].photoUrl}"),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.only(
                                                  start: 8),
                                          child: Text(
                                            state.myList[index].name ?? "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }, childCount: state.myList.length)),
                            )
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator(),
                        ));
            },
          )

          //  Container(
          //   height: MediaQuery.of(context).size.height,
          //   child: Column(
          //     children: [
          //       Center(
          //         child: Text("Hello contacts"),
          //       ),

          //     ],
          //   ),
          // ),
          ),
    );
  }
}
