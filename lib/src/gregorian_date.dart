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

/**
 *
 * @author Orr Dvori
 */
class GregorianDate extends ADMYDate
{
    /**
    * Number of days in 400 Gregorian years. The calculation is as follows:
    * Every four years we have an extra day in February. But every 100
    * years the previous rule doesn't take a place. In addition, every 400
    * year the rule of the 100 years doesn't take a place, and thus we do
    * have an extra day. So with the first rule we have in 400 years, 100
    * years with 366 days in them, and 300 years 365. And with the second
    * rule we have in 400 years, 96 years with 366 days in them, and 304
    * years 365. And with the third rule we have in 400 years, 97 years
    * with 366 days in them, and 303 years 365. To summerize this:
    * 97*366+303*365=146097.
    */
    static const int DAYS_IN_400 = 146097;
    /**
    * Number of days in regular four Gregorian years. The calculation is as
    * follows: Every regular four years we have an extra day in February.
    * To summerize this: 3*366+1*365=1461.
    */
    static const int DAYS_IN_4 = 1461;
    /**
    * The day of Jan. 1 1600 in the "beginning count". This constant is
    * important because for simplicity, we start all the calculations, only
    * after that date. Also this date starts a new cycle of 400 years.
    */
    static const int DAYS_OF_1600 = 1957451;// days since beginning up to year 1.1.1600 (14 in tevet, 5360)
    /**
    * The day of Jan. 1 2300 in the "beginning count" (GDN). I limited the date
    * calculation to that date.
    */
    static const int DAYS_OF_2300 = 2213121;
    static const int LEAP_YEAR_LENGTH = 366;
    static const int NORMAL_YEAR_LENGTH = 365;

    static const List<int> HUNDRED_OFFSET = [0, 36525, 36525 * 2 - 1, 36525 * 3 - 2];
    
    static const List<List<int>> months_days_offsets
           = [
               [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365],
               [0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366]
           ];
    
    static bool isLeap(int year) {
    /* 
    trick that work with unsigned 32 bit integers:
       uint32_t z=(0xc28f5c29*year)&0xf800000f;
       // 0xc28f5c29 is the multiplicative inverse of 25.
       // divide by 25. the modulo of 25 will be encoded in the 5 msb, and modulo of 16 in the low 4 bits (because 25*16 = 40)
       // z==0 checks if year modulo 400 is zero. z>=0x08000000 checks is year modulo 25 is not zero.
       return (z==0) || ((year&3)==0 && z>=0x08000000);
    */
       return ( (year % 400) == 0)||( (year % 4) == 0 && (year % 100) != 0);
    }
    
    static int calculateDayInYear(bool leap_year, int month, int day) {
       return months_days_offsets[leap_year ? 1 : 0][month - 1] + day - 1;
    }

    /**
     * get the GDN of the first day in the year
     * @param year
     * @return 
     */
    static int yearGDN(int year) {

       int years_since_1600 = year - 1600;
       int year_first_day = DAYS_OF_1600;
       year_first_day += DAYS_IN_400 * (years_since_1600 ~/ 400);
       year = years_since_1600 % 400;
       int hundred= year ~/ 100;
       year_first_day += HUNDRED_OFFSET[hundred];
       if (hundred == 0) {//if we are in the first hundred of the four hundreds
           year_first_day += ((year + 3) ~/ 4) + year * 365;
           return year_first_day; //finito!
       }
       //else if we are in one of the other 3 hundreds 
       year = year % 100;//get the year in this hundred.
       //in the first four years of those 3 hundreds we don't have a leap february.
       //so we try to do some tricks to skip an extra "if".
       //if the assumption (-1)/4 ==0 is incorrect (like in python), use the following code.
       if ((-1) ~/ 4 != 0) {//we can't save that extra "if" so we do the abs function.
           year_first_day += ((year - 1).abs() ~/ 4) + year * 365;
           //year_first_day += (((year == 0) ? 0 : year - 1) / 4) + year * 365;
       }
       else {//but if we are in java, that former "if" is optimized out (omitted).
           year_first_day += ((year - 1) ~/ 4) + year * 365;
       }
       return year_first_day;
    }

    
    /**
    * The Gregorian year. year 1 is the first year in CE. There is no year
    * zero. Year -1 is the last year before Common Era. Anyway, the valid
    * range for this variable is 1600..2299
    */
    int _year = 0;
    /**
    * The month in the year. There are twelve months in a year. The value
    * is in the range 1..12, while 1 denotes January, 2 denotes February ..
    * 12 denotes December
    */
    int _month = 0;
    /**
    * The day in the month. The value is in the range 1..31 .
    */
    int _day = 0;
    /**
    * The number of days in the year. The value may be only 365 or 366.
    */
    int _yearLength = 0;
    /**
    * The number of days from the beginning to the year's first day (1st of
    * January of the year)
    */
    int _yearFirstDay = 0;
    /**
    * The day in the year (or number of days after year beginning). 0
    * denotes the year's first day (1st of January of the year). the value
    * is in the range 0..364 in regular year and in the range 0..365 in a
    * leap year.
    */
    int _dayInYear = 0;
    /**
    * Is the date valid?
    */
    bool _valid = false;
    /** 
     * did last operation generated the desired date?
     */

