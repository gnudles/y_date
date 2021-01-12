/* This is free and unencumbered software released into the public domain.
 *
 * THIS SOFTWARE IS PROVIDED THE CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE CONTRIBUTORS BE LIABLE FOR ANY 
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; BUSINESS
 * INTERRUPTION; OR ANY SPIRITUAL DAMAGE) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

import 'dart:typed_data';
import 'hebrew_date.dart';
import 'abstract_date.dart';

enum JewishEvents {
  NO_EVENT,
  ROSH_HASHANA_A,
  ROSH_HASHANA_B,
  TZOM_GEDALIAH,
  EREV_YOM_KIPPUR,
  YOM_KIPPUR,
  SIMCHAT_COHEN,
  EREV_SUKKOT,
  SUKKOT,
  /**
     * Second day of galuyot of Sukkot.
     */
  SDOG_SUKKOT,
  SUKKOT_HOL_HAMOED,
  HOSHANA_RABBAH,
  SHEMINI_ATZERET,
  SIMCHAT_TORAH,
  SHEMINI_ATZERET_SIMCHAT_TORAH,
  HANUKKAH_ONE_CANDLE,
  HANUKKAH_TWO_CANDLES,
  HANUKKAH_THREE_CANDLES,
  HANUKKAH_FOUR_CANDLES,
  HANUKKAH_FIVE_CANDLES,
  HANUKKAH_SIX_CANDLES,
  HANUKKAH_SEVEN_CANDLES,
  HANUKKAH_EIGHT_CANDLES,
  TENTH_OF_TEVET,
  FIFTEEN_SHVAT,
  TAANIT_ESTHER,
  PURIM,
  SHUSHAN_PURIM,
  PURIM_MESHULASH,
  PURIM_KATAN,
  EREV_PESACH,
  PESACH, //Passover
  /**
     * Sheni Shel Pesach (second yom-tov day of galuyot - diaspora)
     * this is NOT Pesach Sheni!
     */
  SDOG_PESACH,
  PESACH_HOL_HAMOED,
  SHVII_PESACH,
  SHVII_SDOG_PESACH,
  PESACH_SHENI,
  RASHBI_THIRTY_THREE,
  EREV_SHAVUOT,
  SHAVUOT,
  SDOG_SHAVUOT,
  ISRU_HAG,
  TZOM_SEVENTEEN_TAMMUZ,
  TZOM_NINE_AV,
  FIFTEEN_AV,
  EREV_ROSH_HASHANA,
  TAANIT_GZEROT_408_409,
  /**
     *     holocaust day. decided in 27 Nissan 1951 (5711). if on friday, move it backward. if on sunday after 1997 move it afterward.
     */
  HOLOCAUST_DAY,
  /**
     * memorial day. in 4 Iyar 1951 (5711).
     */
  MEMORIAL_DAY_FALLEN,
  INDEPENDENTS_DAY,
  JERUSALEMS_DAY,
  /**
     * family day. in 30 Shevat since 1973 (5733).
     */
  FAMILY_DAY,
  YitzhakRabinMemorial
}

class _EventEntry {
  HebrewMonth monthId;
  int dayOfMonth;
  JewishEvents event;
  int daySpan;
  int skipping;
  _EventEntry(
      this.monthId, this.dayOfMonth, this.event, this.daySpan, this.skipping);
}

class SingleAnnualEvent {
  JewishEvents event;
  int type;
  int dayOffset;
  SingleAnnualEvent(this.event, this.type, this.dayOffset);
}

class AnnualEvents {
  static const int EV_NONE = 0;
  static const int EV_YOM_TOV = 1;
  static const int EV_HOL_HAMOED = 2;
  static const int EV_ISRU_HAG = 3;
  static const int EV_EREV_YOM_TOV = 4;
  static const int EV_MIRACLE = 5;
  static const int EV_CHASIDIC = 6;
  static const int EV_GOOD_DAYS = 7;
  static const int EV_TYPE_MASK = 7;
  static const int EV_NATIONAL = 8;
  static const int EV_TZOM = 16;
  static const int EV_REGALIM = 32;
  static const int EV_MEMORIAL = 64;
  static const int EV_HORBAN = 128;

