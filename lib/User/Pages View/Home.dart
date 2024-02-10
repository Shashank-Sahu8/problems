import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_power/Chats/chat_inbox_page.dart';
import 'package:random_avatar/random_avatar.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: CircleAvatar(
              radius: 18.5,
              backgroundColor: Theme.of(context).colorScheme.background,
              child: RandomAvatar(
                DateTime.now().toIso8601String(),
                height: 35,
                width: 35,
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ChatInboxPage()));
              },
              icon: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.onSurface,
                child: Icon(
                  Icons.message_outlined,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ))
        ],
      ),
      body: Column(children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Content')
                .doc('Images')
                .collection('img')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              List<String> imageUrls = snapshot.data!.docs
                  .map((doc) => doc['imgurl'] as String)
                  .where((url) => url != null)
                  .toList();

              return CarouselSlider.builder(
                  itemCount: snapshot.data!.size,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: height * 0.6,
                            width: width * 0.9,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                imageUrl: imageUrls[index],
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error_rounded,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 7.5,
                            child: Card(
                              color: Colors.grey[800],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                height: height * 0.22,
                                color: Colors.transparent,
                                alignment: Alignment.bottomCenter,
                                child: Center(
                                  child: Column(
                                    children: [
                                      Container(
                                        color: Colors.transparent,
                                        width: width * 0.75,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Title of article',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: width * 0.75,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: Text(
                                            'Description of the articles',
                                            maxLines: 2,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Container(
                                        width: width * 0.75,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              'Source',
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlayAnimationDuration: Duration(seconds: 2),
                    height: height * 0.45,
                    autoPlay: true,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                  ));
            })
      ]),
    );
  }
}