    /**
    * empty constructor.
    * constructs empty invalid object.
    */
    GregorianDate() {
       this._valid = false;
       this.desired = false;
       this._year = 1;
       this._month = 1;
       this._day = 1;
       this._yearFirstDay = 0;
       this._yearLength = NORMAL_YEAR_LENGTH;
       this._dayInYear = 0;
    }
    
    /**
    * Simple copy constructor.
    * event handler and sync group are not cloned.
    * @param o object to be cloned.
    */
    GregorianDate.copyFrom(GregorianDate o) {
       this._valid = o._valid;
       this.desired = o.desired;
       this._year = o._year;
       this._month = o._month;
       this._day = o._day;
       this._yearFirstDay = o._yearFirstDay;
       this._yearLength = o._yearLength;
       this._dayInYear = o._dayInYear;
    }
    
    /**
    * Copy date from a given object to this. 
    * event handler and sync group are not cloned.
    * @param o object to copy from.
    */
    bool MimicDate(GregorianDate o) {
       this._valid = o._valid;
       this._year = o._year;
       this._month = o._month;
       this._day = o._day;
       this._yearFirstDay = o._yearFirstDay;
       this._yearLength = o._yearLength;
       this._dayInYear = o._dayInYear;
       this.desired = stateChanged();
       return this.desired;
    }


    /**
    * Constructs a date object by day, month and year.
    *
    * @param year Gregorian year in the range 1600..2299.
    * @param month Gregorian month (range 1..12, while 1 denotes January, 2
    * denotes February .. 12 denotes December).
    * @param day Gregorian day in month (range 1..31).
    */
    GregorianDate.fromYearMonthDay(int year, int month, int day) {
       _valid = false;
       setByYearMonthDay(year, month, day);
    }

    /**
    * Constructs a date object by a day in the "beginning count". The
    * "beginning count" starts in the extrapolated creation day according
    * to the jewish tradition.
    *
    * @param days number of days since the beginning to construct the date
    * object from it.
    */
    GregorianDate.fromGDN(int days) {
       _valid = false;
       setByGDN(days);
    }

    /**
    * Set the members of the class by day, month and year.
    *
    * @return true if that date can be calculated properly and false
    * otherwise.
    */
    bool setByYearMonthDay(int year, int month, int day) {
        
       if (year >= 1600 && year < 2300) {
           this.desired = true;
           this._year = year;
           //fix the month parameter
           if (month > 12) {
               month = 12;
               this.desired = false;
           }
           else if (month < 1) {
               month = 1;
               this.desired = false;
           }
           this._month = month;
           //calculate the year's first day in the "beginning count".
           this._yearFirstDay = yearGDN(this._year);
           //calculate the year's length.
           this._yearLength = isLeap(this._year) ? LEAP_YEAR_LENGTH : NORMAL_YEAR_LENGTH;
           //calculate the month's length.
           int month_length = monthLength;
           //fix the day parameter
           if (day > month_length) {
               day = month_length;
               this.desired = false;
           }
           else if (day < 1) {
               day = 1;
               this.desired = false;
           }

           this._day = day;
           this._dayInYear = calculateDayInYear(this._yearLength == LEAP_YEAR_LENGTH, this._month, this._day);
           this._valid = true;
           this.desired = this.desired && stateChanged();
           return this.desired;
       }
       else {
           this.desired = false;
           return false;
       }
    }

