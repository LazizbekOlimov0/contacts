import '../models/mock_user.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<User> stories = [];
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    MockUser.workList = MockUser.users;
    MockUser.workList.sort(
        (a, b) {
          if(a.isOnline && b.isOnline) {
            return 0;
          } else {
            if(b.isOnline) return 1;
            if(a.isOnline) return -1;

            return a.lastOnline.compareTo(b.lastOnline);
          }
        }
    );

    stories.addAll(MockUser.workList.where((story) => story.hasStory));
  }

  void search(String text) {
    // write code here
    setState(() {});
  }

  void filterAge() {
    // write code here
  }

  void filterScore() {
    // write code here
  }

  TextEditingController controller=TextEditingController();

  @override
  Widget build(BuildContext context) {

    TextEditingController controller=TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 120,
        titleSpacing: 42,
        backgroundColor: Colors.black,
        centerTitle: false,
        title: Text("Contact",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          MaterialButton(
              color: Colors.white,
              onPressed: (){},
              height: 44,
              minWidth: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10),
                  ),
              ),
              child: Icon(Icons.sort,
                size: 24,
                color: Colors.black,
              ),
          ),
          SizedBox(width: 8,),
          MaterialButton(
            color: Colors.white,
            onPressed: (){},
            height: 44,
            minWidth: 40,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10),
              ),
            ),
            child: Icon(Icons.add,
              size: 24,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
        body: Center(
          child: SizedBox(
            height: 700,
            width: double.infinity,
            child: SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 14,right: 14),
                      height: 700,
                      width: double.infinity,
                      color: Colors.black,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade900,
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search, color: Colors.white),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            controller: controller,
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                          ),
                          Text("Stories",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for(int i=0;i<stories.length;i++)
                                  StoriesCard(user: stories[i],),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(24),
                      height: 500,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(32),topRight: Radius.circular(32)),
                      ),
                      child: ListView(
                        children: [
                          for(int i=0;i<MockUser.workList.length;i++)
                            ContactListTile(user: MockUser.workList[i]),
                        ],
                      ),
                    ),
                  ],
                ),
            ),
          ),
        ),
    );
  }
}

class StoriesCard extends StatelessWidget {
  final User user;
  const StoriesCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 80,
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: (user.hasStory) ?
                      Colors.deepOrange.shade700
                          : Colors.black,
                      width: 2),
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                        user.imageUrl),
                    backgroundColor: Colors.transparent,
                  ),
                  if(user.isOnline)
                    Icon(Icons.circle,
                      color: Colors.green,
                      size: 12,
                    ),
                ],
              ),
            ],
          ),
          Text(user.firstName,
            style: TextStyle(
                color: Colors.white
            ),
          ),
        ],
      ),
    );
  }
}

class ContactListTile extends StatelessWidget {
  final User user;
  const ContactListTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(6),
      height: 100,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 20,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    user.imageUrl),
                backgroundColor: Colors.transparent,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment
                    .center,
                crossAxisAlignment: CrossAxisAlignment
                    .start,
                children: [
                  Text(user.lastName,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  (user.isOnline==true) ?
                  Text("Online", style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w100,
                  ),
                  ) : Text(user.lastOnline.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ],
              )
            ],
          ),
          if(user.isOnline==true)
            Icon(
              Icons.circle,
              color: Colors.green,
              size: 12,
            ),
        ],
      ),
    );
  }
}

