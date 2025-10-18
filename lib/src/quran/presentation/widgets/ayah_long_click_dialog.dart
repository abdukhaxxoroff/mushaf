// part of '/quran.dart';
//
// final greenHighLightColor = 0xFFc7e372;
// final yellowHighLightColor = 0xFFffc701;
// final redHighLightColor = 0xFFef5a68;
// final blueHighLightColor = 0xFF9ad0dc;
//
// /// A dialog displayed on long click of an Ayah to provide options like bookmarking and copying text.
// ///
// /// This widget shows a dialog at a specified position with options to bookmark the Ayah in different colors
// /// or copy the Ayah text to the clipboard. The appearance and behavior are influenced by the state of QuranCtrl.
// class AyahLongClickDialog extends StatelessWidget {
//   /// Creates a dialog displayed on long click of an Ayah to provide options like bookmarking and copying text.
//   ///
//   /// This widget shows a dialog at a specified position with options to bookmark the Ayah in different colors
//   /// or copy the Ayah text to the clipboard. The appearance and behavior are influenced by the state of QuranCtrl.
//   const AyahLongClickDialog({
//     required this.context,
//     super.key,
//     this.ayah,
//     // this.ayahFonts,
//     required this.position,
//     required this.index,
//     required this.pageIndex,
//     this.anotherMenuChild,
//     this.anotherMenuChildOnTap,
//     required this.isDark,
//     this.secondMenuChild,
//     this.secondMenuChildOnTap,
//   });
//
//   /// The AyahModel that is the target of the long click event.
//   ///
//   /// This is for the original fonts.
//   final AyahModel? ayah;
//
//   /// The AyahFontsModel that is the target of the long click event.
//   ///
//   /// This is for the downloaded fonts.
//   // final AyahFontsModel? ayahFonts;
//
//   /// The position where the dialog should appear on the screen.
//   ///
//   /// This is typically the position of the long click event.
//   final Offset position;
//   final int index;
//   final int pageIndex;
//   final Widget? anotherMenuChild;
//   final Widget? secondMenuChild;
//   final void Function(AyahModel ayah)? anotherMenuChildOnTap;
//   final void Function(AyahModel ayah)? secondMenuChildOnTap;
//   final BuildContext context;
//   final bool isDark;
//
//   @override
//   Widget build(BuildContext context) {
//     // الحصول على أبعاد الشاشة والهوامش الآمنة / Get screen dimensions and safe area
//     final screenSize = MediaQuery.of(context).size;
//     final padding = MediaQuery.of(context).padding;
//
//     // حساب العرض الفعلي للحوار بناءً على المحتوى / Calculate actual dialog width based on content
//     int itemsCount =
//         4; // عدد الأيقونات الأساسية (3 ألوان + نسخ + تفسير) / Basic icons count
//     if (anotherMenuChild != null) {
//       itemsCount += 1; // إضافة عنصر إضافي / Additional item
//     }
//     if (secondMenuChild != null) {
//       itemsCount += 1; // إضافة عنصر إضافي / Additional item
//     }
//     double dialogWidth =
//         (itemsCount * 40) +
//         (itemsCount * 16) +
//         40; // عرض كل أيقونة + التباعد + الهوامش / Icon width + spacing + margins
//     double dialogHeight = 80; // ارتفاع الحوار / Dialog height
//
//     // حساب الموضع الأفقي مع التأكد من البقاء داخل الشاشة / Calculate horizontal position ensuring it stays within screen
//     double left = position.dx - (dialogWidth / 2);
//
//     // التحقق من الحواف اليسرى واليمنى / Check left and right edges
//     if (left < padding.left + 10) {
//       left = padding.left + 10; // هامش من الحافة اليسرى / Left margin
//     } else if (left + dialogWidth > screenSize.width - padding.right - 10) {
//       left =
//           screenSize.width -
//           padding.right -
//           dialogWidth -
//           10; // هامش من الحافة اليمنى / Right margin
//     }
//
//     // حساب الموضع العمودي مع التأكد من البقاء داخل الشاشة / Calculate vertical position ensuring it stays within screen
//     double top =
//         position.dy -
//         dialogHeight +
//         10; // زيادة المسافة إلى 10 بكسل / Increase distance to 10 pixels
//
//     // التحقق من الحافة العلوية / Check top edge
//     if (top < padding.top + 10) {
//       top =
//           position.dy +
//           10; // إظهار الحوار تحت النقر مع مسافة أقل / Show dialog below tap with less distance
//     }
//
//     // التحقق من الحافة السفلية / Check bottom edge
//     if (top + dialogHeight > screenSize.height - padding.bottom - 10) {
//       top =
//           screenSize.height -
//           padding.bottom -
//           dialogHeight -
//           10; // هامش من الحافة السفلى / Bottom margin
//     }
//
//     return Positioned(
//       top: top,
//       left: left,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: const BorderRadius.all(Radius.circular(8.0)),
//           color: AppColors.getBackgroundColor(isDark),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withValues(alpha: 0.3),
//               blurRadius: 10,
//               spreadRadius: 5,
//               offset: const Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
//           margin: const EdgeInsets.all(4.0),
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.all(Radius.circular(6.0)),
//             // border: Border.all(width: 2, color: Colors.teal.shade100),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               ...[
//                 greenHighLightColor,
//                 yellowHighLightColor,
//                 redHighLightColor,
//                 blueHighLightColor,
//               ].map(
//                 (colorCode) => Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                   child: GestureDetector(
//                     onTap: () {
//                       if (QuranCtrl.instance.state.fontsSelected.value == 1 ||
//                           QuranCtrl.instance.state.fontsSelected.value == 2 ||
//                           QuranCtrl.instance.state.scaleFactor.value > 1.3) {
//                         BookmarksCtrl.instance.saveBookmark(
//                           surahName: QuranCtrl.instance
//                               .getSurahDataByAyah(ayah!)
//                               .arabicName,
//                           ayahNumber: ayah!.ayahNumber,
//                           ayahId: ayah!.ayahUQNumber,
//                           page: ayah!.page,
//                           colorCode: colorCode,
//                         );
//                       } else {
//                         BookmarksCtrl.instance.saveBookmark(
//                           surahName: ayah!.arabicName!,
//                           ayahNumber: ayah!.ayahNumber,
//                           ayahId: ayah!.ayahUQNumber,
//                           page: ayah!.page,
//                           colorCode: colorCode,
//                         );
//                       }
//                       QuranCtrl.instance.state.overlayEntry?.remove();
//                       QuranCtrl.instance.state.overlayEntry = null;
//                     },
//                     child: Icon(Icons.circle, color: Color(colorCode)),
//                   ),
//                 ),
//               ),
//               context.verticalDivider(height: 30, color: Colors.black12),
//               GestureDetector(
//                 onTap: () {
//                   if (QuranCtrl.instance.state.fontsSelected.value == 1) {
//                     Clipboard.setData(ClipboardData(text: ayah!.text));
//                     HapticFeedback.mediumImpact();
//                   } else {
//                     Clipboard.setData(
//                       ClipboardData(
//                         text: QuranCtrl
//                             .instance
//                             .staticPages[ayah!.page - 1]
//                             .ayahs
//                             .firstWhere(
//                               (element) =>
//                                   element.ayahUQNumber == ayah!.ayahUQNumber,
//                             )
//                             .text,
//                       ),
//                     );
//                     HapticFeedback.mediumImpact();
//                   }
//                   QuranCtrl.instance.state.overlayEntry?.remove();
//                   QuranCtrl.instance.state.overlayEntry = null;
//                 },
//                 child: const Icon(Icons.copy, color: Colors.black),
//               ),
//               // context.verticalDivider(height: 30, color: Colors.teal.shade100),
//               // GestureDetector(
//               //   onTap: () {
//               //     showTafsirOnTap(
//               //       context: context,
//               //       isDark: isDark,
//               //       ayahNum: (QuranCtrl.instance.state.fontsSelected.value ==
//               //                   1 ||
//               //               QuranCtrl.instance.state.fontsSelected.value == 2 ||
//               //               QuranCtrl.instance.state.scaleFactor.value > 1.3)
//               //           ? ayah!.ayahNumber
//               //           : ayah!.ayahNumber,
//               //       pageIndex: pageIndex,
//               //       ayahUQNum: (QuranCtrl.instance.state.fontsSelected.value ==
//               //                   1 ||
//               //               QuranCtrl.instance.state.fontsSelected.value == 2 ||
//               //               QuranCtrl.instance.state.scaleFactor.value > 1.3)
//               //           ? ayah!.ayahUQNumber
//               //           : ayah!.ayahUQNumber,
//               //       ayahNumber: (QuranCtrl.instance.state.fontsSelected.value ==
//               //                   1 ||
//               //               QuranCtrl.instance.state.fontsSelected.value == 2 ||
//               //               QuranCtrl.instance.state.scaleFactor.value > 1.3)
//               //           ? ayah!.ayahNumber
//               //           : ayah!.ayahNumber,
//               //       tafsirStyle: TafsirStyle(
//               //         backgroundColor: AppColors.getBackgroundColor(isDark),
//               //         tafsirNameWidget: Text(
//               //           'التفسير',
//               //           style: QuranLibrary().cairoStyle.copyWith(
//               //                 fontSize: 20,
//               //                 fontWeight: FontWeight.bold,
//               //                 color: isDark ? Colors.white : Colors.black,
//               //               ),
//               //         ),
//               //         fontSizeWidget: fontSizeDropDown(
//               //           height: 30.0,
//               //           isDark: isDark,
//               //         ),
//               //       ),
//               //     );
//               //     QuranCtrl.instance.state.overlayEntry?.remove();
//               //     QuranCtrl.instance.state.overlayEntry = null;
//               //   },
//               //   child: const Icon(
//               //     Icons.text_snippet_rounded,
//               //     color: Colors.teal,
//               //   ),
//               // ),
//               anotherMenuChild != null
//                   ? context.verticalDivider(
//                       height: 30,
//                       color: Colors.teal.shade100,
//                     )
//                   : const SizedBox(),
//               anotherMenuChild != null
//                   ? GestureDetector(
//                       onTap: () {
//                         if (anotherMenuChildOnTap != null) {
//                           anotherMenuChildOnTap!(ayah!);
//                         }
//                         QuranCtrl.instance.state.overlayEntry?.remove();
//                         QuranCtrl.instance.state.overlayEntry = null;
//                       },
//                       child: anotherMenuChild ?? const SizedBox(),
//                     )
//                   : const SizedBox(),
//               secondMenuChild != null
//                   ? context.verticalDivider(
//                       height: 30,
//                       color: Colors.teal.shade100,
//                     )
//                   : const SizedBox(),
//               secondMenuChild != null
//                   ? GestureDetector(
//                       onTap: () {
//                         if (secondMenuChildOnTap != null) {
//                           secondMenuChildOnTap!(ayah!);
//                         }
//                         QuranCtrl.instance.state.overlayEntry?.remove();
//                         QuranCtrl.instance.state.overlayEntry = null;
//                       },
//                       child: secondMenuChild ?? const SizedBox(),
//                     )
//                   : const SizedBox(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
part of '/quran.dart';