  static List<int> eventsType = {
    JewishEvents.NO_EVENT.index: EV_NONE,
    JewishEvents.ROSH_HASHANA_A.index: EV_YOM_TOV,
    JewishEvents.ROSH_HASHANA_B.index: EV_YOM_TOV, //
    JewishEvents.TZOM_GEDALIAH.index: EV_TZOM | EV_HORBAN,
    JewishEvents.EREV_YOM_KIPPUR.index: EV_EREV_YOM_TOV,
    JewishEvents.YOM_KIPPUR.index: EV_TZOM | EV_YOM_TOV,
    JewishEvents.SIMCHAT_COHEN.index: EV_GOOD_DAYS,
    JewishEvents.EREV_SUKKOT.index: EV_EREV_YOM_TOV,
    JewishEvents.SUKKOT.index: EV_YOM_TOV | EV_REGALIM,
    JewishEvents.SDOG_SUKKOT.index: EV_YOM_TOV | EV_REGALIM,
    JewishEvents.SUKKOT_HOL_HAMOED.index: EV_HOL_HAMOED | EV_REGALIM,
    JewishEvents.HOSHANA_RABBAH.index: EV_HOL_HAMOED | EV_REGALIM,
    JewishEvents.SHEMINI_ATZERET.index: EV_YOM_TOV | EV_REGALIM,
    JewishEvents.SIMCHAT_TORAH.index: EV_YOM_TOV | EV_REGALIM,
    JewishEvents.SHEMINI_ATZERET_SIMCHAT_TORAH.index: EV_YOM_TOV | EV_REGALIM,
    JewishEvents.HANUKKAH_ONE_CANDLE.index: EV_MIRACLE,
    JewishEvents.HANUKKAH_TWO_CANDLES.index: EV_MIRACLE,
    JewishEvents.HANUKKAH_THREE_CANDLES.index: EV_MIRACLE,
    JewishEvents.HANUKKAH_FOUR_CANDLES.index: EV_MIRACLE,
    JewishEvents.HANUKKAH_FIVE_CANDLES.index: EV_MIRACLE,
    JewishEvents.HANUKKAH_SIX_CANDLES.index: EV_MIRACLE,
    JewishEvents.HANUKKAH_SEVEN_CANDLES.index: EV_MIRACLE,
    JewishEvents.HANUKKAH_EIGHT_CANDLES.index: EV_MIRACLE,
    JewishEvents.TENTH_OF_TEVET.index: EV_TZOM | EV_HORBAN,
    JewishEvents.FIFTEEN_SHVAT.index: EV_GOOD_DAYS,
    JewishEvents.TAANIT_ESTHER.index: EV_TZOM | EV_MIRACLE,
    JewishEvents.PURIM.index: EV_MIRACLE,
    JewishEvents.SHUSHAN_PURIM.index: EV_MIRACLE,
    JewishEvents.PURIM_MESHULASH.index: EV_MIRACLE,
    JewishEvents.PURIM_KATAN.index: EV_MIRACLE,
    JewishEvents.EREV_PESACH.index: EV_EREV_YOM_TOV,
    JewishEvents.PESACH.index: EV_YOM_TOV | EV_REGALIM,
    JewishEvents.SDOG_PESACH.index: EV_YOM_TOV | EV_REGALIM,
    JewishEvents.PESACH_HOL_HAMOED.index: EV_HOL_HAMOED | EV_REGALIM,
    JewishEvents.SHVII_PESACH.index: EV_YOM_TOV | EV_REGALIM,
    JewishEvents.SHVII_SDOG_PESACH.index: EV_YOM_TOV | EV_REGALIM,
    JewishEvents.PESACH_SHENI.index: EV_REGALIM,
    JewishEvents.RASHBI_THIRTY_THREE.index: EV_GOOD_DAYS,
    JewishEvents.EREV_SHAVUOT.index: EV_EREV_YOM_TOV,
    JewishEvents.SHAVUOT.index: EV_YOM_TOV | EV_REGALIM,
    JewishEvents.SDOG_SHAVUOT.index: EV_YOM_TOV | EV_REGALIM,
    JewishEvents.ISRU_HAG.index: EV_ISRU_HAG,
    JewishEvents.TZOM_SEVENTEEN_TAMMUZ.index: EV_TZOM | EV_HORBAN,
    JewishEvents.TZOM_NINE_AV.index: EV_TZOM | EV_HORBAN,
    JewishEvents.FIFTEEN_AV.index: EV_GOOD_DAYS,
    JewishEvents.EREV_ROSH_HASHANA.index: EV_EREV_YOM_TOV,
    JewishEvents.TAANIT_GZEROT_408_409.index: EV_TZOM | EV_MEMORIAL,
    JewishEvents.HOLOCAUST_DAY.index: EV_NATIONAL | EV_MEMORIAL,
    JewishEvents.MEMORIAL_DAY_FALLEN.index: EV_NATIONAL | EV_MEMORIAL,
    JewishEvents.INDEPENDENTS_DAY.index: EV_NATIONAL,
    JewishEvents.JERUSALEMS_DAY.index: EV_NATIONAL,
    JewishEvents.FAMILY_DAY.index: EV_NATIONAL,
    JewishEvents.YitzhakRabinMemorial.index: EV_NATIONAL | EV_MEMORIAL,
  }.values;

