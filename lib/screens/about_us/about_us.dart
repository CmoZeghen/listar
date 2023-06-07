import 'package:flutter/material.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/models/screen_models/screen_models.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/app_placeholder.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() {
    return _AboutUsState();
  }
}

class _AboutUsState extends State<AboutUs> {
  AboutUsPageModel? _aboutUsPage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Fetch API
  void _loadData() async {
    final result = await Api.getAboutUs();
    if (result.success) {
      setState(() {
        _aboutUsPage = AboutUsPageModel.fromJson(result.data);
      });
    }
  }

  ///Build Banner
  Widget _buildBanner() {
    if (_aboutUsPage?.banner == null) {
      return AppPlaceholder(
        child: Container(
          color: Colors.white,
        ),
      );
    }

    return Image.asset(
      _aboutUsPage!.banner,
      fit: BoxFit.cover,
    );
  }

  ///Build WhoWeAre
  Widget _buildWhoWeAre() {
    if (_aboutUsPage?.whoWeAre == null) {
      return AppPlaceholder(
          child: Column(
        children: [1, 2, 3, 4, 5].map((item) {
          return Container(
            height: 10,
            margin: const EdgeInsets.only(bottom: 4),
            color: Colors.white,
          );
        }).toList(),
      ));
    }

    return Text(
      _aboutUsPage!.whoWeAre,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }

  ///Build WhatWeD
  Widget _buildWhatWeDo() {
    if (_aboutUsPage?.whatWeDo == null) {
      return AppPlaceholder(
        child: Column(
          children: [1, 2, 3, 4, 5].map((item) {
            return Container(
              height: 15,
              margin: const EdgeInsets.only(bottom: 4),
              color: Colors.white,
            );
          }).toList(),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _aboutUsPage!.whatWeDo.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            item,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        );
      }).toList(),
    );
  }

  ///Build Team
  Widget _buildTeam() {
    if (_aboutUsPage?.team == null) {
      return AppPlaceholder(
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 16,
          children: [1, 2, 3, 4].map((item) {
            return FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                alignment: Alignment.bottomLeft,
                padding: const EdgeInsets.all(8),
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
              ),
            );
          }).toList(),
        ),
      );
    }

    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      runSpacing: 16,
      children: _aboutUsPage!.team.map((item) {
        return FractionallySizedBox(
          widthFactor: 0.5,
          child: Container(
            margin: const EdgeInsets.only(left: 16),
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(8),
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(item.image),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.level,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            centerTitle: true,
            title: Text(
              Translate.of(context).translate('about_us'),
            ),
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: _buildBanner(),
            ),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            Translate.of(context).translate('who_we_are'),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          _buildWhoWeAre(),
                          const SizedBox(height: 16),
                          Text(
                            Translate.of(context).translate('what_we_do'),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          _buildWhatWeDo(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16),
                      child: Text(
                        Translate.of(context).translate('meet_our_team'),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16, top: 8),
                      child: _buildTeam(),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
