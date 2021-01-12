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
import 'abstract_date.dart';
import 'dart:math';

const List<String> hebrewAlphaBet = [
  "",
  "א",
  "ב",
  "ג",
  "ד",
  "ה",
  "ו",
  "ז",
  "ח",
  "ט",
  "י",
  "כ",
  "ל",
  "מ",
  "נ",
  "ס",
  "ע",
  "פ",
  "צ",
  "ק",
  "ר",
  "ש",
  "ת",
];
enum YearLeapType {
  PESHUTA,
  MEUBERET,
}

enum ChanukkahDay {
  NONE,
  DAY_I,
  DAY_II,
  DAY_III,
  DAY_IV,
  DAY_V,
  DAY_VI,
  DAY_VII,
  DAY_VIII
}

class HebrewYearSign {
  List<HebrewAlphaBet> letters;
  YearLeapType yearType;
  HebrewYearSign(this.letters, this.yearType);
}

enum HebrewAlphaBet {
  Alef,
  Bet,
  Gimel,
  Dalet,
  He,
  Vav,
  Zayin,
  Chet,
  Tet,
  Yod,
  Kaf,
  Lamed,
  Mem,
  Nun,
  Samech,
  Ayin,
  Pe,
  Tsade,
  Qof,
  Resh,
  Shin,
  Tav,
}

class HebrewDateToolkit {
  static bool isLeap(int yearLength) => yearLength > 355;
  static int dayInYearByMonthId(int yearLength, HebrewMonth monthId, int day) =>
      HebrewDate._calculateDayInYear(yearLength,
          HebrewDate._monthFromMonthId(isLeap(yearLength), monthId), day);
  static int yearLengthDayType(int size_of_year, int year_first_dw) =>
      HebrewDate._ld_year_type(size_of_year, year_first_dw);
  /// Number of year types. an year type is determined by the day in week of the first day and the year's length. Only 14 combinations are valid.
  static const int N_YEAR_TYPES = 14;
}

/*
 *
 * @author Orr Dvori
 */
enum HebrewMonth {
  TISHREI, //0;
  CHESHVAN, //1;
  KISLEV, //2;
  TEVET, //3;
  SHEVAT, //4;
  ADAR, //5;
  ADAR_I, //6;
  ADAR_II, //7;
  NISAN, //8;
  IYAR, //9;
  SIVAN, //10;
  TAMMUZ, //11;
  AV, //12;
  ELUL //13;
}
/*
 *
 * @author Orr Dvori
 */
enum Tkufa {
  TISHREI, //0;
  TEVET, //1;
  NISAN, //2;
  TAMMUZ, //3;
}

enum Planet {
  Mercury, //0
  Moon, //1
  Saturn, //2
  Jupiter, //3
  Mars, //4
  Sun, //5
  Venus //6
}

/// The Four Elements
///
/// The book of Yezira claims the following:
/// Every zodiac sign is related to an element.
/// The signs that are connected with Fire are: Aries, Leo, Sagittarius.
/// The signs that are connected with Earth are: Taurus, Virgo, Capricorn.
/// The signs that are connected with Wind are: Gemini, Libra, Aquarius.
/// The signs that are connected with Water are: Cancer, Scorpio, Pisces.
/// The ones with the element of Fire doesn't get along with those of Water
/// The ones with the element of Earth doesn't get along with those of Wind
enum Element {
  /// Zodiac signs related to Fire: Aries, Leo, Sagittarius.
  Fire, //0
  /// Zodiac signs related to Earth: Taurus, Virgo, Capricorn.
  Earth, //1
  /// Zodiac signs related to Wind: Gemini, Libra, Aquarius.
  Wind, //2
  /// Zodiac signs related to Water: Cancer, Scorpio, Pisces.
  Water, //3
}
enum ZodiacSign {
  Aries, //0
  Taurus, //1
  Gemini, //2
  Cancer, //3
  Leo, //4
  Virgo, //5
  Libra, //6
  Scorpio, //7
  Sagittarius, //8
  Capricorn, //9
  Aquarius, //10
  Pisces //11
}
Element elementOfZodiacSign(ZodiacSign zs) {
  return Element.values[zs.index % 4];
}

class HebrewDate extends ADMYDate {
  /// The first day of the year 4119 (GDN). This hebrew dates system was founded in the year 4119 (359CE).
  static const int DAYS_OF_4119 = 1504084;

  /// The year 4117 was the most recent year before the beginning of the dating system which sun blessing cycle of 28 started in.
  /// We start calculations of 4 Tkufut and sun blessing from that year. (365.25 days per year of Shmuel)
  static const int DAYS_OF_TKUFA_CYCLE_4117 = 1503540;

  /// The first day of the year 6001 (GDN). Six thousand years the world shall exists.
  /// This is the upper bound of the jewish dating system.
  static const int DAYS_OF_6001 = 2191466;


  /// Length of hour in hour-parts (1080).
  static const int HOUR = 1080;

  /// Length of day in hour-parts (1080).
  static const int DAY = (24 * HOUR);

  /// Length of week in hour-parts (1080).
  static const int WEEK = (7 * DAY);

  /// Length of month in hour-parts (1080).
  static final int MONTH = 29 * DAY + HP(12, 793);