    @override
    bool setByGDN(int gdn) {
        if (!checkBounds(gdn)) {
            this.desired = false;
            return false;
        }
        if (valid && (gdn >= _yearFirstDay) && (gdn < _yearFirstDay + _yearLength ))
        {
            this._dayInYear = gdn -_yearFirstDay;
            setMonthDay(_dayInYear);
            this.desired = stateChanged();
            return this.desired;
        }
        int gd_year;
        int gd_year_first_day = gdn;
        int day_in_year = gdn;

        day_in_year -= DAYS_OF_1600; //start calculation from a year thar divisible by 400.
        gd_year = 1600 + 400 * ((day_in_year) ~/ DAYS_IN_400); // now get to our 400 years level
        day_in_year = day_in_year % DAYS_IN_400; // number of days since the beginning of current 400 years level.
        int h = (day_in_year * 4) ~/ DAYS_IN_400;// what hundred are we? 0 1 2 3 ? this consider leap years.
        int not_h0 = (h > 0) ? 1 : 0; //if not the first hundred in four hundreds
        gd_year += 100 * h; // advance the year to the current hundred
        day_in_year = day_in_year - HUNDRED_OFFSET[h];//get days after the currect century.
        int y_in_h = ((day_in_year + not_h0) * 4) ~/ DAYS_IN_4;// which year in this hundred? of course considering leap years.
        gd_year += y_in_h;// add years in century. now we finally found the specified year.
        int y_in_h_not0 = (y_in_h > 0) ? 1 : 0;//if y_in_h > 0 ? if not the first year in the century.
        day_in_year = day_in_year - (y_in_h * DAYS_IN_4 + 3) ~/ 4 + (y_in_h_not0 & not_h0);//we subtracted one day too much if we are not in the first year and not in the first hundred.
        //so we added it afterwards

        gd_year_first_day -= day_in_year;// get the first day of the year in GDN.
        this._year = gd_year;
        this._dayInYear = day_in_year;
        setMonthDay(day_in_year);
        this._yearFirstDay = gd_year_first_day;
        this._yearLength = isLeap(this._year) ? LEAP_YEAR_LENGTH : NORMAL_YEAR_LENGTH;
        this._valid = true;
        this.desired = stateChanged();
        return this.desired;

    }
/** The Fliegel and van Flandern algorithm */
    bool _setByDaysFvF(int days) {
       if (days >= DAYS_OF_1600 && days < DAYS_OF_2300) {
           int gd_day;
           int gd_month;
           int gd_year;
           {
               int l, n, i, j;
               l = days + 68569 + ADate.JULIAN_DAY_OFFSET;
               n = (4 * l) ~/ DAYS_IN_400;
               l = l - (DAYS_IN_400 * n + 3) ~/ 4;
               i = (4000 * (l + 1)) ~/ 1461001;
               /* that's 1,461,001 */
               l = l - (DAYS_IN_4 * i) ~/ 4 + 31;
               j = (80 * l) ~/ 2447;
               gd_day = l - (2447 * j) ~/ 80;
               l = j ~/ 11;
               gd_month = j + 2 - (12 * l);
               gd_year = 100 * (n - 49) + i + l;
           }

           this._year = gd_year;
           this._month = gd_month;
           this._day = gd_day;

           this._yearLength = isLeap(this._year) ? LEAP_YEAR_LENGTH : NORMAL_YEAR_LENGTH;
           this._dayInYear = calculateDayInYear(this._yearLength == LEAP_YEAR_LENGTH, this._month, this._day);
           this._yearFirstDay = days - this._dayInYear; //previously it was days_until_year(this.year);
           this._valid = true;
           this.desired = stateChanged();
           return this.desired ;
       }
       else {
           this.desired = false;
           return false;
       }
    }


    /**
     *
     * @return whether last operation gave desired result.
     */


       

    /**
    * Get the day in the month for that specific date.
    * @return the day number in range 1..31 .
    */
    @override
    int get dayInMonth {
       return this._day;
    }

