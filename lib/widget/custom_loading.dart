import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';


bool _isShowing = false;

BuildContext? _context, _dismissingContext;

Curve _insetAnimCurve = Curves.easeInOut;

class CustomLoading {
  _Body? _dialog;

  CustomLoading(BuildContext context) {
    _context = context;
  }

  bool isShowing() {
    return _isShowing;
  }

  Future<bool> hide() async {
    try {
      if (_isShowing) {
        _isShowing = false;
        Navigator.of(_dismissingContext!).pop();
        debugPrint('Loading dismissed');
        return Future.value(true);
      } else {
        debugPrint('Loading already dismissed');
        return Future.value(false);
      }
    } catch (err) {
      debugPrint('Seems there is an issue hiding loading');
      debugPrint(err.toString());
      return Future.value(false);
    }
  }

  Future<bool> show({required String content}) async {

    try {
      if (!_isShowing) {
        _dialog =  _Body();
        showDialog<dynamic>(
          context: _context!,
          barrierDismissible: false,
          builder: (_context) {
            _dismissingContext = _context;
            return WillPopScope(
              onWillPop: () async => false,
              child: Dialog(
                  backgroundColor: Colors.transparent,
                  insetAnimationCurve: _insetAnimCurve,
                  insetAnimationDuration: const Duration(milliseconds: 100),
                  elevation: 0.0,
                  child: _dialog),
            );
          },
        );

        debugPrint('Loading shown');
        _isShowing = true;
        return true;
      } else {
        debugPrint("Loading already shown/showing");
        return false;
      }
    } catch (err) {
      _isShowing = false;
      debugPrint('Exception while showing the loading');
      debugPrint(err.toString());
      return false;
    }
  }
}


class _Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).backgroundColor,
              child: Container(
                margin: const EdgeInsets.all(8),
                child: const SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent),
                  ),
                ),
              )),
          /* Container(
            margin: const EdgeInsets.only(
              top: defaultPaddingSize,
            ),
            child: Text("${Languages.of(context).loading}...",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
          ),*/
        ],
      ),
    );
  }
}
