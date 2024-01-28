import 'package:flutter/material.dart';
import 'package:testpro2/booking/detailshotel.dart';
import 'package:testpro2/nav_bar/FavoriteManager.dart';
import 'package:testpro2/nav_bar/FavouritePage.dart';
import 'package:testpro2/nav_bar/HistoryPage.dart';
import 'package:testpro2/nav_bar/HomePage.dart';
//import 'package:testpro2/nav_bar/HomePage.dart';
import 'package:testpro2/nav_bar/Profile/ProfilePage.dart';
import 'package:testpro2/widgets/introductionscreen.dart';
import 'package:provider/provider.dart'; // Import the provider package

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritesManager(), // Provide an instance of FavoritesManager
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingState(),
      // Define your routes
      routes: {
        '/home': (context) => HomePage(),
        '/favorites': (context) => FavoritePage(),
        '/history': (context) => HistoryPage(),
        '/profile' : (context) => ProfilePage(),
        //'/detailsHotel': (context) => DetailsHotel(),
        // Add more routes as needed
      },
    );
  }
}

class OnboardingState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool isSkipHovered = false;
  bool isStartHovered = false;

  final List<OnboardingData> onboardingData = [
    OnboardingData(
      image: 'assets/images/introduction1.png',
      title: 'Welcome to Our Hotel',
      description: 'Discover luxurious stays and excellent services.',
    ),
    OnboardingData(
      image: 'assets/images/introduction2.png',
      title: 'Explore Beautiful Rooms',
      description: 'Find the perfect room for your comfort and style.',
    ),
    OnboardingData(
      image: 'assets/images/introduction3.png',
      title: 'Book Your Stay',
      description: 'Easy booking process and secure reservations.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingPage(onboardingData[index]);
            },
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentPage == onboardingData.length - 1
                    ? SizedBox()
                    : OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyAppState()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          side: BorderSide(
                            color: isSkipHovered ? Colors.purple : Colors.purple,
                          ),
                        ),
                        child: MouseRegion(
                          onEnter: (_) => setState(() => isSkipHovered = true),
                          onExit: (_) => setState(() => isSkipHovered = false),
                          child: Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: isSkipHovered ? Colors.purple : Colors.purple,
                            ),
                          ),
                        ),
                      ),
                _currentPage == onboardingData.length - 1
                    ? OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyAppState()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          side: BorderSide(
                            color: isStartHovered ? Colors.purple : Colors.purple,
                          ),
                        ),
                        child: MouseRegion(
                          onEnter: (_) => setState(() => isStartHovered = true),
                          onExit: (_) => setState(() => isStartHovered = false),
                          child: Text(
                            'Start',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: isStartHovered ? Colors.purple : Colors.purple,
                            ),
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          primary: Colors.purple,
                          elevation: 0,
                        ),
                        child: Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingData {
  final String image;
  final String title;
  final String description;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  OnboardingPage(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              data.image,
              height: 200.0,
              width: MediaQuery.of(context).size.width * 0.8,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 32.0),
          Text(
            data.title,
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              data.description,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