  /// Molad of the estimated first month was on monday of the seven days of genesis, in the sixth hour (starting from sunset).
  static final int MOLAD = DayOfWeek.Monday.index * DAY + HP(5, 204);


  /// The number of months in 19 years.
  /// The jewish dating system has cycles of 19 years where 7 of the 19 has 13 month in year, and the other 12 has 12 month in year.
  /// So the calculation is as follow: 12*12+7*13 = 235
  /// see also [MONTHS_DIVISION] for the distribution of years.
  static const int MONTHS_IN_19Y = 235;

  /// Molad Zaken happens when the Molad is in the last 6 hours of the day (before sunset).
  static const int MOLAD_ZAKEN_ROUNDING = 6 * HOUR;

  /// Length of Tkufa in hour-parts (1080).
  static const int TKUFA = 91 * DAY + 7 * HOUR + 540;

  /// Length of Mazal in hour-parts (1080). Mazal equals to 365.25 days divided by 12
  static const int MAZAL = 30 * DAY + 10 * HOUR + 540;

  /// The year of Exodos
  static const int YEZIAT_MIZRAIM = 2449;

  /// The year that Documents dating system refers to.
  static const int MINIAN_SHTAROT = 3449;

  /// The year of destruction of first Temple
  static const int HORBAN_BAIT_RISHON = 3339;

  /// The year of destruction of second Temple
  static const int HORBAN_BAIT_SHENI = 3829;

  static const int M_ID_TISHREI = 0;
  static const int M_ID_CHESHVAN = 1;
  static const int M_ID_KISLEV = 2;
  static const int M_ID_TEVET = 3;
  static const int M_ID_SHEVAT = 4;
  static const int M_ID_ADAR = 5;
  static const int M_ID_ADAR_I = 6;
  static const int M_ID_ADAR_II = 7;
  static const int M_ID_NISAN = 8;
  static const int M_ID_IYAR = 9;
  static const int M_ID_SIVAN = 10;
  static const int M_ID_TAMMUZ = 11;
  static const int M_ID_AV = 12;
  static const int M_ID_ELUL = 13;

  /**
     * Return Hebrew year type based on length and first week day of year.
     * p - pshuta  353..355
     * m - meuberet 383..385
     * h - hasera [353,383]
     * k - kesidra [354,384]
     * s - shlema (melea) [355,385]
     * |year type| year length | Tishery 1 day of week
     * | 1       | 353         | 2  ph2
     * | XXXXX   | 353         | 3  ph3 impossible
     * | XXXXX   | 353         | 5  ph5 impossible
     * | 2       | 353         | 7  ph7
     * | XXXXX   | 354         | 2  pk2 impossible
     * | 3       | 354         | 3  pk3
     * | 4       | 354         | 5  pk5
     * | XXXXX   | 354         | 7  pk7 impossible
     * | 5       | 355         | 2  ps2
     * | XXXXX   | 355         | 3  ps3 impossible
     * | 6       | 355         | 5  ps5
     * | 7       | 355         | 7  ps7
     * | 8       | 383         | 2  mh2
     * | XXXXX   | 383         | 3  mh3 impossible
     * | 9       | 383         | 5  mh5
     * |10       | 383         | 7  mh7
     * | XXXXX   | 384         | 2  mk2 impossible
     * |11       | 384         | 3  mk3
     * | XXXXX   | 384         | 5  mk5 impossible
     * | XXXXX   | 384         | 7  mk7 impossible
     * |12       | 385         | 2  ms2
     * | XXXXX   | 385         | 3  ms3 impossible
     * |13       | 385         | 5  ms5
     * |14       | 385         | 7  ms7
     *
     * @param size_of_year Length of year in days
     * @param year_first_dw First week day of year (1..7)
     * @return A number for year type (1..14)
     */
  static int _ld_year_type(int size_of_year, int year_first_dw) {
    const year_type_map = [
      1,
      0,
      0,
      2,
      0,
      3,
      4,
      0,
      5,
      0,
      6,
      7,
      8,
      0,
      9,
      10,
      0,
      11,
      0,
      0,
      12,
      0,
      13,
      14
    ];

    /* the year cannot start at days 1 4 6, so we are left with 2,3,5,7.
           and the possible lengths are 353 354 355 383 384 385...
           so we have 24 combinations, but only 14 are possible. (see table above)
         */
/* 2,3,5,7 -> 0,1,2,3 */
    int offset = (year_first_dw - 1) ~/ 2;
    return year_type_map[4 * _yearLengthType(size_of_year) + offset];
  }

  ///Number of months per year in a 19 years cycle.
  static const List<int> MONTHS_DIVISION = [
    12,
    12,
    13,
    12,
    12,
    13,
    12,
    13,
    12,
    12,
    13,
    12,
    12,
    13,
    12,
    12,
    13,
    12,
    13
  ];

  static int HP(int h, int p) => h * HOUR + p;

  /// Year. valid range: 4119..6000 (year 1 was the first year).
  int _year = 0;

  /// Month in year. valid range 1..12, or 1..13 in leap year.
  int _month;

  /// Day in month. valid range: 1..30.
  int _day;

  /// hour-parts since the beginning of genesis of the first day in the current year.
  int _yearGParts;

  /// Length of the year in days. The only possible values are - 353, 354, 355, 383, 384, 385.
  int _yearLength;

