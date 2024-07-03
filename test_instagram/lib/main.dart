import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/services.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {

  // 하단 네비게이션 바 내 tabbar 사용을 위한 controller
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this); //SingleTickerProviderStateMixin 를 사용해줘야 this 가 인식됨
    _tabController.addListener(() => setState(() => _selectedIndex = _tabController.index));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height; // 화면의 높이
    //SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
        // 폰트 사이즈 유지
        /*builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1)),
            child: child!,
          );
        },*/
        home: Scaffold(
            //--------- status bar 추가?
            //--------- 상단 app bar
            appBar: AppBar(
              //toolbarHeight: screenHeight/11,
              backgroundColor: Colors.black,
              iconTheme: IconThemeData(color: Colors.white),
              //title: Image.asset('assets/logo.png' , width: 200),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,10,10,10),
                  child: Image.asset('assets/logo.png', width: 120)
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,10,0,10),
                  child: Icon(Icons.expand_more),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FaIcon(FontAwesomeIcons.squarePlus),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10,0,20,0),
                  child: Icon(Icons.favorite_border),
                )],

            ),

            // contents
            //body:Contents(),
            body: _selectedIndex == 0
                ? Contents()
                : _selectedIndex == 1
                ? tabContainer(context, Colors.indigo.shade100, "b")
                : _selectedIndex == 2
                ? tabContainer(context, Colors.indigo.shade200, "c")
                : _selectedIndex == 3
                ? tabContainer(context, Colors.indigo.shade300, "d")
                : tabContainer(context, Colors.blueGrey, "Settings Tab"),
            //--------- 하단 navigation bar
            bottomNavigationBar:Container(
              //color: Colors.black,
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border(
                  top: BorderSide(
                    color: Colors.white60,
                    width: 1.0, // 두께 설정
                  ),
                ),
              ),
              child: SizedBox(
                height: 80,
                child: TabBar(
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white60,
                  controller: _tabController,
                  tabs: <Widget>[
                    Tab(
                      icon: FaIcon(
                        //_selectedIndex == 0 ? FontAwesomeIcons.house : FontAwesomeIcons.house,
                        FontAwesomeIcons.house, size: 28
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        //_selectedIndex == 1 ? Icons.chat : Icons.chat_outlined,
                          FontAwesomeIcons.magnifyingGlass, size: 28
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        //_selectedIndex == 2 ? Icons.settings : Icons.settings_outlined,
                        FontAwesomeIcons.video, size: 28
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        //_selectedIndex == 3 ? Icons.settings : Icons.settings_outlined,
                        FontAwesomeIcons.paperPlane, size: 28
                      ),
                    ),
                    Tab(
                      icon: ClipOval(
                        child: Image.asset(
                          'assets/01.gif',
                          height: 35,
                          width: 35,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
            ),
        ),
        )

    );
  }
}

// 네비게이션 바 클릭 시 보여주는 컨텐츠
Container tabContainer(BuildContext context, Color tabColor, String tabText) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    color: tabColor,
    child: Center(
      child: Text(
        tabText,
        style: TextStyle(
          color: Colors.white,
        ),
      )
    )
  );
}
  // 커스텀위젯
// 일단 위 내용을 작성해보고...
class Contents extends StatelessWidget {
  const Contents({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width : double.infinity,// 박스 가로폭 꽉차게 주려면
        color: Colors.black,
        child: Column(
          children: [
            /*Row(
              children: [
                  story()
              ],
            ),*/

            Expanded(
                child: ListView(
                  children: [
                    story(),
                    for (num j = 1; j <6; j++)
                      content()
                  ],
                )
            ),
            //
          ],
        )
    );
  }