  static final List<_EventEntry> event_db = [
    // month_id,day,array index,# of days,jump/dhia(if #_days==1) if falls on saturday. if dhia>=7 then dhia%7 is the only day of week possible
    _EventEntry(HebrewMonth.TISHREI, 1, JewishEvents.ROSH_HASHANA_A, 2,
        1), //two days of rosh hashana
    _EventEntry(HebrewMonth.TISHREI, 3, JewishEvents.TZOM_GEDALIAH, 1,
        1), //zom gedaliah, dhia
    _EventEntry(HebrewMonth.TISHREI, 9, JewishEvents.EREV_YOM_KIPPUR, 2,
        1), //yom kippur
    _EventEntry(HebrewMonth.TISHREI, 11, JewishEvents.SIMCHAT_COHEN, 1,
        0), //yom Simhat Cohen
    _EventEntry(HebrewMonth.TISHREI, 14, JewishEvents.EREV_SUKKOT, 2,
        1), //Erev Sukkot+Sukkot
    _EventEntry(HebrewMonth.TISHREI, 16, JewishEvents.SUKKOT_HOL_HAMOED, 5,
        0), //hol hamoed sukkot
    _EventEntry(HebrewMonth.TISHREI, 21, JewishEvents.HOSHANA_RABBAH, 1,
        0), //hoshana raba
    _EventEntry(
        HebrewMonth.TISHREI,
        22,
        JewishEvents.SHEMINI_ATZERET_SIMCHAT_TORAH,
        1,
        0), //shmini azeret simhat_tora
    _EventEntry(
        HebrewMonth.TISHREI, 23, JewishEvents.ISRU_HAG, 1, 0), //isru hag
    _EventEntry(HebrewMonth.KISLEV, 25, JewishEvents.HANUKKAH_ONE_CANDLE, 8,
        1), //Chanukah
    _EventEntry(HebrewMonth.TEVET, 10, JewishEvents.TENTH_OF_TEVET, 1,
        0), //Tzom Asara B'Tevet
    _EventEntry(
        HebrewMonth.SHEVAT, 15, JewishEvents.FIFTEEN_SHVAT, 1, 0), //Tu B'Shvat
    _EventEntry(HebrewMonth.ADAR, 13, JewishEvents.TAANIT_ESTHER, 1,
        -2), //taanit ester, dhia
    _EventEntry(HebrewMonth.ADAR, 14, JewishEvents.PURIM, 2, 1), //Purim+Shushan
    _EventEntry(HebrewMonth.ADAR, 16, JewishEvents.PURIM_MESHULASH, 1,
        7), //Purim Meshulash only on sunday
    _EventEntry(HebrewMonth.ADAR_I, 14, JewishEvents.PURIM_KATAN, 2,
        0), //Purim katan - two days
    _EventEntry(HebrewMonth.ADAR_II, 13, JewishEvents.TAANIT_ESTHER, 1,
        -2), //taanit ester, dhia
    _EventEntry(
        HebrewMonth.ADAR_II, 14, JewishEvents.PURIM, 2, 1), //Purim+Shushan
    _EventEntry(HebrewMonth.ADAR_II, 16, JewishEvents.PURIM_MESHULASH, 1,
        7), //Purim Meshulash only on sunday
    _EventEntry(HebrewMonth.NISAN, 14, JewishEvents.EREV_PESACH, 2,
        1), //Erev Pesah+Pesah
    _EventEntry(HebrewMonth.NISAN, 16, JewishEvents.PESACH_HOL_HAMOED, 5,
        0), //Hol Ha'moed Pesah
    _EventEntry(
        HebrewMonth.NISAN, 21, JewishEvents.SHVII_PESACH, 1, 0), //Shvi'i Pesah
    _EventEntry(HebrewMonth.NISAN, 22, JewishEvents.ISRU_HAG, 1, 0), //isru hag
    _EventEntry(
        HebrewMonth.IYAR, 14, JewishEvents.PESACH_SHENI, 1, 0), //Pesah Sheni
    _EventEntry(HebrewMonth.IYAR, 18, JewishEvents.RASHBI_THIRTY_THREE, 1,
        0), //Lag Ba'Omer
    _EventEntry(HebrewMonth.SIVAN, 5, JewishEvents.EREV_SHAVUOT, 2,
        1), //Erev Shavu'ot+Shavu'ot
    _EventEntry(HebrewMonth.SIVAN, 7, JewishEvents.ISRU_HAG, 1, 0), //isru hag
    _EventEntry(HebrewMonth.TAMMUZ, 17, JewishEvents.TZOM_SEVENTEEN_TAMMUZ, 1,
        1), //Tzom 17 Tamuz, dhia
    _EventEntry(
        HebrewMonth.AV, 9, JewishEvents.TZOM_NINE_AV, 1, 1), //Tzom 9 Av, dhia
    _EventEntry(HebrewMonth.AV, 15, JewishEvents.FIFTEEN_AV, 1, 0), //15 Av
    _EventEntry(HebrewMonth.ELUL, 29, JewishEvents.EREV_ROSH_HASHANA, 1,
        0), //Erev Rosh Hashana
    _EventEntry(HebrewMonth.SIVAN, 20, JewishEvents.TAANIT_GZEROT_408_409, 1,
        0), //5408-5409 memorial
//TODO: maybe add event since year parameter. for 5408 memorial.
  ];
  static final List<_EventEntry> event_db_diaspora = [
    // month_id,day,array index,# of days,jump/dhia(if #_days==1)
    _EventEntry(
        HebrewMonth.TISHREI, 16, JewishEvents.SDOG_SUKKOT, 1, 0), //sukkot II
    _EventEntry(HebrewMonth.TISHREI, 22, JewishEvents.SHEMINI_ATZERET, 1,
        0), //shmini azeret
    _EventEntry(HebrewMonth.TISHREI, 23, JewishEvents.SIMCHAT_TORAH, 1,
        0), //simhat_tora
    _EventEntry(
        HebrewMonth.NISAN, 16, JewishEvents.SDOG_PESACH, 1, 0), //Pesah II
    _EventEntry(HebrewMonth.NISAN, 22, JewishEvents.SHVII_SDOG_PESACH, 1,
        0), //Shmi'ni Pesah
    _EventEntry(
        HebrewMonth.SIVAN, 7, JewishEvents.SDOG_SHAVUOT, 1, 0), //Shavu'ot II
  ];

