import '/util/common/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

//loading indicator code is a modified and simplified version of this code
//https://github.com/fayaz07/ots

final tKey = GlobalKey(debugLabel: 'overlay_parent');

/// Updates with the latest [OverlayEntry] child
late OverlayEntry _loaderEntry;

/// is dark theme
bool isDarkTheme = false;

/// To keep track if the [Overlay] is shown
bool _loaderShown = false;

class Loading extends StatelessWidget {
  final Widget? child;
  final bool darkTheme;

  const Loading({Key? key, this.child, this.darkTheme = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    isDarkTheme = darkTheme;
    return SizedBox(
      key: tKey,
      child: child,
    );
  }
}

OverlayState? get _overlayState {
  final context = tKey.currentContext;
  if (context == null) return null;

  NavigatorState? navigator;

  void visitor(Element element) {
    if (navigator != null) return;

    if (element.widget is Navigator) {
      navigator = (element as StatefulElement).state as NavigatorState;
    } else {
      element.visitChildElements(visitor);
    }
  }

  // ignore: unused_element
  context.visitChildElements(visitor);

  assert(navigator != null, '''unable to show overlay''');
  return navigator!.overlay;
}

/// To handle a loader for the application
Future<void> showLoadingIndicator(
    {bool isModal = false, Color? modalColor}) async {
  try {
    debugPrint('Showing loading overlay');
    final _child = Center(
      child: SizedBox(
        child: CircularProgressIndicator(),
        /*(Platform.isAndroid
                ? CircularProgressIndicator()
                : CupertinoActivityIndicator()),*/
        width: 30,
        height: 30,
      ),
    );
    await _showOverlay(
      child: isModal
          ? Stack(
        children: <Widget>[
          ModalBarrier(
            color: modalColor,
          ),
          _child
        ],
      )
          : _child,
    );
  } catch (err) {
    debugPrint('Exception showing loading overlay\n${err.toString()}');
    throw err;
  }
}

Future<void> hideLoadingIndicator() async {
  try {
    debugPrint('Hiding loading overlay');
    await _hideOverlay();
  } catch (err) {
    debugPrint('Exception hiding loading overlay');
    throw err;
  }
}

///----------------------------------------------------------------------------
/// These methods deal with showing and hiding the overlay
Future<void> _showOverlay({required Widget child}) async {
  try {
    final overlay = _overlayState;

    if (_loaderShown) {
      debugPrint('An overlay is already showing');
      return Future.value(false);
    }

    final overlayEntry = OverlayEntry(
      builder: (context) => child,
    );

    overlay?.insert(overlayEntry);
    _loaderEntry = overlayEntry;
    _loaderShown = true;
  } catch (err) {
    debugPrint('Exception inserting loading overlay\n${err.toString()}');
    throw err;
  }
}

Future<void> _hideOverlay() async {
  try {
    _loaderEntry.remove();
    _loaderShown = false;
  } catch (err) {
    debugPrint('Exception removing loading overlay\n${err.toString()}');
    throw err;
  }
}


// toast ======================================================================

class _ToastAnimatedWidget extends StatefulWidget {
  _ToastAnimatedWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _ToastWidgetState createState() => _ToastWidgetState();
}

class Toast {
  static void show(String msg,{
    Color textColor = Colors.black87,
    Color backgroundColor = Colors.grey,
    double borderRadius = 20,
  }) {
    dismiss();
    Toast._createView(msg, textColor, backgroundColor, borderRadius);
  }

  static late OverlayEntry _overlayEntry;
  static bool isVisible = false;

  static void _createView(String msg,
      Color textColor,
      Color backgroundColor,
      double borderRadius) async {

    var overlayState = _overlayState;
    _overlayEntry = new OverlayEntry(
      builder: (BuildContext context) => _ToastAnimatedWidget(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: buildToastUI(context, msg, textColor, backgroundColor, borderRadius),
        ),
      ),
    );
    isVisible = true;
    overlayState?.insert(_overlayEntry);
  }

  static Container buildToastUI(
      BuildContext context,
      String msg,
      Color textColor,
      Color backgroundColor,
      double borderRadius) {

    return Container(
        alignment: Alignment.center,
        // width: MediaQuery.of(context).size.width,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(size(borderRadius)),
          ),
          // margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Text(
            msg,
            // softWrap: true,
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
                fontSize: size(20),
                fontWeight: FontWeight.w600,
                color: textColor,
                decoration: TextDecoration.none
            ),
          ),
        )
    );
  }

  static dismiss() async {
    if (!isVisible) {
      return;
    }
    isVisible = false;
    _overlayEntry.remove();
  }
}

class _ToastWidgetState extends State<_ToastAnimatedWidget>
    with SingleTickerProviderStateMixin {

  // bool get _isVisible => true; //update this value later
  bool get _isVisible => Toast.isVisible;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((context) {
      if (this.mounted) {
        Future.delayed(Duration(seconds: 2), () {
          Toast.dismiss();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 50,
        child: AnimatedOpacity(
          // duration: Duration(seconds: 2),
          duration: const Duration(milliseconds: 500),
          opacity: _isVisible ? 1.0 : 0.0,
          child: widget.child,
        )
    );
  }
}