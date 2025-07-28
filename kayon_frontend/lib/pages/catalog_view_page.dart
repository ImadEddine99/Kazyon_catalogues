import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kayon_frontend/classes/colors.dart';
import 'package:kayon_frontend/components/background.dart';

class CatalogCarouselPage extends StatefulWidget {
  final int id;

  CatalogCarouselPage({super.key, required this.id});
  @override
  State<CatalogCarouselPage> createState() => _CatalogCarouselPageState();
}

class _CatalogCarouselPageState extends State<CatalogCarouselPage> {
  int _currentPage = 0;
  late PageController _pageController;

  // CatalogCarouselPage({super.key});
  final List<String> imageUrls = [
    'https://picsum.photos/id/237/1200/800',
    'https://picsum.photos/id/1/1200/800',
    'https://picsum.photos/id/10/1200/800',
    'https://picsum.photos/id/20/1200/800',
  ];
  void _goToPage(int page) {
    if (page >= 0 && page < (imageUrls[widget.id].length ?? 0)) {
      _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage = page;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Catalogue',
            style: GoogleFonts.lexend(
              color: Colors.white,
              fontSize: 18,
              letterSpacing: 0.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color(AppColors.orange_primary),
        ),
        body: size.width > 600
            ? NewBackground(
                child: Container(
                    alignment: Alignment.center,
                    child: Container(
                        alignment: Alignment.center,
                        width: size.width > 600 ? 600 : null,
                        constraints: BoxConstraints(maxWidth: 600),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red)),
                        child: NewBackground(
                            // height: size.height*0.9,
                            child: SafeArea(
                          child: imageUrls.isEmpty
                              ? const Center(
                                  child:
                                      Text("Aucune image pour ce catalogue."))
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            icon: Icon(
                                              Icons.chevron_left,
                                              size: 40,
                                              color: _currentPage == 0
                                                  ? Colors.grey
                                                  : Colors.white,
                                            ),
                                            onPressed: _currentPage > 0
                                                ? () =>
                                                    _goToPage(_currentPage - 1)
                                                : null,
                                          ),
                                          Container(
                                            width: 600 * 0.7,
                                            child: Expanded(
                                              child: PageView.builder(
                                                controller: _pageController,
                                                itemCount: imageUrls.length,
                                                onPageChanged: (index) {
                                                  setState(() {
                                                    _currentPage = index;
                                                  });
                                                },
                                                itemBuilder: (context, index) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Image.network(
                                                      imageUrls[index],
                                                      // fit: BoxFit.fill,
                                                      // width: double.infinity,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.chevron_right,
                                                size: 40,
                                                color: _currentPage ==
                                                        imageUrls.length - 1
                                                    ? Colors.grey
                                                    : Colors.white),
                                            onPressed: _currentPage <
                                                    imageUrls.length - 1
                                                ? () =>
                                                    _goToPage(_currentPage + 1)
                                                : null,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          tooltip: 'First',
                                          icon: Icon(
                                            Icons.first_page,
                                            color: _currentPage == 0
                                                ? Colors.grey
                                                : Colors.white,
                                          ),
                                          onPressed: _currentPage == 0
                                              ? null
                                              : () => _goToPage(0),
                                        ),
                                        IconButton(
                                          tooltip: 'Previous',
                                          icon: Icon(
                                            Icons.chevron_left,
                                            color: _currentPage == 0
                                                ? Colors.grey
                                                : Colors.white,
                                          ),
                                          onPressed: _currentPage == 0
                                              ? null
                                              : () =>
                                                  _goToPage(_currentPage - 1),
                                        ),
                                        Text(
                                          'Page ${_currentPage + 1} sur ${imageUrls.length}',
                                          style: GoogleFonts.lexend(
                                            color: Colors.white,
                                            fontSize: 15,
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          tooltip: 'Next',
                                          icon: Icon(
                                            Icons.chevron_right,
                                            color: _currentPage ==
                                                    imageUrls.length - 1
                                                ? Colors.grey
                                                : Colors.white,
                                          ),
                                          onPressed: _currentPage ==
                                                  imageUrls.length - 1
                                              ? null
                                              : () =>
                                                  _goToPage(_currentPage + 1),
                                        ),
                                        IconButton(
                                          tooltip: 'Last',
                                          icon: Icon(
                                            Icons.last_page,
                                            color: _currentPage ==
                                                    imageUrls.length - 1
                                                ? Colors.grey
                                                : Colors.white,
                                          ),
                                          onPressed: _currentPage ==
                                                  imageUrls.length - 1
                                              ? null
                                              : () => _goToPage(
                                                  imageUrls.length - 1),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: size.width,
                                        height: 40,
                                        color: Colors.grey,
                                        child: const Center(
                                          child: Text("ADS"),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                        )))))
            : NewBackground(
                // height: size.height*0.9,
                child: SafeArea(
                child: imageUrls.isEmpty
                    ? const Center(
                        child: Text("Aucune image pour ce catalogue."))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.chevron_left,
                                    size: 40,
                                    color: _currentPage == 0
                                        ? Colors.grey
                                        : Colors.white,
                                  ),
                                  onPressed: _currentPage > 0
                                      ? () => _goToPage(_currentPage - 1)
                                      : null,
                                ),
                                Container(
                                  width: size.width * 0.7,
                                  child: Expanded(
                                    child: PageView.builder(
                                      controller: _pageController,
                                      itemCount: imageUrls.length,
                                      onPageChanged: (index) {
                                        setState(() {
                                          _currentPage = index;
                                        });
                                      },
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(
                                            imageUrls[index],
                                            fit: BoxFit.scaleDown,
                                            width: double.infinity,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.chevron_right,
                                      size: 40,
                                      color:
                                          _currentPage == imageUrls.length - 1
                                              ? Colors.grey
                                              : Colors.white),
                                  onPressed: _currentPage < imageUrls.length - 1
                                      ? () => _goToPage(_currentPage + 1)
                                      : null,
                                ),
                              ],
                            ),
                          ),
                          // Navigation buttons
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                tooltip: 'First',
                                icon: Icon(
                                  Icons.first_page,
                                  color: _currentPage == 0
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                                onPressed: _currentPage == 0
                                    ? null
                                    : () => _goToPage(0),
                              ),
                              IconButton(
                                tooltip: 'Previous',
                                icon: Icon(
                                  Icons.chevron_left,
                                  color: _currentPage == 0
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                                onPressed: _currentPage == 0
                                    ? null
                                    : () => _goToPage(_currentPage - 1),
                              ),
                              Text(
                                'Page ${_currentPage + 1} sur ${imageUrls.length}',
                                style: GoogleFonts.lexend(
                                  color: Colors.white,
                                  fontSize: 15,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                tooltip: 'Next',
                                icon: Icon(
                                  Icons.chevron_right,
                                  color: _currentPage == imageUrls.length - 1
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                                onPressed: _currentPage == imageUrls.length - 1
                                    ? null
                                    : () => _goToPage(_currentPage + 1),
                              ),
                              IconButton(
                                tooltip: 'Last',
                                icon: Icon(
                                  Icons.last_page,
                                  color: _currentPage == imageUrls.length - 1
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                                onPressed: _currentPage == imageUrls.length - 1
                                    ? null
                                    : () => _goToPage(imageUrls.length - 1),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          //  Ads space
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: size.width,
                              height: 40,
                              color: Colors.grey,
                              child: const Center(
                                child: Text("ADS"),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
              )));
  }
}