  Int8List current_year_events;
  bool diaspora;
  int year;
  int year_length;
  /*int year()
    {
        return this.year;
    }*/
  int yearLength() {
    return this.year_length;
  }
  /*bool diaspora()
    {
        return this.diaspora;
    }*/
  /*String getYearEventForDayRejection(HebrewDate d, YDateLanguage language)
    {
        String out=language.getToken(events_str_id[current_year_events[d.dayInYear()]]);
        short rej= isRejected(d);
        if (rej!=0)
            out+=" ("+language.getRejection(rej)+")";
        return out;
    }*/

  int getYearEventTypeForDay(HebrewDate d) {
    return eventsType[current_year_events[d.dayInYear]];
  }

  static int getEventType(int event_id) {
    return eventsType[event_id];
  }

  Int8List getYearEvents() {
    return current_year_events;
  }

  /*private static byte [] cloneArray(byte [] arr)
    {
        byte [] new_arr=new byte[arr.length];
        for (int i=0;i<arr.length;++i)
        {
            new_arr[i]=arr[i];
        }
        return new_arr;
    }*/
  AnnualEvents(int year, int year_length, int year_first_day, bool diaspora) {
    this.year = year;
    this.year_length = year_length;
    this.diaspora = diaspora;
    int year_ld_t =
        HebrewDateToolkit.yearLengthDayType(year_length, year_first_day % 7 + 1);
    _initializeYear(diaspora, year_ld_t, year_length, year_first_day);
    current_year_events =
        Int8List.fromList(annualEventsLists[diaspora ? 1 : 0][year_ld_t - 1]);
    addNationalEvents(current_year_events, year, year_length, year_first_day);
  }
  static void addNationalEvents(
      Int8List year_events, int year, int year_length, int year_first_day) {
    //Holocaust day
    if (year >= 5718) //1958
    {
      int day_in_year = HebrewDateToolkit.dayInYearByMonthId(
          year_length, HebrewMonth.NISAN, 27);
      int dayweek = (day_in_year + year_first_day) % 7;
      if (dayweek == ADate.FRIDAY) //friday
      {
        day_in_year--;
      } else if (dayweek == ADate.SUNDAY) //sunday
      {
        day_in_year++;
      }
      year_events[day_in_year] = JewishEvents.HOLOCAUST_DAY.index;
    }
    //Yom Azma'ut and Yom HaZikaron
    if (year >= 5708) //1948
    {
      int day_in_year = HebrewDateToolkit.dayInYearByMonthId(
          year_length, HebrewMonth.IYAR, 5);
      int dayweek = (day_in_year + year_first_day) % 7;

      if (dayweek == ADate.SATURDAY) //on saturday
      {
        day_in_year -= 2;
      } else if (dayweek == ADate.FRIDAY) //on friday
      {
        day_in_year -= 1;
      } else if (dayweek == ADate.MONDAY &&
          year >=
              5764) //on monday (2004) then Yom HaZikaron is on sunday, and that's no good...
      {
        day_in_year += 1;
      }
      year_events[day_in_year - 1] =
          JewishEvents.MEMORIAL_DAY_FALLEN.index; //Yom HaZikaron
      year_events[day_in_year] =
          JewishEvents.INDEPENDENTS_DAY.index; //Yom Azma'ut
    }
    //Jerusalem day
    if (year >= 5728) //1968
    {
      int day_in_year = HebrewDateToolkit.dayInYearByMonthId(
          year_length, HebrewMonth.IYAR, 28);
      year_events[day_in_year] = JewishEvents.JERUSALEMS_DAY.index;
    }
    //Family day
    if (year >= 5733) //1973
    {
      int day_in_year = HebrewDateToolkit.dayInYearByMonthId(
          year_length, HebrewMonth.SHEVAT, 30);
      year_events[day_in_year] = JewishEvents.FAMILY_DAY.index;
    }
    //Rabin's Day
    if (year >= 5758) //cheshvan 1997
    {
      int day_in_year = HebrewDateToolkit.dayInYearByMonthId(
          year_length, HebrewMonth.CHESHVAN, 12);
      int dayweek = (day_in_year + year_first_day) % 7;
      if (dayweek == ADate.FRIDAY) {
        day_in_year--;
      }
      year_events[day_in_year] = JewishEvents.YitzhakRabinMemorial.index;
    }
  }

