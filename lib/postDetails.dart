import 'package:GLSeUniVerse/colors.dart';
import 'package:GLSeUniVerse/users.dart';
import 'package:flutter/material.dart';

// class postDiscussion extends StatefulWidget {
//   const postDiscussion({super.key});

//   @override
//   State<postDiscussion> createState() => _postDiscussionState();
// }

// class _postDiscussionState extends State<postDiscussion> {
//   TextEditingController pdiscuss = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: primary,
//       body: SingleChildScrollView(
//         child: Center(
//           child: Container(
//             width: 420,
//             padding: EdgeInsets.all(15),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   height: 200,
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                       color: white, borderRadius: BorderRadius.circular(10)),
//                   child: Text(
//                     "Post Discussion",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 25,
//                 ),
//                 TextField(
//                   controller: pdiscuss,
//                   maxLines: 10,
//                   decoration: InputDecoration(
//                       hintText: "Write your discussions...",
//                       border: OutlineInputBorder()),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   width: 420,
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: white,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       TextButton.icon(
//                         onPressed: () {
//                           Navigator.push(context, MaterialPageRoute(
//                             builder: (context) {
//                               return CameraApp();
//                             },
//                           ));
//                         },
//                         icon: Icon(
//                           Icons.camera_alt,
//                           color: Colors.black,
//                         ),
//                         label: Text(
//                           "Upload",
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class postDetails extends StatefulWidget {
  const postDetails({super.key});

  @override
  State<postDetails> createState() => _postDetailsState();
}

class _postDetailsState extends State<postDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Post Details",
          style: TextStyle(color: white),
        ),
        backgroundColor: mainFontColor,
      ),
      body: Center(
        child: Container(
          width: 400,
          height: 1000,
          padding: EdgeInsets.fromLTRB(22, 10, 10, 10),
          decoration: BoxDecoration(
            color: arrowbgColor,
            // border: Border.all(width: 2),
            // borderRadius: BorderRadius.circular(10)
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text(
                      posts[postindex]['post_title'],
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: mainFontColor),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                     
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Text(
                      "Description",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: mainFontColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      width: 320,
                      height: 395,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text(
                              // "content content contentcontentcontentcontentcontentcontentcontentcontentcontent contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent ntcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentconten\n\nntentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent ntcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent",
                              posts[postindex]['post_content'],
                              softWrap: true,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          "https://images.unsplash.com/photo-1531256456869-ce942a665e80?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTI4fHxwcm9maWxlfGVufDB8fDB8&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60"),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Posted By :",
                              style: TextStyle(
                                  color: mainFontColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(posts[postindex]['posted_by_first_name'] + ' ' + posts[postindex]['posted_by_last_name'] + ' (' + posts[postindex]['program_abbr'] + ')')
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Date :",
                              style: TextStyle(
                                  color: mainFontColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              posts[postindex]['post_date'],
                              //posts[postindex]['post_date'].toString().substring(0,10),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