  /// The GDN of the first day in the current year.
  int _yearFirstDay;

  /// Days since first day in the year. For the first day in the year the value will be 0.
  int _dayInYear;

  /// Whether the date object represents a valid date.
  bool _valid = false;

  @override
  int get dayInMonth //starts from one
  {
    return this._day;
  }

  @override
  int get dayInYear //starts from zero
  {
    return this._dayInYear;
  }

  @override
  int get monthLength {
    return monthLengthInYear(this._yearLength, this._month);
  }

  @override
  int get previousMonthLength {
    if (this._month == 1) //Elul is always 29 days
    {
      return 29;
    }
    return monthLengthInYear(this._yearLength, this._month - 1);
  }

  static int monthLengthInYear(int yearLength, int month) {
    int yearLenType = _yearLengthType(yearLength);
    return _monthsDaysOffsets[yearLenType][month] -
        _monthsDaysOffsets[yearLenType][month - 1];
  }

  /*
     * the ordinal month in year. in regular year the range is 1..12, 
     * and in a leap year the range is 1..13.
     * to get the month ID (eg. TISHREI,CHESHVAN... ADAR_I,ADAR_II...) see 
     * [monthID].
     * return the month of the year of the object's date.
     */
  @override
  int get month => this._month;

  /*
     * the number of months in year. in regular year the range is 1..12, 
     * and in a leap year the range is 1..13.
     * to get the month ID (eg. TISHREI,CHESHVAN... ADAR_I,ADAR_II...) see 
     * {@link #monthID() }.
     * @return the month of the year of the object's date.
     */
  int monthsInYear() {
    return calculateYearMonths(this._year);
  }

  @override
  int get year {
    return this._year;
  }

  /// Empty constructor that construct invalid date.
  HebrewDate() {
    this._valid = false;
    desired = false;
    this._year = 1;
    this._month = 1;
    this._day = 1;
    this._yearGParts = 0;
    this._yearFirstDay = 0;
    this._yearLength = 354;
    this._dayInYear = 0;
  }

  /// Simple copy constructor.
  /// note that event handler and sync group are not cloned.
  HebrewDate.from(HebrewDate o) {
    this._valid = o._valid;
    this._year = o._year;
    this._month = o._month;
    this._day = o._day;
    this._yearGParts = o._yearGParts;
    this._yearFirstDay = o._yearFirstDay;
    this._yearLength = o._yearLength;
    this._dayInYear = o._dayInYear;
    this.desired = o.desired;
  }

  HebrewDate.fromGDN(int gdn) {
    setByGDN(gdn);
  }

  /// Creates a date object for the current time.
  ///
  /// This method assumes that the day starts at midnight.
  /// This method concern about TimeZone.
  HebrewDate.now() {
    DateTime nowDate = DateTime.now();
    Duration durationSinceEpoch =
        Duration(milliseconds: nowDate.millisecondsSinceEpoch);
    durationSinceEpoch += nowDate.timeZoneOffset;
    int gdn = ADate.EPOCH_DAY + durationSinceEpoch.inDays;
    setByGDN(gdn);
  }

  /// Mimic other date
  ///
  /// Event-handlers and sync-group are not mimicked.
  bool mimic(HebrewDate o) {
    this._valid = o._valid;
    this._year = o._year;
    this._month = o._month;
    this._day = o._day;
    this._yearGParts = o._yearGParts;
    this._yearFirstDay = o._yearFirstDay;
    this._yearLength = o._yearLength;
    this._dayInYear = o._dayInYear;
    desired = stateChanged();
    return desired;
  }

  HebrewDate.fromYearMonthIdDay(int year, HebrewMonth monthId, int day) {
    setByYearMonthIdDay(year, monthId, day);
  }
  void _calculateYearVariables() {
    this._yearGParts = partsSinceGenesis(_year);
    this._yearFirstDay = _calcGdnOfYear(_year, this._yearGParts);
    this._yearLength = _calcGdnOfYear(_year + 1, partsSinceGenesis(_year + 1)) -
        this._yearFirstDay;
  }

  bool setByYearMonthIdDay(int year, HebrewMonth monthId, int day) {
    if (year >= 4119 && year < 6001) {
      if (this._year != year || !_valid) {
        this._year = year;
        _calculateYearVariables();
      }
      this._month = _monthFromIDByYearLength(this._yearLength, monthId);
      int month_length = this.monthLength;
      this._day = max(1, min(month_length, day));
      this._dayInYear =
          _calculateDayInYear(this._yearLength, this._month, this._day);
      this._valid = true;
      int gdn = this.gdn;
      return stateChanged() && (gdn == this.gdn);
    }
    return false;
  }

  bool setByYMD(int year, int month, int day) {
    if (year >= 4119 && year < 7001) {
      if (this._year != year || !_valid) {
        this._year = year;
        _calculateYearVariables();
      }
      int monthsInYear = (_yearLength > 355) ? 13 : 12;
      this._month = max(1, min(month, monthsInYear));
      int month_length = this.monthLength;
      this._day = max(1, min(month_length, day));
      this._dayInYear =
          _calculateDayInYear(this._yearLength, this._month, this._day);
      this._valid = true;
      desired = stateChanged();
    } else {
      desired = false;
      return false;
    }
  }

  @override
  bool get valid {
    return _valid;
  }