final greenHighLightColor = 0xFFc7e372;
final yellowHighLightColor = 0xFFffc701;
final redHighLightColor = 0xFFef5a68;
final blueHighLightColor = 0xFF9ad0dc;

/// An iOS-style context menu shown when long-pressing an Ayah.
///
/// Uses CupertinoContextMenu to display actions like bookmarking and copying text,
/// matching native iOS behavior.
class AyahLongClickDialog extends StatelessWidget {
  const AyahLongClickDialog({
    required this.context,
    super.key,
    this.ayah,
    required this.position,
    required this.index,
    required this.pageIndex,
    this.anotherMenuChild,
    this.anotherMenuChildOnTap,
    required this.isDark,
    this.secondMenuChild,
    this.secondMenuChildOnTap,
  });

  final AyahModel? ayah;
  final Offset position;
  final int index;
  final int pageIndex;
  final Widget? anotherMenuChild;
  final Widget? secondMenuChild;
  final void Function(AyahModel ayah)? anotherMenuChildOnTap;
  final void Function(AyahModel ayah)? secondMenuChildOnTap;
  final BuildContext context;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    const double dialogWidth = 240;
    final double dialogHeight = _calcDialogHeight();

    double left = position.dx - (dialogWidth / 2);
    if (left < padding.left + 10) left = padding.left + 10;
    if (left + dialogWidth > screenSize.width - padding.right - 10) {
      left = screenSize.width - padding.right - dialogWidth - 10;
    }