  static List<List<Int8List>> annualEventsLists = List.generate(
      2,
      (i) => List.filled(HebrewDateToolkit.N_YEAR_TYPES,
          null)); //new Int8List [2][HebrewDate.N_YEAR_TYPES][];//[diaspora][year_type][day_in_year]
  static List<Map<int, int>> annualEventsDelayLists = List(HebrewDateToolkit
      .N_YEAR_TYPES); // = new short [HebrewDate.N_YEAR_TYPES][4];//[year_type][5]->[day_in_year]
  /*static String getEventForDay(HebrewDate d, bool diaspora, YDateLanguage language)
    {
        return language.getToken(events_str_id[getEvents(d, diaspora)[d.dayInYear()]]);
    }*/

  static Int8List getEventsByDate(HebrewDate d, bool diaspora) {
    int yearLDType =
        HebrewDateToolkit.yearLengthDayType(d.yearLength, d.firstDayOfYearGDN % 7 + 1);
    return _initializeYear(
        diaspora, yearLDType, d.yearLength, d.firstDayOfYearGDN);
  }

  static const int PRECEDE = 512;
  static const int LATE = 1024;
  static int isRejected(HebrewDate d) {
    int yearLDType =
        HebrewDateToolkit.yearLengthDayType(d.yearLength, d.firstDayOfYearGDN % 7 + 1);
    Map<int, int> dhia = annualEventsDelayLists[yearLDType - 1];
    if (annualEventsLists[0][yearLDType - 1] != null) {
      int diy = d.dayInYear;
      if (dhia.containsKey(diy)) return dhia[diy];
    }
    return 0;
  }

