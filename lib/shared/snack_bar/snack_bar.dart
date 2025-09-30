import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/colors.dart';

ShowSuccesSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Container(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            const Icon(
              Icons.check_circle_rounded,
              color: ErrorColor.success,
              size: 30,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.ibmPlexSansArabic(
                    color: ErrorColor.success,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  },
                  icon: const Icon(
                    CupertinoIcons.xmark,
                    size: 20,
                  )),
            )
          ],
        )),
    behavior: SnackBarBehavior.floating,
    backgroundColor: const Color(0xffEEF6F1),
    shape: RoundedRectangleBorder(
      side: const BorderSide(width: 1.5, color: ErrorColor.success),
      borderRadius: BorderRadius.circular(8),
    ),
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 220, right: 20, left: 20),
  ));
}

ShowErrorSnackBar(
  BuildContext context,
  String message,
) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Container(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            const Icon(
              Icons.cancel,
              color: ErrorColor.error,
              size: 30,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Text(
                message,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.ibmPlexSansArabic(
                    color: ErrorColor.error,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              height: 30,
              width: 30,
              child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  },
                  icon: const Icon(
                    CupertinoIcons.xmark,
                    size: 20,
                  )),
            )
          ],
        )),
    behavior: SnackBarBehavior.floating,
    backgroundColor: const Color(0xffF6EEEE),
    shape: RoundedRectangleBorder(
      side: const BorderSide(width: 1.5, color: ErrorColor.error),
      borderRadius: BorderRadius.circular(8),
    ),
    margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height - 220, right: 20, left: 20),
  ));
}
