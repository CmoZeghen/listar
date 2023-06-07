import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:listar_flutter/api/api.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:listar_flutter/models/screen_models/filter_page_model.dart';
import 'package:listar_flutter/utils/utils.dart';
import 'package:listar_flutter/widgets/widget.dart';

enum TimeType { start, end }

class Filter extends StatefulWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  _FilterState createState() {
    return _FilterState();
  }
}

class _FilterState extends State<Filter> {
  final String _currency = String.fromCharCode(0x24);
  final FilterPageModel _filterPage = FilterPageModel.fromJson({
    "category": [
      "Architecture",
      "Insurance",
      "Beauty",
      "Artists",
      "Outdoors",
      "Clothing",
      "Jewelry",
      "Medical"
    ],
    "service": [
      "Free Wifi",
      "Shower",
      "Pet Allowed",
      "Shuttle Bus",
      "Supper Market",
      "Open 24/7",
    ]
  });
  final List<Color> _color = [
    const Color.fromRGBO(93, 173, 226, 1),
    const Color.fromRGBO(165, 105, 189, 1),
    const Color(0xffe5634d),
    const Color.fromRGBO(88, 214, 141, 1),
    const Color.fromRGBO(253, 198, 10, 1),
    const Color(0xffa0877e),
    const Color.fromRGBO(93, 109, 126, 1)
  ];
  TimeOfDay _startHour = const TimeOfDay(hour: 12, minute: 15);
  TimeOfDay _endHour = const TimeOfDay(hour: 18, minute: 10);
  RangeValues _rangeValues = const RangeValues(20, 80);
  List<LocationModel> _location = [];
  LocationModel? _locationSelected;
  LocationModel? _areaSelected;
  List _category = [];
  List _service = [];
  List<Color> _colorSelected = [];
  double _rate = 4;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///Load data
  void _loadData() async {
    final result = await Api.getLocationList();
    if (result.success) {
      final Iterable data = result.data['location'] ?? [];
      setState(() {
        _location = data.map((item) {
          return LocationModel.fromJson(item);
        }).toList();
      });
    }
  }

  ///Show Picker Time
  void _showTimePicker(BuildContext context, TimeType type) async {
    final picked = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (type == TimeType.start && picked != null) {
      setState(() {
        _startHour = picked;
      });
    }
    if (type == TimeType.end && picked != null) {
      setState(() {
        _endHour = picked;
      });
    }
  }

  ///On Filter location
  void _onLocation() async {
    final result = await Navigator.pushNamed(
      context,
      Routes.picker,
      arguments: PickerModel(
        title: Translate.of(context).translate('select_location'),
        selected: [_locationSelected],
        data: _location,
      ),
    );
    if (result != null && result is LocationModel) {
      setState(() {
        _locationSelected = result;
      });
    }
  }

  ///On Filter area
  void _onArea() async {
    final result = await Navigator.pushNamed(
      context,
      Routes.picker,
      arguments: PickerModel(
        title: Translate.of(context).translate('select_location'),
        selected: [_areaSelected],
        data: _location,
      ),
    );
    if (result != null && result is LocationModel) {
      setState(() {
        _areaSelected = result;
      });
    }
  }

  ///Build location title
  Widget _buildLocation() {
    if (_locationSelected != null) {
      return Text(
        _locationSelected!.title,
        style: Theme.of(context)
            .textTheme
            .caption!
            .copyWith(color: Theme.of(context).primaryColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
    return Text(
      Translate.of(context).translate(
        'select_location',
      ),
      style: Theme.of(context).textTheme.caption,
    );
  }

  ///Build area title
  Widget _buildArea() {
    if (_areaSelected != null) {
      return Text(
        _areaSelected!.title,
        style: Theme.of(context)
            .textTheme
            .caption!
            .copyWith(color: Theme.of(context).primaryColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      );
    }
    return Text(
      Translate.of(context).translate(
        'select_location',
      ),
      style: Theme.of(context).textTheme.caption,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translate.of(context).translate('filter'),
        ),
        actions: <Widget>[
          AppButton(
            Translate.of(context).translate('apply'),
            type: ButtonType.text,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  Translate.of(context).translate('category'),
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _filterPage.category.map((item) {
                    final bool selected = _category.contains(item);
                    return FilterChip(
                      padding: EdgeInsets.zero,
                      selected: selected,
                      label: Text(item),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onSelected: (value) {
                        selected ? _category.remove(item) : _category.add(item);
                        setState(() {
                          _category = _category;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('facilities'),
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _filterPage.service.map((item) {
                    final bool selected = _service.contains(item);
                    return FilterChip(
                      selected: selected,
                      label: Text(item),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onSelected: (value) {
                        selected ? _service.remove(item) : _service.add(item);
                        setState(() {
                          _service = _service;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _onLocation,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              Translate.of(context).translate('location'),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            _buildLocation(),
                          ],
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                        child: const Icon(
                          Icons.keyboard_arrow_right,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: _onArea,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              Translate.of(context).translate('area'),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            _buildArea(),
                          ],
                        ),
                      ),
                      RotatedBox(
                        quarterTurns: AppLanguage.isRTL() ? 2 : 0,
                        child: const Icon(
                          Icons.keyboard_arrow_right,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('price_range'),
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '$_currency 0',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    Text(
                      '$_currency 100',
                      style: Theme.of(context).textTheme.caption,
                    )
                  ],
                ),
                const SizedBox(height: 4),
                SizedBox(
                  height: 20,
                  child: RangeSlider(
                    min: 0,
                    max: 100,
                    values: _rangeValues,
                    onChanged: (range) {
                      setState(() {
                        _rangeValues = range;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      Translate.of(context).translate('avg_price'),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      '${_rangeValues.start.round()}$_currency- ${_rangeValues.end.round()}$_currency',
                      style: Theme.of(context).textTheme.subtitle2,
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('business_color'),
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: _color.map((item) {
                    Widget? icon;
                    final selected = _colorSelected.contains(item);
                    if (selected) {
                      icon = const Icon(
                        Icons.check,
                        color: Colors.white,
                      );
                    }
                    void onPress() {
                      if (selected) {
                        _colorSelected.remove(item);
                      } else {
                        _colorSelected.add(item);
                      }
                      setState(() {
                        _colorSelected = _colorSelected;
                      });
                    }

                    return InkWell(
                      onTap: onPress,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: item,
                        ),
                        child: icon,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('open_time'),
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              _showTimePicker(context, TimeType.start);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  Translate.of(context).translate(
                                    'start_time',
                                  ),
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${_startHour.hour}:${_startHour.minute}",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const VerticalDivider(),
                        const SizedBox(width: 8),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              _showTimePicker(context, TimeType.end);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  Translate.of(context).translate('end_time'),
                                  style: Theme.of(context).textTheme.caption,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${_endHour.hour}:${_endHour.minute}",
                                  style: Theme.of(context).textTheme.subtitle2,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  Translate.of(context).translate('rating'),
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                RatingBar.builder(
                  initialRating: _rate,
                  minRating: 1,
                  allowHalfRating: true,
                  unratedColor: Colors.amber.withAlpha(100),
                  itemCount: 5,
                  itemSize: 28.0,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {
                    setState(() {
                      _rate = value;
                    });
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