  static Int8List _getEvents(
      int yearLength, int yearFirstDay, bool diaspora) {
    int yearLDType =
        HebrewDateToolkit.yearLengthDayType(yearLength, yearFirstDay % 7 + 1);
    return _initializeYear(diaspora, yearLDType, yearLength, yearFirstDay);
  }

  static void _expandDB(int yearLength, int yearFirstDay,
      List<_EventEntry> evdb, Int8List yearEvents, Map<int, int> dhia) {
    bool leap = HebrewDateToolkit.isLeap(yearLength);
    for (int ev = 0; ev < evdb.length; ++ev) {
      HebrewMonth monthId = evdb[ev].monthId;
      if (monthId == HebrewMonth.ADAR && leap) {
        continue;
      }
      if ((monthId == HebrewMonth.ADAR_I || monthId == HebrewMonth.ADAR_II) &&
          !leap) {
        continue;
      }
      int diy = HebrewDateToolkit.dayInYearByMonthId(
          yearLength, monthId, evdb[ev].dayOfMonth);
      if (evdb[ev].daySpan == 1) {
        bool enableEvent = true;
        if (evdb[ev].skipping != 0) // dhia
        {
          if (evdb[ev].skipping < 7) {
            if ((yearFirstDay + diy) % 7 == ADate.SATURDAY) {
              diy += evdb[ev].skipping;
              if (dhia != null) {
                dhia[diy] = evdb[ev].skipping;
              }
            }
          } else if (evdb[ev].skipping >=
              7) //enable the date only if it falls on a certain day of week.
          {
            if (evdb[ev].skipping % 7 != (yearFirstDay + diy) % 7) {
              enableEvent = false;
            }
          }
        }
        if (enableEvent) yearEvents[diy] = evdb[ev].event.index;
      } else {
        int idx = evdb[ev].event.index;
        for (int l = 0; l < evdb[ev].daySpan; ++l) {
          yearEvents[diy + l] = idx;
          idx += evdb[ev].skipping;
        }
      }
    }
  }

  static Int8List _initializeYear(
      bool diaspora, int year_ld_t, int year_length, int year_first_day) {
    if (annualEventsLists[diaspora ? 1 : 0][year_ld_t - 1] == null) {
      annualEventsLists[diaspora ? 1 : 0][year_ld_t - 1] = Int8List(year_length);
      annualEventsDelayLists[year_ld_t - 1] = {};
      _expandDB(
          year_length,
          year_first_day,
          event_db,
          annualEventsLists[diaspora ? 1 : 0][year_ld_t - 1],
          annualEventsDelayLists[year_ld_t - 1]);
      if (diaspora)
        _expandDB(year_length, year_first_day, event_db_diaspora,
            annualEventsLists[diaspora ? 1 : 0][year_ld_t - 1], null);
    }
    return annualEventsLists[diaspora ? 1 : 0][year_ld_t - 1];
  }

/*
hamilinzki כ סיון גזירות תח תט
*/
}