  @override
  bool setByGDN(int gdn) {
    if (!checkBounds(gdn)) {
      desired = false;
      return false;
    }

    /// if we want to go somewhere in current year
    if (this.valid &&
        (gdn >= this._yearFirstDay) &&
        (gdn < this._yearFirstDay + this._yearLength)) // the trivial case
    {
      this._dayInYear = gdn - this._yearFirstDay;
      _setMonthDay(this._dayInYear);
      desired = stateChanged();
      return desired;
    }
    int orig_parts = gdn * DAY;
    int parts = orig_parts - MOLAD;
    int months = parts ~/ MONTH;
    parts = (parts % MONTH);
    int years = 1; //first year was year one.
    years += 19 * (months ~/ MONTHS_IN_19Y);
    months = months % MONTHS_IN_19Y;
    int year_in_19 = ((months + 1) * 19 - 2) ~/ 235;
    years += year_in_19;
    months = months - (235 * (year_in_19) + 1) ~/ 19;
    parts += months * MONTH;
    this._yearGParts = orig_parts - parts;
    this._yearFirstDay = _calcGdnOfYear(years, this._yearGParts);
    int next_year_day = _calcGdnOfYear(years + 1, partsSinceGenesis(years + 1));
    int months_in_year;
    if (gdn >= this._yearFirstDay && gdn < next_year_day) {
      this._year = years;
      this._yearLength = next_year_day - this._yearFirstDay;
    } else {
      if (gdn < this._yearFirstDay) {
        this._year = years - 1;
        months_in_year = calculateYearMonths(this._year);
        this._yearGParts -= months_in_year * MONTH;
        next_year_day = this._yearFirstDay;
        this._yearFirstDay = _calcGdnOfYear(this._year, this._yearGParts);
        this._yearLength = next_year_day - this._yearFirstDay;
      } else {
        assert(gdn >= next_year_day);
        this._year = years + 1;
        months_in_year = calculateYearMonths(years);
        this._yearGParts += months_in_year * MONTH;
        this._yearFirstDay = next_year_day;
        this._yearLength =
            _calcGdnOfYear(this._year + 1, partsSinceGenesis(this._year + 1)) -
                this._yearFirstDay;
      }
    }
    this._dayInYear = gdn - this._yearFirstDay;
    _setMonthDay(this._dayInYear);
    this._valid = true;
    desired = stateChanged();
    return desired;
  }

  static int _calcGdnOfYear(int year, int parts) {
    int days = ((parts + MOLAD_ZAKEN_ROUNDING) ~/ DAY);
    int parts_mod = (parts % DAY);
    int year_type = ((year - 1) * 7 + 1) % 19;
    /* this magic gives us the following array:
         1, 8,15, 3,10,17, 5,12, 0, 7,14, 2, 9,16, 4,11,18, 6,13
         now if we compare it with the 235 months division:
         12,12,13,12,12,13,12,13,12,12,13,12,12,13,12,12,13,12,13
         we can see that all the leap years # >=12 and all the regular years # <12
         also, all the years that comes after a leap year have a number < 7
         */
    DayOfWeek week_day = DayOfWeek.values[days % 7];
    if (parts_mod < DAY - MOLAD_ZAKEN_ROUNDING) {
      if (year_type < 12) //regular year (non leap)
      {
        if (week_day == DayOfWeek.Tuesday && parts_mod >= HP(9, 204)) {
          return days + 2; //we need to add 2 because Wednesday comes next (ADU)
        }
      }
      if (year_type < 7) //a year after a leap year
      {
        if (week_day == DayOfWeek.Monday && parts_mod >= HP(15, 589)) {
          return days + 1; //we need to add only 1..
        }
      }
    }
    if (week_day == DayOfWeek.Sunday ||
        week_day == DayOfWeek.Wednesday ||
        week_day == DayOfWeek.Friday) {
      ++days;
    }
    return days;
  }

  /**
     * checks how many months are in a certain year
     *
     * @param year a hebrew year
     * @return the number of months in this year
     */
  static int calculateYearMonths(int year) {
    /*
         the loop:
         for x in range(0,19):
         &nbsp;&nbsp;print (235*(x+1)+1)/19-(235*x+1)/19
         gives exactly:
         12,12,13,12,12,13,12,13,12,12,13,12,12,13,12,12,13,12,13
         which is the 19-years period month's division
         */
    //return (235 * year + 1) / 19 - (235 * (year - 1) + 1) / 19;
    return MONTHS_DIVISION[(year - 1) % 19];
  }

  static bool isLeapYear(int year) {
    return MONTHS_DIVISION[(year - 1) % 19] == 13;
  }

  static int partsSinceGenesis(int year) {
    /*
         the loop:
         ```
         for x in range(0,19):
           print (235*(x+1)+1)~/19-(235*x+1)~/19
         ```
         gives exactly:
         12,12,13,12,12,13,12,13,12,12,13,12,12,13,12,12,13,12,13
         which is the 19-years period month's division
         */
    ///find out how many months have passed
    int months = (235 * (year - 1) + 1) ~/
        19; //first year was year one. so we subtract one from year to start from 0.
    int parts = MOLAD + MONTH * months;
    return parts;
  }

