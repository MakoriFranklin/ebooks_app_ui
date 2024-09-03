import 'dart:convert';

import 'package:ebook_app/appTabs.dart';
import 'package:ebook_app/app_colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  List popularBooks = [];
  List books = [];
  ScrollController? _scrollController;
  TabController? _tabController;

  ReadData() async {
    await DefaultAssetBundle.of(context)
        .loadString("json/popularBooks.json")
        .then((s) {
      setState(() {
        popularBooks = json.decode(s);
      });
    });

    await DefaultAssetBundle.of(context)
        .loadString("json/books.json")
        .then((s) {
      setState(() {
        books = json.decode(s);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ReadData();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: SafeArea(
          child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.window,
                        size: 30,
                      )),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            size: 30,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.notifications,
                            size: 30,
                          ))
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text(
                    'Popular Books',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: -20,
                      right: 0,
                      child: Container(
                        height: 180,
                        child: PageView.builder(
                            controller: PageController(viewportFraction: 0.8),
                            itemCount: popularBooks.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 180,
                                margin: EdgeInsets.only(right: 10),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            popularBooks[index]['img']),
                                        fit: BoxFit.cover)),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: (BuildContext context, bool isScroll){
                        return [
                          SliverAppBar(
                            backgroundColor: AppColors.background,
                            pinned: true,
                            bottom: PreferredSize(
                              preferredSize: Size.fromHeight(50), 
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                child: TabBar(
                                  indicatorPadding: const EdgeInsets.all(0),
                                  indicatorSize: TabBarIndicatorSize.label,
                                  labelPadding: const EdgeInsets.only(right: 10),
                                  controller: _tabController,
                                  isScrollable: true,
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromARGB(255, 215, 205, 205),
                                        blurRadius: 7,
                                        offset: Offset(0, 0)
                                      )
                                    ]
                                  ),
                                  tabs: const  [
                                    Apptabs(color: AppColors.menu1Color, text: 'Home'),
                                    Apptabs(color: AppColors.menu2Color, text: 'Popular'),
                                    Apptabs(color: AppColors.menu3Color, text: 'Trending'),
                                    
                                  ]
                                ),
                              )
                            ),
                          )
                        ];
                      }, 
                      body: TabBarView(
                        controller: _tabController,
                        children: [
                          ListView.builder(
                            itemCount: books.length,
                            itemBuilder: (context, index){
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.tabVarViewColor,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      offset: Offset(0, 0),
                                      color: Colors.grey.withOpacity(0.2)
                                    )
                                  ]
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: AssetImage(books[index]['img']),
                                            fit: BoxFit.cover
                                          )
                                        ),
                                      ),

                                     const SizedBox(width: 10,),
                                     Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                            ),
                                            Text(books[index]['rating'])
                                          ],
                                        ),
                                        Text(books[index]['title']),
                                        const SizedBox(height: 3,),
                                        Text(
                                          books[index]['text'],
                                          style: TextStyle(
                                            color: Colors.grey
                                          ),
                                        ),

                                        Container(
                                          height: 30,
                                          width: 60,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: AppColors.audioBlueBackground,
                                            borderRadius: BorderRadius.circular(20)
                                          ),
                                          child: const Text(
                                            'New',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600
                                            ),
                                          ),
                                        )
                                        
                                      ],
                                     )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          ),
                          Material(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey,
                              ),
                              title: Text('Content'),
                            ),
                          ),
                          
                          Material(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey,
                              ),
                              title: Text('Content'),
                            ),
                          )
                        ]
                      )
                    )
              )
            ],
          ),
        ),
      )),
    );
  }
}
