
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shazam/utils/models/music_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key, required this.musicModel});

  final MusicModel musicModel;

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> with SingleTickerProviderStateMixin {


  /// Audio Controller
  AudioPlayer audioPlayer = AudioPlayer();
  bool isAudioPlaying = false;

  /// Animation controller
  late AnimationController _animationController;

  /// Open Url or References
  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }


  @override
  void initState() {
    super.initState();

    /// Animated controller init
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 450));

    /// Audio player init
    audioPlayer.play(UrlSource(widget.musicModel.audioUri));
    setState(() {
      isAudioPlaying = true;
    });
  }


  @override
  void dispose() {
    audioPlayer.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [

          /// Music background Image in sliver appbar
          SliverAppBar(
            expandedHeight: 400.0,
            flexibleSpace: FlexibleSpaceBar(

              /// Title of Music
              title: Text(widget.musicModel.subtitle + " - " + widget.musicModel.title),
              centerTitle: false,
              titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              background: Container(
                decoration: BoxDecoration(

                  /// Background Image
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.musicModel.backgroundImage
                    ),
                    fit: BoxFit.cover
                  )
                ),

                /// Gradient
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Color(0xff4d194d),
                      ],
                    )
                  ),
                ),
              )
            ),
          ),

          /// Other Information
          SliverList(
            delegate: SliverChildListDelegate([

              /// Audio Player
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Image and Play button
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [

                        /// Play button
                        GestureDetector(
                          onTap: isAudioPlaying ? () {
                            audioPlayer.pause();
                            _animationController.forward();
                            setState(() {
                              isAudioPlaying = false;
                            });
                          } : () {
                            audioPlayer.resume();
                            _animationController.reverse();
                            setState(() {
                              isAudioPlaying = true;
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                  widget.musicModel.image
                                )
                              )
                            ),
                            child: Center(
                              child: AnimatedIcon(
                                icon: AnimatedIcons.pause_play,
                                progress: _animationController,
                                color: Colors.white,
                                size: 30,
                              ),
                            )
                          ),
                        )
                      ],
                    ),
                  ),

                  /// Music Information
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        /// Name of music
                        Text(
                          widget.musicModel.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 15),

                        /// Artist
                        Text(
                          "Artist: " + widget.musicModel.subtitle,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                          ),
                        ),

                        /// Album
                        Text(
                          "Album: " + widget.musicModel.album,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 13),

                        /// Release year
                        Text(
                          "Release: " + widget.musicModel.release,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),

                      ],
                    ),
                  )

                ],
              ),
              
              /// References
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    /// Spotify
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _launchURL(widget.musicModel.spotifyUri);
                      },
                      child: const CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(
                          "assets/icons/spotify.png"
                        ),
                      ),
                    ),

                    /// Deezer
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _launchURL(widget.musicModel.deezerUri);
                      },
                      child: const CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(
                            "assets/icons/deezer.png"
                        ),
                      ),
                    ),

                    /// Shazam
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _launchURL(widget.musicModel.shazamUri);
                      },
                      child: const CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage(
                            "assets/icons/shazam.png"
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ]),
          ),

          /// Adaptive To Lyrics
          SliverToBoxAdapter(
            child: SizedBox(
              height: 70,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Проведите вверх чтоб увидеть текст",
                      style: TextStyle(
                          color: Colors.white60
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_up_rounded,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),

          /// Lyrics
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.musicModel.lyrics[index],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              },
              childCount: widget.musicModel.lyrics.length
            )
          ),

          /// Footer
          SliverList(delegate: SliverChildListDelegate([
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                widget.musicModel.lyricsAuthor,
                style: const TextStyle(
                  color: Colors.white70
                ),
              ),
            )
          ]))


        ],
      )
    );
  }
}