    /**
    * Get the day in the year for that specific date.
    * Please note that the first day of the year (January 1) gives 0.
    * @return the day in range 0..364 or 0..365 in a leap year.
    */
    @override
    int get dayInYear {
       return this._dayInYear;
    }

    /**
     *
     * @return
     */
    @override
    int get year {
       return this._year;
    }

    @override
    int get month {
       return this._month;
    }

    @override
    int get gdn {
       return _yearFirstDay + _dayInYear;
    }

    /**
    * @return The GDN of the year's first day (1st of
    * January of the year)
    */
    int yearFirstDay() {
       return this._yearFirstDay;
    }

    

    @override
    int get monthLength
    {
       int mo_year_t = _yearLength - 365;
       return months_days_offsets[mo_year_t][_month] - months_days_offsets[mo_year_t][_month - 1];
    }
    

    @override
    int get previousMonthLength
    {
       if (this._month == 1)// prev month December is always 31 days
       {
           return 31;
       }
       int mo_year_t = _yearLength - 365;
       return months_days_offsets[mo_year_t][(_month - 1)] - months_days_offsets[mo_year_t][(_month - 1) - 1];
    }
    @override
    int get nextMonthLength
    {
       if (this._month == 12)//next month January is always 31 days
       {
           return 31;
       }
       int mo_year_t = _yearLength - 365; //isLeap
       return months_days_offsets[mo_year_t][(_month - 1) + 2] - months_days_offsets[mo_year_t][(_month - 1) + 1];
    }

    @override
    int get yearLength {
       return this._yearLength;
    }

    /**
     *
     * @return whether date represented is valid
     */
    
  @override
  
  bool get valid => _valid;

    @override
    int get firstDayOfYearGDN
    {
        return yearFirstDay();
    }

    /**
    * see {@link YDate.GregorianDate#yearFirstDay } for more information
    * @return The number of days in the "beginning count" to the first day in the current month.
    */
    @override
    int get firstDayOfMonthGDN
    {
        return _yearFirstDay + _dayInYear - _day + 1;
    }

    
    @override
    int get upperBound
    {
        return DAYS_OF_2300;
    }

    @override
    int get lowerBound
    {
        return DAYS_OF_1600;
    }
  





    double JulianDay() {
       return gdn + ADate.JULIAN_DAY_OFFSET - 0.5;
    }


    /**
    * Sets the month and day in month according to the day in year.
    *
    * @param days day in the year.
    */
    void setMonthDay(int days) {
       int mo_year_t = isLeap(this._year) ? 1 : 0;
       int m = days * 2 ~/ 61;
       if (months_days_offsets[mo_year_t][m] > days) {
           m--;
       }
       else if (months_days_offsets[mo_year_t][m + 1] <= days) {
           m++;
       }
       this._month = m + 1;
       this._day = days - months_days_offsets[mo_year_t][m] + 1;
       //TODO: create a static version for this method.
    }

    bool stepMonthForward(bool cyclic) {
       return setByYearMonthDay(_year + (cyclic ? 0 : (_month == 12 ? 1 : 0)), (_month % 12) + 1, _day);
    }

    bool stepMonthBackward(bool cyclic) {
       return setByYearMonthDay(_year - (cyclic ? 0 : (_month == 1 ? 1 : 0)), ((_month + 10) % 12) + 1, _day);
    }
    bool stepDayForwardCyclic() {
        int new_day = (_day == monthLength)? 1 : _day + 1;
        return setByYearMonthDay(_year, _month, new_day);
    }
    bool stepDayBackwardCyclic() {
        int new_day = (_day == 1)? monthLength : _day - 1;
        return setByYearMonthDay(_year, _month, new_day);
    }


    /*String monthName(YDateLanguage language) {
       return language.getGregMonthToken(this._month - 1);
    }*/
    
    /**
    * This method gives you a formatted string of the current date.
    * @param language The language object in which the string will be formatted.
    * @return a string in the format "August 1, 1999".
    */
    /*String dayString(YDateLanguage language) {
       return language.FormatGregorianDate(_day, _month, _year,dayOfWeekEnum());
    }*/



}
