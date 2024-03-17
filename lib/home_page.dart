import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:musify/view_song_page.dart';

class RecentPlayModel {
  RecentPlayModel({
    required this.title,
    required this.subtitle,
    required this.image,
  });

  final String title;
  final String subtitle;
  final Image image;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String id = 'home_page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _searchController = TextEditingController();

  final _albums = [
    Image.asset('assets/images/coldplay_album.png'),
    Image.asset('assets/images/post_malone_album.jpeg'),
    Image.asset('assets/images/lil_nasx_album.png'),
    Image.asset('assets/images/selena_gomez_album.png'),
    Image.asset('assets/images/walkofftheearth_album.jpg'),
  ];

  final _recentPlays = [
    RecentPlayModel(
      title: 'Thunder',
      subtitle: 'Imagine Dragons',
      image: Image.asset('assets/images/imagine_dragons.jpeg'),
    ),
    RecentPlayModel(
      title: 'Yummy',
      subtitle: 'Justine Bieber',
      image: Image.asset('assets/images/justine_bieber.jpeg'),
    ),
    RecentPlayModel(
      title: 'Save Your Tears',
      subtitle: 'Ariana Grande',
      image: Image.asset('assets/images/ariana_grande.png'),
    ),
    RecentPlayModel(
      title: 'Anti Hero',
      subtitle: 'Taylor Swift',
      image: Image.asset('assets/images/taylor_swift.jpeg'),
    ),
    RecentPlayModel(
      title: 'One Call Away',
      subtitle: 'Charlie Puth',
      image: Image.asset('assets/images/charlie_puth.png'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final smallTextStyle = Theme.of(context).textTheme.bodyMedium!;
    final mediumTextStyle = Theme.of(context).textTheme.bodyLarge!;
    final largeTextStyle = Theme.of(context).textTheme.headlineMedium!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hello there, Lex!',
                      style:
                          largeTextStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage('assets/images/lisa.jpeg'),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                TextField(
                  onSubmitted: (e) {},
                  cursorColor: Colors.black,
                  controller: _searchController,
                  style: mediumTextStyle,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.purple.shade50,
                    contentPadding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                    hintText: "Search album, song...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(IconlyLight.search),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Trending Albums',
                  style: largeTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 150,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _albums.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 16),
                    itemBuilder: (_, index) => SizedBox(
                      height: 150,
                      width: 150,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: _albums[index],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Recently Played',
                  style: largeTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _recentPlays.length,
                  itemBuilder: (_, index) {
                    final title = _recentPlays[index].title;
                    final subtitle = _recentPlays[index].subtitle;
                    final image = _recentPlays[index].image;

                    return ListTile(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ViewSongPage(),
                          )),
                      visualDensity: const VisualDensity(vertical: 3),
                      title: Text(
                        title,
                        style: mediumTextStyle.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        subtitle,
                        style: smallTextStyle,
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: image,
                      ),
                      trailing: const Icon(Icons.more_vert),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