  void _setMonthDay(int days) //finds the month by day in year.
  {
    int yearLen_t = _yearLengthType(this._yearLength);
    int m = days * 2 ~/ 59;
    if (_monthsDaysOffsets[yearLen_t][m] > days) {
      m--;
    } else if (_monthsDaysOffsets[yearLen_t][m + 1] <= days) {
      m++;
    }
    this._month = m + 1;
    this._day = days - _monthsDaysOffsets[yearLen_t][m] + 1;
  }

  /*static int calculateYearLength(int year) {
    return _calculateYearFirstDay(year + 1) - _calculateYearFirstDay(year);
  }

  static int _calculateYearFirstDay(int year) {
    return days_until_year(year, partsSinceGenesis(year));
  }*/

  static int _yearLengthType(int yearLength) {
    //0 hasera,1 kesidra,2 melea,3 meuberet hasera,4 meuberet kesidra,5 meuberet melea
    return {353: 0, 354: 1, 355: 2, 383: 3, 384: 4, 385: 5}[yearLength];
    //return ((year_length % 10) - 3) + (year_length - 350) ~/ 10;
  }

  static const List<List<int>> _monthsDaysOffsets = [
    [0, 30, 59, 88, 117, 147, 176, 206, 235, 265, 294, 324, 353],
    [0, 30, 59, 89, 118, 148, 177, 207, 236, 266, 295, 325, 354],
    [0, 30, 60, 90, 119, 149, 178, 208, 237, 267, 296, 326, 355],
    [0, 30, 59, 88, 117, 147, 177, 206, 236, 265, 295, 324, 354, 383],
    [0, 30, 59, 89, 118, 148, 178, 207, 237, 266, 296, 325, 355, 384],
    [0, 30, 60, 90, 119, 149, 179, 208, 238, 267, 297, 326, 356, 385]
  ];
  static int _calculateDayInYear(int yearLength, int month, int day) //0..385
  {
    int yearLen_t = _yearLengthType(yearLength);
    return _monthsDaysOffsets[yearLen_t][month - 1] + day - 1;
  }
  /*
  /// not so commonly used
  static int yearFromGdn(int gdn) {
    int orig_parts = gdn * DAY;
    int parts = orig_parts - MOLAD;
    int months = parts ~/ MONTH;
    parts = (parts % MONTH);
    int years = 1; //first year was year one.
    years += 19 * (months ~/ MONTHS_IN_19Y);
    months = months % MONTHS_IN_19Y;
    int yearInNineteenCycle = ((months + 1) * 19 - 2) ~/ 235;
    years += yearInNineteenCycle;
    months = months - (235 * (yearInNineteenCycle) + 1) ~/ 19;
    parts += months * MONTH;
    int estimatedYearLength = 353;
    if (calculateYearMonths(years) == 13) {
      estimatedYearLength = 383;
    }
    int yearMoladParts = orig_parts - parts;
    int estimatedFirstDayOfYear = yearMoladParts ~/ DAY;
    if (estimatedFirstDayOfYear + 2 <= gdn &&
        gdn < estimatedFirstDayOfYear + estimatedYearLength) {
      return years;
    }
    int firstDayOfYear = days_until_year(years, yearMoladParts);
    if (gdn < firstDayOfYear) {
      return years - 1;
    }
    int firstDayOfNextYear =
        days_until_year(years + 1, partsSinceGenesis(years + 1));
    if (gdn >= firstDayOfNextYear) {
      return years + 1;
    }
    return years;
  }*/

  @override
  int get gdn => _yearFirstDay + _dayInYear;

  @override
  int get upperBound {
    return DAYS_OF_6001;
  }

  @override
  int get lowerBound {
    return DAYS_OF_4119;
  }

  int monthFirstDay() {
    //days since beginning
    int yearLen_t = _yearLengthType(this._yearLength);
    return this._yearFirstDay + _monthsDaysOffsets[yearLen_t][this._month - 1];
  }

  int monthIdFirstDay(HebrewMonth monthId) {
    //days since beginning
    int yearLen_t = _yearLengthType(this._yearLength);
    return this._yearFirstDay +
        _monthsDaysOffsets[yearLen_t][_monthFromMonthId(leapYear, monthId) - 1];
  }

  @override
  int get yearLength => this._yearLength;
  @override
  int get firstDayOfYearGDN => this._yearFirstDay;
  bool get leapYear => (this._yearLength > 355);
  @override
  int get firstDayOfMonthGDN => monthFirstDay();
  DayOfWeek get yearFirstDayWeekDay //starts from one
  {
    return DayOfWeek.values[this._yearFirstDay % 7] ;
  }

  static int _monthFromIDByYear(int year, HebrewMonth monthId) {
    return _monthFromMonthId(calculateYearMonths(year) == 13, monthId);
  }

  static int _monthFromIDByYearLength(int year_length, HebrewMonth monthId) {
    return _monthFromMonthId((year_length > 355), monthId);
  }

  HebrewMonth get monthID {
    return _monthToMonthId(calculateYearMonths(_year) == 13, this._month);
  }

  static HebrewMonth _monthToMonthId(bool leapYear, int month) {
    if (leapYear) //leap year
    {
      if (month > 5) //if Adar or after
      {
        ++month; //skip regular Adar
      }
    } else {
      if (month > 6) //if Nisan or after
      {
        month += 2; //skip Adar I+II
      }
    }
    assert(month >= 1 && month <= HebrewMonth.values.length);
    return HebrewMonth.values[month - 1];
  }

