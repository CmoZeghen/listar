import 'dart:async';

import 'package:flutter/material.dart';
import 'package:listar_flutter/utils/utils.dart';

class InputRecord extends StatefulWidget {
  final Function(String) onSend;
  const InputRecord({Key? key, required this.onSend}) : super(key: key);

  @override
  _InputRecordState createState() {
    return _InputRecordState();
  }
}

class _InputRecordState extends State<InputRecord> {
  bool _delete = false;
  bool _locking = false;
  bool _recording = false;
  int _time = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    openTheRecorder();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  ///Request permission
  Future<void> openTheRecorder() async {}

  ///Send Record
  void _onSave() async {
    await _onStop();
    widget.onSend('audio');
  }

  ///Save and Send record
  void _onRecord(_) async {
    setState(() {
      _recording = true;
    });
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          _time++;
        });
      },
    );
  }

  ///Save and Send record
  Future<void> _onStop() async {
    _timer?.cancel();
    setState(() {
      _recording = false;
      _time = 0;
      _locking = false;
      _delete = false;
    });
  }

  ///DragCompleted
  void _onDragCompleted() {
    if (_delete) {
      _onStop();
    }
  }

  ///Build Drag Button
  Widget _buildDragButton() {
    ///Locking state
    if (_locking) {
      return GestureDetector(
        onTap: _onSave,
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: Icon(
            Icons.done,
            size: 32,
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
    }

    ///Drag button
    Color? color;
    if (_recording) {
      color = Theme.of(context).primaryColor.withOpacity(0.2);
    }
    return Draggable<String>(
      data: 'drag',
      onDraggableCanceled: (_, __) {
        _onSave();
      },
      onDragCompleted: _onDragCompleted,
      child: GestureDetector(
        onTapDown: _onRecord,
        onTapUp: (_) {
          _onSave();
        },
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1,
              color: Theme.of(context).primaryColor,
            ),
            color: color,
          ),
          child: Icon(
            Icons.mic,
            size: 32,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      feedback: Container(),
      childWhenDragging: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 1,
            color: Theme.of(context).primaryColor,
          ),
          color: color,
        ),
        child: Icon(
          Icons.mic,
          size: 32,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  ///Build Record Info
  Widget _buildRecordInfo() {
    if (_recording) {
      Widget text = Text(
        Translate.of(context).translate('recording_msg'),
        style: Theme.of(context).textTheme.button,
      );
      if (_locking) {
        text = Text(
          Translate.of(context).translate('record_release_msg'),
          style: Theme.of(context).textTheme.button,
        );
      }
      final min = _time ~/ 60;
      final sec = _time % 60;
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
          ),
          const SizedBox(height: 4),
          text
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          Translate.of(context).translate('record_start_msg'),
          style: Theme.of(context).textTheme.button,
        )
      ],
    );
  }

  ///Build Trash Target
  Widget _buildTrashTarget() {
    if (_locking) {
      return GestureDetector(
        onTap: _onStop,
        child: SizedBox(
          width: 80,
          height: 80,
          child: Icon(
            Icons.delete_outline,
            size: 32,
            color: Theme.of(context).errorColor,
          ),
        ),
      );
    }
    if (_recording) {
      return DragTarget<String>(
        builder: (context, incoming, rejected) {
          Color? color;
          if (incoming.isNotEmpty) {
            color = Theme.of(context).errorColor;
          }
          return SizedBox(
            width: 80,
            height: 80,
            child: Icon(
              Icons.delete_outline,
              size: 32,
              color: color,
            ),
          );
        },
        onWillAccept: (data) => data == 'drag',
        onAccept: (data) {
          _delete = true;
        },
      );
    }

    return Container();
  }

  ///Build Lock Target
  Widget _buildLockTarget() {
    if (_recording && !_locking) {
      return DragTarget<String>(
        builder: (context, incoming, rejected) {
          Color? color;
          IconData icon = Icons.lock_open_outlined;
          if (incoming.isNotEmpty) {
            color = Theme.of(context).errorColor;
            icon = Icons.lock_outline_rounded;
          }
          return SizedBox(
            width: 80,
            height: 80,
            child: Icon(
              icon,
              size: 32,
              color: color,
            ),
          );
        },
        onWillAccept: (data) => data == 'drag',
        onAccept: (data) {
          setState(() {
            _locking = true;
          });
        },
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: _buildRecordInfo()),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: _buildTrashTarget(),
                ),
              ),
              _buildDragButton(),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: _buildLockTarget(),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: Container()),
      ],
    );
  }
}
