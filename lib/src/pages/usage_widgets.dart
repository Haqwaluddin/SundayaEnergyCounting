import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoom_get_coordinate/sizeConfig.dart';
import 'package:zoom_get_coordinate/src/pages/home_page.dart';

class UsageWidgets extends HomePage {
  UsageWidgets() {}

  Widget timeStampDay(newDt) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: SizeConfig.blockSizeHorizontal * 23.5,
            ),
            Column(
              children: <Widget>[
                Text(' 9 '),
                Container(
                  color: Colors.black,
                  child: VerticalDivider(
                    width: SizeConfig.blockSizeHorizontal * 0.5,
                    indent: 10,
                    endIndent: 15,
                  ),
                ),
              ],
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 14.5,
            ),
            Column(
              children: <Widget>[
                Text('15'),
                Container(
                  color: Colors.black,
                  child: VerticalDivider(
                    width: SizeConfig.blockSizeHorizontal * 0.5,
                    indent: 10,
                    endIndent: 15,
                  ),
                ),
              ],
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 14.5,
            ),
            Column(
              children: <Widget>[
                Text('21'),
                Container(
                  color: Colors.black,
                  child: VerticalDivider(
                    width: SizeConfig.blockSizeHorizontal * 0.5,
                    indent: 10,
                    endIndent: 15,
                  ),
                ),
              ],
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 14,
            ),
            Column(
              children: <Widget>[
                Text(' 4 '),
                Container(
                  color: Colors.black,
                  child: VerticalDivider(
                    width: SizeConfig.blockSizeHorizontal * 0.5,
                    indent: 10,
                    endIndent: 15,
                  ),
                ),
              ],
            ),
            Container(
              width: SizeConfig.blockSizeHorizontal * 14,
            ),
            Column(
              children: <Widget>[
                Text('9'),
                Container(
                  color: Colors.black,
                  child: VerticalDivider(
                    width: SizeConfig.blockSizeHorizontal * 0.5,
                    indent: 10,
                    endIndent: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: Divider(
                color: Colors.black,
                height: SizeConfig.blockSizeVertical * 0.2,
                thickness: SizeConfig.blockSizeHorizontal * 0.5,
                indent: SizeConfig.blockSizeHorizontal * 25,
                endIndent: SizeConfig.blockSizeVertical * 2,
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  width: SizeConfig.blockSizeHorizontal * 40,
                ),
                Text(
                  '$newDt',
                  // DateTime.now().toString(),
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                  ),
                  textScaleFactor: 1,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // Widget weekPeriodic() {
  //   return Column(
  //     children: <Widget>[
  //       Row(
  //         children: <Widget>[
  //           Container(
  //             width: SizeConfig.blockSizeHorizontal * 28.5,
  //           ),
  //           Column(
  //             children: <Widget>[
  //               Text(timestartweek.toString()),
  //               Container(
  //                 color: Colors.black,
  //                 child: VerticalDivider(
  //                   width: SizeConfig.blockSizeHorizontal * 0.5,
  //                   indent: 10,
  //                   endIndent: 15,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           // Text(timeendweek.toString()),
  //           // Text(timeendweek.toString()),
  //           // Text(timeendweek.toString()),
  //           // Text(timeendweek.toString()),
  //           (timeweeklist.length == 0)
  //               ? Container(
  //                   child: Text('kosong'),
  //                 )
  //               : (timeweeklist.length == 1)
  //                   ? Container(
  //                       child: Text(timeweeklist[0]),
  //                     )
  //                   : Container(
  //                       child: Row(
  //                         children: <Widget>[
  //                           Text(timeweeklist[0]),
  //                           Text(timeweeklist[1])
  //                         ],
  //                       ),
  //                     ),
  //           // ListView.builder(
  //           //   itemCount: timeweeklist.length,
  //           //   itemBuilder: (BuildContext context, int index) {
  //           //     final number = index + 1;
  //           //     final data = timeweeklist[index].toString();
  //           //     return Text(data);
  //           //   },
  //           // ),

  //           // Container(
  //           //   width: SizeConfig.blockSizeHorizontal*4,
  //           // ),

  //           //  Column(
  //           //    children: <Widget>[
  //           //      Text(timestartweek1+1.toString()),
  //           //      Container(
  //           //       color: Colors.black,
  //           //       child: VerticalDivider(
  //           //         width: SizeConfig.blockSizeHorizontal*0.5,
  //           //         indent: 10,
  //           //         endIndent: 15,
  //           //       ),
  //           // ),
  //           //    ],
  //           //  ),

  //           // space to the end
  //           // Container(
  //           //   width: SizeConfig.blockSizeHorizontal * 56.8,
  //           // ),

  //           Column(
  //             children: <Widget>[
  //               Text(timeendweek.toString()),
  //               Container(
  //                 color: Colors.black,
  //                 child: VerticalDivider(
  //                   width: SizeConfig.blockSizeHorizontal * 0.5,
  //                   indent: 10,
  //                   endIndent: 15,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //       Column(
  //         children: <Widget>[
  //           Container(
  //             child: Divider(
  //               color: Colors.black,
  //               height: SizeConfig.blockSizeVertical * 0.2,
  //               thickness: SizeConfig.blockSizeHorizontal * 0.5,
  //               indent: SizeConfig.blockSizeHorizontal * 30,
  //               endIndent: SizeConfig.blockSizeVertical * 4.5,
  //             ),
  //           ),
  //           Row(
  //             children: <Widget>[
  //               Container(
  //                 width: SizeConfig.blockSizeHorizontal * 50,
  //               ),
  //               Text(
  //                 timeweekstart.toString(),
  //                 // DateTime.now().toString(),
  //                 style: GoogleFonts.openSans(
  //                   fontSize: 20,
  //                 ),
  //                 textScaleFactor: 1,
  //               ),

  //               // Text(timeweekstart.toString())
  //             ],
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget weekPeriodic() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: SizeConfig.blockSizeHorizontal * 23.5,
            ),
            Column(
              children: <Widget>[
                Text(timestartweek.toString()),
                Container(
                  color: Colors.black,
                  child: VerticalDivider(
                    width: SizeConfig.blockSizeHorizontal * 0.5,
                    indent: 10,
                    endIndent: 15,
                  ),
                ),
              ],
            ),

            // start here
            (timeweeklist.length == 0)
                ? Container()
                : (timeweeklist.length == 2)
                    ? Container(
                        width: SizeConfig.blockSizeHorizontal * 19.0,
                      )
                    : Container(
                        width: SizeConfig.blockSizeHorizontal * 32.0,
                      ),
            (timeweeklist.length == 0)
                ? Container()
                : Column(
                    children: <Widget>[
                      Text(timeweeklist[0]),
                      Container(
                        color: Colors.black,
                        child: VerticalDivider(
                          width: SizeConfig.blockSizeHorizontal * 0.5,
                          indent: 10,
                          endIndent: 15,
                        ),
                      ),
                    ],
                  ),
            (timeweeklist.length == 0)
                ? Container()
                : Container(
                    width: SizeConfig.blockSizeHorizontal * 19.0,
                  ),
            (timeweeklist.length == 0)
                ? Container()
                : (timeweeklist.length == 2)
                    ? Column(
                        children: <Widget>[
                          Text(timeweeklist[1]),
                          Container(
                            color: Colors.black,
                            child: VerticalDivider(
                              width: SizeConfig.blockSizeHorizontal * 0.5,
                              indent: 10,
                              endIndent: 15,
                            ),
                          ),
                        ],
                      )
                    : Container(),

            // end here
            Container(
              width: (timeweeklist.length == 0)
                  ? SizeConfig.blockSizeHorizontal * 66.8
                  : (timeweeklist.length == 1)
                      ? SizeConfig.blockSizeHorizontal * 10.6
                      : SizeConfig.blockSizeHorizontal * 19.0,
            ),
            Column(
              children: <Widget>[
                Text(timeendweek.toString()),
                Container(
                  color: Colors.black,
                  child: VerticalDivider(
                    width: SizeConfig.blockSizeHorizontal * 0.5,
                    indent: 10,
                    endIndent: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: Divider(
                color: Colors.black,
                height: SizeConfig.blockSizeVertical * 0.2,
                thickness: SizeConfig.blockSizeHorizontal * 0.5,
                indent: SizeConfig.blockSizeHorizontal * 25,
                endIndent: SizeConfig.blockSizeVertical * 2,
              ),
            ),
            (timeweekstart.toString() != timeweekend.toString())
                ? Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          SizeConfig.blockSizeHorizontal * 25,
                          0,
                          SizeConfig.blockSizeHorizontal * 4,
                          0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(
                                timeweekstart.toString(),
                                style: GoogleFonts.openSans(
                                  fontSize: 20,
                                ),
                                textScaleFactor: 1,
                              ),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Container(
                              child: Align(
                                child: Text(
                                  timeweekend.toString(),
                                  style: GoogleFonts.openSans(
                                    fontSize: 20,
                                  ),
                                  textScaleFactor: 1,
                                ),
                                alignment: Alignment.centerRight,
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                  )
                : Row(
                    children: <Widget>[
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 50,
                      ),
                      Text(
                        timeweekend.toString(),
                        style: GoogleFonts.openSans(
                          fontSize: 20,
                        ),
                        textScaleFactor: 1,
                      ),
                      // Text(timeweekstart.toString())
                    ],
                  ),
          ],
        ),
      ],
    );
  }

  Widget dayPeriodic() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: SizeConfig.blockSizeHorizontal * 23.5,
            ),
            Column(
              children: <Widget>[
                Text(timestartday.toString()),
                Container(
                  color: Colors.black,
                  child: VerticalDivider(
                    width: SizeConfig.blockSizeHorizontal * 0.5,
                    indent: 10,
                    endIndent: 15,
                  ),
                ),
              ],
            ),

            // start here
            (timedaylist.length == 0)
                ? Container()
                : (timedaylist.length == 2)
                    ? Container(
                        width: SizeConfig.blockSizeHorizontal * 19.0,
                      )
                    : Container(
                        width: SizeConfig.blockSizeHorizontal * 32.0,
                      ),
            (timedaylist.length == 0)
                ? Container()
                : Column(
                    children: <Widget>[
                      Text(timedaylist[0]),
                      Container(
                        color: Colors.black,
                        child: VerticalDivider(
                          width: SizeConfig.blockSizeHorizontal * 0.5,
                          indent: 10,
                          endIndent: 15,
                        ),
                      ),
                    ],
                  ),
            (timedaylist.length == 0)
                ? Container()
                : Container(
                    width: SizeConfig.blockSizeHorizontal * 19.0,
                  ),
            (timedaylist.length == 0)
                ? Container()
                : (timedaylist.length == 2)
                    ? Column(
                        children: <Widget>[
                          Text(timedaylist[1]),
                          Container(
                            color: Colors.black,
                            child: VerticalDivider(
                              width: SizeConfig.blockSizeHorizontal * 0.5,
                              indent: 10,
                              endIndent: 15,
                            ),
                          ),
                        ],
                      )
                    : Container(),

            // end here
            Container(
              width: (timedaylist.length == 0)
                  ? SizeConfig.blockSizeHorizontal * 66.8
                  : (timedaylist.length == 1)
                      ? SizeConfig.blockSizeHorizontal * 10.6
                      : SizeConfig.blockSizeHorizontal * 19.0,
            ),
            Column(
              children: <Widget>[
                Text(timeendday.toString()),
                Container(
                  color: Colors.black,
                  child: VerticalDivider(
                    width: SizeConfig.blockSizeHorizontal * 0.5,
                    indent: 10,
                    endIndent: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: Divider(
                color: Colors.black,
                height: SizeConfig.blockSizeVertical * 0.2,
                thickness: SizeConfig.blockSizeHorizontal * 0.5,
                indent: SizeConfig.blockSizeHorizontal * 25,
                endIndent: SizeConfig.blockSizeVertical * 2,
              ),
            ),
            (timedaystart.toString() != timedayend.toString())
                ? Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          SizeConfig.blockSizeHorizontal * 25,
                          0,
                          SizeConfig.blockSizeHorizontal * 4,
                          0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(
                                timedaystart.toString(),
                                style: GoogleFonts.openSans(
                                  fontSize: 20,
                                ),
                                textScaleFactor: 1,
                              ),
                            ),
                            flex: 1,
                          ),
                          Expanded(
                            child: Container(
                              child: Align(
                                child: Text(
                                  timedayend.toString(),
                                  style: GoogleFonts.openSans(
                                    fontSize: 20,
                                  ),
                                  textScaleFactor: 1,
                                ),
                                alignment: Alignment.centerRight,
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ),
                  )
                : Row(
                    children: <Widget>[
                      Container(
                        width: SizeConfig.blockSizeHorizontal * 50,
                      ),
                      Text(
                        timedayend.toString(),
                        style: GoogleFonts.openSans(
                          fontSize: 20,
                        ),
                        textScaleFactor: 1,
                      ),
                      // Text(timeweekstart.toString())
                    ],
                  ),
          ],
        ),
      ],
    );
  }

  Widget hourPeriodic() {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: SizeConfig.blockSizeHorizontal * 23.5,
            ),
            Column(
              children: <Widget>[
                Text(timestarthour.toString()),
                Container(
                  color: Colors.black,
                  child: VerticalDivider(
                    width: SizeConfig.blockSizeHorizontal * 0.5,
                    indent: 10,
                    endIndent: 15,
                  ),
                ),
              ],
            ),

            // start here
            (timehourlist.length == 0)
                ? Container()
                : (timehourlist.length == 2)
                    ? Container(
                        width: SizeConfig.blockSizeHorizontal * 19.0,
                      )
                    : Container(
                        width: SizeConfig.blockSizeHorizontal * 32.0,
                      ),
            (timehourlist.length == 0)
                ? Container()
                : Column(
                    children: <Widget>[
                      Text(timehourlist[0]),
                      Container(
                        color: Colors.black,
                        child: VerticalDivider(
                          width: SizeConfig.blockSizeHorizontal * 0.5,
                          indent: 10,
                          endIndent: 15,
                        ),
                      ),
                    ],
                  ),
            (timehourlist.length == 0)
                ? Container()
                : Container(
                    width: SizeConfig.blockSizeHorizontal * 19.0,
                  ),
            (timehourlist.length == 0)
                ? Container()
                : (timehourlist.length == 2)
                    ? Column(
                        children: <Widget>[
                          Text(timehourlist[1]),
                          Container(
                            color: Colors.black,
                            child: VerticalDivider(
                              width: SizeConfig.blockSizeHorizontal * 0.5,
                              indent: 10,
                              endIndent: 15,
                            ),
                          ),
                        ],
                      )
                    : Container(),

            // end here
            Container(
              width: (timehourlist.length == 0)
                  ? SizeConfig.blockSizeHorizontal * 66.8
                  : (timehourlist.length == 1)
                      ? SizeConfig.blockSizeHorizontal * 10.6
                      : SizeConfig.blockSizeHorizontal * 19.0,
            ),
            Column(
              children: <Widget>[
                Text(timeendhour.toString()),
                Container(
                  color: Colors.black,
                  child: VerticalDivider(
                    width: SizeConfig.blockSizeHorizontal * 0.5,
                    indent: 10,
                    endIndent: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              child: Divider(
                color: Colors.black,
                height: SizeConfig.blockSizeVertical * 0.2,
                thickness: SizeConfig.blockSizeHorizontal * 0.5,
                indent: SizeConfig.blockSizeHorizontal * 25,
                endIndent: SizeConfig.blockSizeVertical * 2,
              ),
            ),
            Row(
              children: <Widget>[
                Container(
                  width: SizeConfig.blockSizeHorizontal * 50,
                ),
                Text(
                  timehour1.toString(),
                  // DateTime.now().toString(),
                  style: GoogleFonts.openSans(
                    fontSize: 20,
                  ),
                  textScaleFactor: 1,
                ),
                // Text(timeweekstart.toString())
              ],
            ),
          ],
        ),
      ],
    );
  }
}