  /// Convert MonthId to Month Ordinal number.
  ///
  /// This function is tolerate to invalid monthIds.
  static int _monthFromMonthId(bool leapYear, HebrewMonth monthId) {
    if (monthId.index < HebrewMonth.ADAR.index) {
      return monthId.index + 1;
    }
    if (leapYear) //leap year
    {
      if (monthId.index >= HebrewMonth.ADAR_I.index) {
        return monthId.index;
      }
      //return the index of adar II if monthId equal to ADAR
      return 7;
    } else {
      if (monthId.index >= HebrewMonth.NISAN.index) {
        return monthId.index - 1;
      }
      // if monthId is equal to ADAR or ADAR_I or ADAR_II return the same index for all of them.
      return 6;
    }
  }

  static Planet planetOfHour(int parts) {
    return Planet.values[((parts ~/ HOUR) % 7)];
  }

  int monthMoladParts() {
    return _yearGParts + (_month - 1) * MONTH;
  }

  /// this will not give you the astronomical zodiac sign rather the zodiac sign calculated by 365.25 days in year, so there should be about 14 days difference.
  ZodiacSign zodiacSign() {
    int d = (_dayIn28YearsTkufotCycle(this.gdn) + 1) * DAY - 1;
    return ZodiacSign.values[(d ~/ MAZAL) % 12];
  }

  int tkufaParts() {
    int parts = (this.gdn + 1 - DAYS_OF_TKUFA_CYCLE_4117) * DAY - 1;
    parts = parts - (parts % TKUFA);
    parts += DAYS_OF_TKUFA_CYCLE_4117 * DAY;
    return parts;
  }

  HebrewMonth tkufaType() {
    int d = (_dayIn28YearsTkufotCycle(this.gdn) + 1) * DAY - 1;
    d = d ~/ TKUFA;
    return HebrewMonth.values[(HebrewMonth.NISAN.index + (d % 4) * 3) % 14];
  }

  int dayOfZodiacSign() {
    int d = (_dayIn28YearsTkufotCycle(this.gdn) + 1) * DAY - 1;
    d = d % MAZAL;
    return (d ~/ DAY);
  }

  int dayOfTkufa() {
    int d = (_dayIn28YearsTkufotCycle(this.gdn) + 1) * DAY - 1;
    d = d % TKUFA;
    return (d ~/ DAY);
  }

  static int _dayIn28YearsTkufotCycle(
      int gdn) //when this method return 0, we need to do sun blessing in nissan.
  {
    //10227=number of days in 28 years when year=365.25 days
    return (gdn - DAYS_OF_TKUFA_CYCLE_4117) % 10227;
    //this date (1503540) is 19 in Nisan, 4117, wednesday
    //there is 112 tkofut in 28 year (4*28) or in 10227 days
    //you can find out which tkufa by tkufa=TkufotCycle()*112/10227
    //and that tkufa started at tkufa*10227/112
    //which is actually 1461/16 or 16/1461
  }

  int get moladParts => moladPartsOfMonth(_month);

  int moladPartsOfMonth(int month) {
    return _yearGParts + (month - 1) * MONTH;
  }

  static final List<List<int>> possibleMonthDay = [
    [ADate.MONDAY, ADate.TUESDAY, ADate.THURSDAY, ADate.SATURDAY], //TISHREI
    [ADate.MONDAY, ADate.WEDNESDAY, ADate.THURSDAY, ADate.SATURDAY], //CHESHVAN
    [
      ADate.SUNDAY,
      ADate.MONDAY,
      ADate.TUESDAY,
      ADate.WEDNESDAY,
      ADate.THURSDAY,
      ADate.FRIDAY
    ], //KISLEV
    [
      ADate.SUNDAY,
      ADate.MONDAY,
      ADate.TUESDAY,
      ADate.WEDNESDAY,
      ADate.FRIDAY
    ], //TEVET
    [
      ADate.MONDAY,
      ADate.TUESDAY,
      ADate.WEDNESDAY,
      ADate.THURSDAY,
      ADate.SATURDAY
    ], //SHEVAT
    [ADate.MONDAY, ADate.WEDNESDAY, ADate.FRIDAY, ADate.SATURDAY], //ADAR
    [ADate.MONDAY, ADate.WEDNESDAY, ADate.THURSDAY, ADate.SATURDAY], //ADAR_I
    [ADate.MONDAY, ADate.WEDNESDAY, ADate.FRIDAY, ADate.SATURDAY], //ADAR_II
    [ADate.SUNDAY, ADate.TUESDAY, ADate.THURSDAY, ADate.SATURDAY], //NISAN
    [ADate.MONDAY, ADate.TUESDAY, ADate.THURSDAY, ADate.SATURDAY], //IYAR
    [ADate.SUNDAY, ADate.TUESDAY, ADate.WEDNESDAY, ADate.FRIDAY], //SIVAN
    [ADate.SUNDAY, ADate.TUESDAY, ADate.THURSDAY, ADate.FRIDAY], //TAMMUZ
    [ADate.MONDAY, ADate.WEDNESDAY, ADate.FRIDAY, ADate.SATURDAY], //AV
    [ADate.SUNDAY, ADate.MONDAY, ADate.WEDNESDAY, ADate.FRIDAY] //ELUL
  ];
  static final List<List<int>> possibleMonthLength = [
    [30], //TISHREI
    [29, 30], //CHESHVAN
    [29, 30], //KISLEV
    [29], //TEVET
    [30], //SHEVAT
    [29], //ADAR
    [30], //ADAR_I
    [29], //ADAR_II
    [30], //NISAN
    [29], //IYAR
    [30], //SIVAN
    [29], //TAMMUZ
    [30], //AV
    [29] //ELUL
  ];
  int numberOfShabbats() {
    int yearDayInWeek = _yearFirstDay % 7;
    int diy = ADate.getNext(ADate.SATURDAY, yearDayInWeek) - yearDayInWeek;
    return (_yearLength - (diy) + 6) ~/ 7;
  }