    double top = position.dy - dialogHeight - 10;
    if (top < padding.top + 10) top = position.dy + 10;
    if (top + dialogHeight > screenSize.height - padding.bottom - 10) {
      top = screenSize.height - padding.bottom - dialogHeight - 10;
    }

    return Positioned(
      top: top,
      left: left,
      child: Material(
        color: Colors.transparent,
        child: AnimatedScale(
          scale: 1.0,
          duration: const Duration(milliseconds: 120),
          curve: Curves.easeOut,
          child: Container(
            width: dialogWidth,
            decoration: BoxDecoration(
              color: AppColors.getBackgroundColor(isDark),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _menuItem(
                  context,
                  icon: Icons.circle,
                  color: Color(greenHighLightColor),
                  label: "Green",
                  onTap: () => _saveBookmark(greenHighLightColor),
                ),
                _divider(),
                _menuItem(
                  context,
                  icon: Icons.circle,
                  color: Color(yellowHighLightColor),
                  label: "Yellow",
                  onTap: () => _saveBookmark(yellowHighLightColor),
                ),
                _divider(),
                _menuItem(
                  context,
                  icon: Icons.circle,
                  color: Color(redHighLightColor),
                  label: "Red",
                  onTap: () => _saveBookmark(redHighLightColor),
                ),
                _divider(),
                _menuItem(
                  context,
                  icon: Icons.circle,
                  color: Color(blueHighLightColor),
                  label: "Blue",
                  onTap: () => _saveBookmark(blueHighLightColor),
                ),
                _divider(),
                _menuItem(
                  context,
                  icon: CupertinoIcons.doc_on_clipboard_fill,
                  color: isDark ? Colors.white : Colors.black87,
                  label: "Copy",
                  onTap: _copyAyah,
                ),
                if (anotherMenuChild != null) ...[
                  _divider(),
                  InkWell(
                    onTap: () {
                      anotherMenuChildOnTap?.call(ayah!);
                      _closeOverlay();
                    },
                    child: anotherMenuChild!,
                  ),
                ],
                if (secondMenuChild != null) ...[
                  _divider(),
                  InkWell(
                    onTap: () {
                      secondMenuChildOnTap?.call(ayah!);
                      _closeOverlay();
                    },
                    child: secondMenuChild!,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _calcDialogHeight() {
    // Each row ~52px height
    int count = 5;
    if (anotherMenuChild != null) count++;
    if (secondMenuChild != null) count++;
    return (count * 52) + ((count - 1) * 0.8);
  }

  Widget _divider() =>
      Container(height: 1, color: Colors.black.withOpacity(0.08));

  Widget _menuItem(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveBookmark(int colorCode) {
    BookmarksCtrl.instance.saveBookmark(
      surahName: ayah!.arabicName!,
      ayahNumber: ayah!.ayahNumber,
      ayahId: ayah!.ayahUQNumber,
      page: ayah!.page,
      colorCode: colorCode,
    );
    _closeOverlay();
  }

  void _copyAyah() {
    Clipboard.setData(ClipboardData(text: ayah!.text));
    HapticFeedback.mediumImpact();
    _closeOverlay();
  }

  void _closeOverlay() {
    QuranCtrl.instance.state.overlayEntry?.remove();
    QuranCtrl.instance.state.overlayEntry = null;
  }
}
