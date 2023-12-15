// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Targ Maths',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange.shade800),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Targ Maths'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BannerAd? banner_adTop;
  BannerAd? banner_adBottom;
  bool _isTopLoaded = false;
  bool _isBottomLoaded = false;

  final List<Map<String, String>> data = [
    {'title': 'Areas trigonometricas', 'subtitle': 'Calcular las areas de las formas', 'link': 'https://portfoliotavm.me/Maths/'},
    {'title': 'Derivadas', 'subtitle': 'Deriva ecuaciones', 'link': 'https://link2.com'},
    {'title': 'Exponenciales', 'subtitle': 'Calcule y grafique exponenciales', 'link': 'https://link3.com'},
    {'title': 'Factorear', 'subtitle': 'Descripción 4', 'link': 'https://link4.com'},
    {'title': 'Funciones', 'subtitle': 'Descripción 4', 'link': 'https://link4.com'},
    {'title': 'Geometria', 'subtitle': 'Descripción 4', 'link': 'https://link4.com'},
    {'title': 'Homografia', 'subtitle': 'Descripción 4', 'link': 'https://link4.com'},
    {'title': 'Limites', 'subtitle': 'Descripción 4', 'link': 'https://link4.com'},
    {'title': 'Lineal', 'subtitle': 'Descripción 4', 'link': 'https://link4.com'},
    {'title': 'Logaritmos', 'subtitle': 'Descripción 4', 'link': 'https://link4.com'},
    {'title': 'Ruffini', 'subtitle': 'Descripción 4', 'link': 'https://link4.com'},
    {'title': 'Trigonometria', 'subtitle': 'Descripción 4', 'link': 'https://link4.com'},
    {'title': 'Dos puntos', 'subtitle': 'Descripción 4', 'link': 'https://link4.com'},
  ];

  final List<Map<String, String>> carouselData = [
    {'title': 'Tarjeta 1', 'subtitle': 'Subtítulo 1', 'image': 'assets/image1.jpg'},
    {'title': 'Tarjeta 2', 'subtitle': 'Subtítulo 2', 'image': 'assets/image2.jpg'},
    {'title': 'Tarjeta 3', 'subtitle': 'Subtítulo 3', 'image': 'assets/image3.jpg'},
    // Agrega más datos según sea necesario
  ];

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716'
  ;

DisplayBannerAdTop() {
    banner_adTop = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              _isTopLoaded = true;
            });
          }
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  DisplayBannerAdBottom() {
    banner_adBottom = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              _isBottomLoaded = true;
            });
          }
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void initState() {
    super.initState();
    DisplayBannerAdTop();
    DisplayBannerAdBottom();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          _isTopLoaded
              ? Align(
                  alignment: Alignment.topCenter,
                  child: SafeArea(
                    child: SizedBox(
                      width: banner_adTop!.size.width.toDouble(),
                      height: banner_adTop!.size.height.toDouble(),
                      child: AdWidget(ad: banner_adTop!),
                    ),
                  ),
                )
              : Container(),
          const SizedBox(height: 20,),
          Container(
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            child: CarouselSlider.builder(
              itemCount: carouselData.length,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return buildCard(carouselData[index]);
              },
              options: CarouselOptions(
                height: 200.0,
                enlargeCenterPage: true,
                autoPlay: true,
              ),
            ),
          ),
          for (var element in data)
            Container(
              width: 200.0,
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.orange.shade200,
                border: Border.all(
                  color: Colors.orange.shade200,
                  width: 1.0,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WebViewScreen(title: element['title'] ?? '', url: element['link'] ?? ''),
                    ),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: element['title'] ?? '',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold,  fontFamily: AutofillHints.email,  color: Colors.white, decoration: TextDecoration.none),
                      ),
                      const WidgetSpan(
                        child: SizedBox(width: 210.0),
                      ),
                      TextSpan(
                        text: element['subtitle'] ?? '',
                        style: const TextStyle(fontSize: 14, fontFamily: AutofillHints.email, color: Colors.white, decoration: TextDecoration.none),
                      ),
                      const WidgetSpan(
                        child: SizedBox(width: 210.0),
                      ),
                      /* TextSpan(
                        text: element['link'] ?? '',
                        style: const TextStyle(fontSize: 14, color: Colors.blue, decoration: TextDecoration.underline),
                      ), */
                    ],
                  ),
                ),
              ),
            ),
            _isBottomLoaded
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: SizedBox(
                      width: banner_adBottom!.size.width.toDouble(),
                      height: banner_adBottom!.size.height.toDouble(),
                      child: AdWidget(ad: banner_adBottom!),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget buildCard(Map<String, String> cardData) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            cardData['image'] ?? '',
            height: 100.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardData['title'] ?? '',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5.0),
                Text(
                  cardData['subtitle'] ?? '',
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Resto del código...

class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const WebViewScreen({Key? key, required this.title, required this.url}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  BannerAd? banner_adTop;
  BannerAd? banner_adBottom;
  bool _isTopLoaded = false;
  bool _isBottomLoaded = false;
  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/6300978111'
      : 'ca-app-pub-3940256099942544/2934735716';

  @override
  void initState() {
    super.initState();
    DisplayBannerAdTop();
    DisplayBannerAdBottom();
  }

  DisplayBannerAdTop() {
    banner_adTop = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              _isTopLoaded = true;
            });
          }
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  DisplayBannerAdBottom() {
    banner_adBottom = BannerAd(
      adUnitId: adUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              _isBottomLoaded = true;
            });
          }
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
          _isBottomLoaded
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: SizedBox(
                      width: banner_adBottom!.size.width.toDouble(),
                      height: banner_adBottom!.size.height.toDouble(),
                      child: AdWidget(ad: banner_adBottom!),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