  /// I heard that one said that if 3 Shevat falls on Friday, There will be a cold winter in that year
  bool yearOfColdWinter() {
    return monthIdFirstDay(HebrewMonth.SHEVAT) % 7 == DayOfWeek.Wednesday.index;
  }

  /**
     * 
     * @param tkufa 0 -Tishrei, 1- Tevet, 2 - Nisan , 3- Tammuz
     * @return tkufa parts from beginning
     */
  /*@untested*/
  int tkufaIndexParts(
      Tkufa tkufaIndex) //0 -Tishrei, 1- Tevet, 2 - Nisan , 3- Tammuz
  {
    int tkufa_parts = ((_year - 4117) * 4 - 2 + tkufaIndex.index) * TKUFA +
        DAYS_OF_TKUFA_CYCLE_4117 * DAY;
    return tkufa_parts;
  }

  /**
     * 
     * @param tkufa 0 -Tishrei, 1- Tevet, 2 - Nisan , 3- Tammuz
     * @return day since beginning for that tkufa in the current year.
     */
  int tkufaIndexDay(
      Tkufa tkufaIndex) //0 -Tishrei, 1- Tevet, 2 - Nisan , 3- Tammuz
  {
    int tkufa_parts = ((_year - 4117) * 4 - 2 + tkufaIndex.index) * TKUFA;
    return (tkufa_parts ~/ DAY) + DAYS_OF_TKUFA_CYCLE_4117;
  }

  bool sayTenTalVeMatar(bool diaspora) {
    if (diaspora) {
      int starting = tkufaIndexDay(Tkufa.TISHREI) +
          59; // the sixty day from when Tkufat Tishrei begins (first day in count)
      if (gdn < starting) {
        return false;
      }
    } else {
      if (_dayInYear < 36) {
        //36 is day in year of 7 in Cheshvan
        return false;
      }
    }
    int pessach_day = HebrewDateToolkit.dayInYearByMonthId(
        _yearLength, HebrewMonth.NISAN, 15);
    if (_dayInYear >= pessach_day) {
      return false;
    }
    return true;
  }

  bool tkufatNisanMeshaberetIlanot() {
    Planet tkufaPlanet = planetOfHour(tkufaIndexParts(
        Tkufa.NISAN)); //2 is for Tkufat Nisan, 0 - Tkufat Tishrei
    Planet moladPlanet = planetOfHour(moladPartsOfMonth(
        _monthFromIDByYearLength(yearLength, HebrewMonth.NISAN)));
    return (tkufaPlanet == Planet.Jupiter &&
        (moladPlanet == Planet.Jupiter || moladPlanet == Planet.Moon));
  }

  /**
     * based on Gemara in Eruvin (.56 / .נו)
     * @return 
     */
  /*@untested*/
  bool tkufatTavetMeyabeshetZeraim() {
    Planet tkufaPlanet =
        planetOfHour(tkufaIndexParts(Tkufa.TEVET)); // 1 for Tkufat Tevet
    Planet moladPlanet = planetOfHour(moladPartsOfMonth(
        _monthFromIDByYearLength(yearLength, HebrewMonth.TEVET)));
    return (tkufaPlanet == Planet.Jupiter &&
        (moladPlanet == Planet.Jupiter || moladPlanet == Planet.Moon));
  }

  /**
     * find out when B' H' B' (monday-thursday-monday) after Sukkot...
     *
     * @return day (in GDN) for the Shabbat before the first taanit
     * monday.
     */
  int taanitBetHehBetForCheshvan() {
    /* 1 in tishrey is day 0 (since beginning of the year). tishrey has 30 days. so 30 in tishrey is day 29. and 1 cheshvan is day 30.
         */
    return ADate.getNext(
        ADate.SATURDAY,
        _yearFirstDay +
            31); // 31 is 2 in cheshvan, we need the first saturday after Rosh Chodesh
  }

  /**
     * find out when B' H' B' (monday-thursday-monday) after Pesach... There is a tradition to bless
     * those who fast in these days in the Shabbat before the Taaniot
     *
     * @return day (in GDN) for the Shabbat before the first taanit
     * monday. to get first monday you add 2, to get thursday you add 5, to get second monday you add 9.
     */
  int taanitBetHehBetForIyar() {
    //we need the first saturday after Rosh Chodesh, this is why we add +1
    return ADate.getNext(
        ADate.SATURDAY,
        monthIdFirstDay(HebrewMonth.IYAR) +
            1); //+2 to get first monday, +5 to get thursday, and +9 to get the last monday.
  }