  // 게시물
  Widget content(){
    return Column (
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        writer(),
        CarouselWidget(),
        option(),
        text()
      ],
    );
  }

  // 스토리
  Widget story() {
    List nameList = ["내 스토리", "gamza", "oksusu", "gamza", "oksusu", "gamza", "oksusu"];
    List profileList = ["assets/01.gif", "assets/02.png", "assets/03.png", "assets/02.png", "assets/03.png", "assets/02.png", "assets/03.png"];
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,// 가로 스크롤
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < nameList.length; i++)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                    /*
                      //border 를 사용한 테두리
                      child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        border: Border.all(color: Colors.pinkAccent, width: 3),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(profileList[i], width: 60),
                      ),
                    ),*/
                    // stack 을 사용한 테두리
                    child: Stack(
                      children: [
                        SizedBox(
                            width: 80,
                            //height: 65,
                            //child: Image.asset('assets/border.jpg')
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40),
                              child: Image.asset('assets/border.jpg'),
                            ),
                        ),
                        Positioned(
                          top: 4.5,
                          left: 5,
                            child: SizedBox(
                                width: 70,
                                //height: 60,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(35),
                                  child: Image.asset(profileList[i]),
                                ),
                            )
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 5, 0, 10),
                    child: Text(nameList[i], style: TextStyle(color: Colors.white, fontSize: 15)),
                  )
                ],
              )
          ],
        )
    )
    );
  }

  // 게시글 작성자
  Widget writer(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(5,10,10,10),
            child : ClipRRect(
                borderRadius: BorderRadius.circular(360.0),
                child: Image.asset('assets/01.gif', width: 50,)
            )
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 17),'goguma_111'),
            Text(style: TextStyle(color: Colors.white, fontSize: 15), '서울')
          ],
        ),
        Spacer(), // 우측으로 남은 공간을 차지
        Padding(
            padding: const EdgeInsets.fromLTRB(0,0,10,0),
            child: FaIcon(FontAwesomeIcons.ellipsis, color: Colors.white)
        ),
      ],
    );
  }

  /*Widget image(){

    return Stack(
        children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Image.asset('assets/01.gif', width:448, fit: BoxFit.cover)
            )
          ],
        )
    ]
    );
  }*/

  // 게시글 상태바
  Widget option(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,

      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(10,10,15,10),
            child: Icon(Icons.favorite_border, color: Colors.white, size: 35,)
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(0,10,15,10),
            child: FaIcon(FontAwesomeIcons.comment, color: Colors.white, size: 30,)
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(0,10,15,10),
            child: FaIcon(FontAwesomeIcons.paperPlane, color: Colors.white, size: 28,)
        ),
        Spacer(), // 우측으로 남은 공간을 차지
        Padding(
            padding: const EdgeInsets.fromLTRB(0,10,10,10),
            child: FaIcon(FontAwesomeIcons.bookmark, color: Colors.white, size: 30,)
        ),

      ],
    );
  }

  // 게시글 내용
  Widget text(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(10,10,0,5),
            child:Text(style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 19), 'gamza님이 좋아합니다')
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(10,0,10,5),
            child:Text(style: TextStyle(color: Colors.white, fontSize: 17),'goguma_111 춘식이와 함께~!!🥰')
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(10,0,0,20),
            child:Text(style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 17), '...더보기')
        )
      ],
    );
  }

}

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({super.key});

  @override
  State<CarouselWidget> createState() => _CarouselWidget();
}

class _CarouselWidget extends State<CarouselWidget> {
  // Indicator 가 가르켜야하는 Index 에 대한 변수
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height; // 화면의 높이
    //double screenWidth = MediaQuery.of(context).size.width ;

    List<String> images = ["assets/content.jpg", "assets/content.jpg", "assets/content.jpg"];
    return Stack(
          children: [
            slider(images, screenHeight / 2.3),
            Positioned.fill(
              //slider 의 높이를 Stack 의 크기만큼 늘려주기 위해서 Positioned.fill 사용함
              child: Align(
                alignment: Alignment.bottomCenter, // 하단 가운데 정렬
                child: indicator(images),
              ),
            ),
          ]
    );
  }

  // 사진을 슬라이드하는 화면
  Widget slider(List<String> images, height) => CarouselSlider(
    items: images.map((image) => Image.asset(image, fit: BoxFit.cover, width: double.infinity)).toList(), // 이미지 리스트를 Image 위젯으로 변환
    options: CarouselOptions(
      height: height, // height 와 viewportFraction 을 기준으로 이미지의 크기가 설정됨.
      autoPlay: false,
      viewportFraction: 1, // 각 페이지가 차지하는 viewport의 정도임. 0.8로 설정하면 Indicator 가 없는 슬라이드 구성가능함.
      enlargeCenterPage: false, // 이미지보다 화면이 클 수 있는지 설정
      initialPage: 0, // 초기 페이지 인덱스
      //aspectRatio: 16 / 9, // 이미지의 가로:세로 비율을 16:9로 설정하여 화면에 꽉 차도록 함
      onPageChanged: (index, reason) => setState(() {
        activeIndex = index; // 페이지가 변경될 때, indicator 의 인덱스를 변경함.
      }),
    ),
  );

// Indicator
  Widget indicator(images) => Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      alignment: Alignment.bottomCenter,
      child: AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: images.length,
        effect: JumpingDotEffect(
            dotHeight: 6,
            dotWidth: 6,
            activeDotColor: Colors.white,
            dotColor: Colors.white.withOpacity(0.6)),
      ));
}