  /**
     get the formal year type in Hebrew letters.
    */
  HebrewYearSign yearSign() {
    int day_of_pessah = HebrewDateToolkit.dayInYearByMonthId(
            _yearLength, HebrewMonth.NISAN, 15) +
        _yearFirstDay;
    return HebrewYearSign([
      HebrewAlphaBet.values[_yearFirstDay % 7],
      [
        HebrewAlphaBet.Chet,
        HebrewAlphaBet.Kaf,
        HebrewAlphaBet.Shin
      ][_yearLength % 10 - 3],
      HebrewAlphaBet.values[day_of_pessah % 7]
    ],HebrewDateToolkit.isLeap(_yearLength)?YearLeapType.MEUBERET:YearLeapType.PESHUTA);
  }
  bool get isRoshChodesh {
        return (_day == 30 || _day == 1);
    }
  ChanukkahDay get dayOfChanukkah {
        int diy = dayInYear;
        int chnkday = HebrewDateToolkit.dayInYearByMonthId(_yearLength, HebrewMonth.KISLEV, 25);
        return (diy >= chnkday && diy < chnkday + 8) ?
        ChanukkahDay.values[ diy - chnkday + ChanukkahDay.DAY_I.index] : ChanukkahDay.NONE;
    }
    /**
     * if nine av is nidcha (postponed), return ten av.
     * @return the day in year of the nine av fast day
     */
    int nineAvDayInYear() {
        int nine_av = HebrewDateToolkit.dayInYearByMonthId(_yearLength, HebrewMonth.AV, 9); // 9 in Av.
        if ((nine_av + _yearFirstDay) % 7 == ADate.SATURDAY) {
            ++nine_av;
        }
        return nine_av;
    }
    /**
     * @return Whether current date is Nine at Av or not.
     */
    bool get isNineAv{

        return dayInYear == nineAvDayInYear(); // 9 in Av.
    }
    bool get isPurimPerazim {
        return (monthID == HebrewMonth.ADAR || monthID == HebrewMonth.ADAR_II) && dayInMonth == 14;
    }
    bool get isShushanPurim {
        return (monthID == HebrewMonth.ADAR || monthID == HebrewMonth.ADAR_II) && dayInMonth == 15;
    }
    bool get isRoshHaShana {
        return dayInYear < 2;
    }
    bool get isShabbat {
        return dayOfWeek == DayOfWeek.Saturday;
    }
    bool get isSheniChamishi {
        return dayOfWeek == DayOfWeek.Thursday || dayOfWeek == DayOfWeek.Monday;
    }
    
    bool get isKippurDay {
        const int KIPPUR_DAY_IN_YEAR = 9;// 10 in Tishrei.
        return dayInYear == KIPPUR_DAY_IN_YEAR; 
    }
    bool get isTzomGedaliah {
        const int THIRD_DAY = 2;// 3 in Tishrei.
        const int FOURTH_DAY = 3;// 4 in Tishrei.
        return (yearFirstDayWeekDay == DayOfWeek.Thursday)? //year started on thursday, so the tzom nidkha
                (dayInYear == FOURTH_DAY) : (dayInYear == THIRD_DAY); 
    }
    bool get isTzomTenthTevet {
        return  (monthID == HebrewMonth.TEVET && dayInMonth == 10);
    }
    bool get isTaanitEsther {
        return (monthID == HebrewMonth.ADAR || monthID == HebrewMonth.ADAR_II) &&
                ((dayInMonth == 11 &&
                 dayOfWeek == DayOfWeek.Thursday) || (dayInMonth == 13 && dayOfWeek != DayOfWeek.Saturday));
    }
    bool get isTzomSeventeenTammuz {
        return (monthID == HebrewMonth.TAMMUZ) &&
                ( (dayInMonth == 18 && dayOfWeek == DayOfWeek.Sunday)
                || (dayInMonth == 17 && dayOfWeek != DayOfWeek.Saturday));
    }
    bool isSuccotShminiAtzeret(bool diaspora) {
        int from = 15; // 15 in Tishrei
        int to = diaspora? 23 : 22; // 23 or 22 in Tishrei
        return monthID == HebrewMonth.TISHREI && dayInMonth>= from && dayInMonth<=to;
    }
    bool isPassover(bool diaspora) {
        int from = 15; // 15 in Nisan
        int to = diaspora? 22 : 21; // 22 or 21 in Nisan
        return monthID == HebrewMonth.NISAN && dayInMonth>= from && dayInMonth<=to;
    }
    bool isShavuoth(bool diaspora) {
        int from = 6; // 6 in Sivan
        int to = diaspora? 7 : 6; // 7 or 6 in Sivan
        return monthID == HebrewMonth.SIVAN && dayInMonth>= from && dayInMonth<=to;
    }
    /*
    including Shmini Atzeret
    */
    bool isRegel(bool diaspora) {
        return (isShavuoth(diaspora) || isSuccotShminiAtzeret(diaspora) || isPassover(diaspora) );
    }
    bool isSimchatTorah(bool diaspora) {
        int simchatTorahDayInMonth = diaspora? 23 : 22;
        return monthID == HebrewMonth.TISHREI && dayInMonth == simchatTorahDayInMonth;
    }
}
