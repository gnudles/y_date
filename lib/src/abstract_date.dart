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


enum DayOfWeek {
  /// Sunday is named after the Sun - Sunne in old english
  Sunday,

  /// Monday is named after the Moon - Mōna in old english
  Monday,

  /// Tuesday is named after Mars - Tīw in old english
  Tuesday,

  /// Wednesday is named after Mercury - Wōden in old english
  Wednesday,

  /// Thursday is named after Jupiter - Þunor in old english
  Thursday,

  /// Friday is named after Venus - frig in old english
  Friday,

  /// Saturday is named after Saturn - Sætern in old english
  Saturday
}

class DateSyncGroup {
  List<ADate> dateSystems = List();
  List<Function(ADate)> onChangeCallbacks = List();
  static const int INVALID_BOUND = -1;
  /*
     * common lower bound in GDN.
     */
  int _lowerCommonBound = INVALID_BOUND;
  /*
     * common upper bound in GDN.
     */
  int _upperCommonBound = INVALID_BOUND;
  /*
     * Register a listner for a date change event.
     * The listner will recieve as a sender the date object that triggered the sync.
     * @param listener 
     */

  void _notifyDateChanged(ADate date) {
    onChangeCallbacks.forEach((callback) {
      callback(date);
    });
  }

  void add(ADate dateObject) {
    dateObject.setSyncGroup(this);
    dateSystems.add(dateObject);
    if (_lowerCommonBound == INVALID_BOUND ||
        _lowerCommonBound < dateObject.lowerBound)
      _lowerCommonBound = dateObject.lowerBound;
    if (_upperCommonBound == INVALID_BOUND ||
        _upperCommonBound > dateObject.upperBound)
      _upperCommonBound = dateObject.upperBound;
  }

  int _clippedGDN(int gdn) {
    if (gdn < _lowerCommonBound) return _lowerCommonBound;
    if (gdn >= _upperCommonBound) return _upperCommonBound - 1;
    return gdn;
  }

  bool _syncBy(ADate dateSync)     {
        if (!dateSync.valid)
            return false;
        int gdn = _clippedGDN(dateSync.gdn);
        bool clipped = (gdn!=dateSync.gdn);
        for (ADate date in dateSystems) {
            if (clipped || date != dateSync) //we will skip updating the sync object.
            {
                date._muteCallbacks=true;
                date.setByGDN(gdn);
                date._muteCallbacks=false;
            }
        }
        _notifyDateChanged(dateSync);
        for (ADate date in dateSystems) {
            date._triggerEvents();
        }
        return !clipped;
    }
}

abstract class ADate {
  static const int EPOCH_DAY = 2092591; //1.1.1970 - in gdn
  static const int SUNDAY = 0; //Sun - Sunne in old english
  static const int MONDAY = 1; //Moon - Mōna in old english
  static const int TUESDAY = 2; //Mars - Tīw in old english
  static const int WEDNESDAY = 3; //Mercury - Wōden in old english
  static const int THURSDAY = 4; //Jupiter - Þunor in old english
  static const int FRIDAY = 5; //Venus - frig in old english
  static const int SATURDAY = 6; //Saturn - Sætern in old english
  static const int JULIAN_DAY_OFFSET = 347997; // offset between gdn and jdn.

    /// Return the upper limit of the dating system in GDN.
    /// 
    /// 
     /* The upper bound of possible valid range.
     * The lower bound is in bounds, but the upper bound is out of the bounds.
     * @return the GDN of the upper bound.
     * related method: {@link #lowerBound}
     * for more information about GDN see {@link kapandaria.YDate.ADate#GDN}
     */
      int get upperBound;
    /*
     * The lower bound of possible valid range.
     * The lower bound is in bounds, but the upper bound is out of the bounds.
     * @return the GDN of the lower bound.
     * related method: {@link #upperBound}
     * for more information about GDN see {@link kapandaria.YDate.ADate#GDN}
     */
      int get lowerBound;
      bool get valid;
      bool desired;
      int get gdn;
      bool setByGDN(int gdn);
      bool seekBy(int offset) {
        return setByGDN(this.gdn+offset);
    }

      List<Function(ADate)> onChangeCallbacks = List();
      bool _muteCallbacks = false;
      DateSyncGroup _syncGroup;
      void setSyncGroup(DateSyncGroup syncGroup)
      {
            _syncGroup = syncGroup;
      }
      /*
     * Method to be called on each change, in order to update the sync group.
     * The state might change again if clipping occurs. 
     * If there is no sync group, clipping will be still active.
     * @return true if no clipping occured and the date is valid. false otherwise.
     */
     bool stateChanged()
    {
        bool inBounds = checkBounds(gdn);
        if (!_muteCallbacks)
        {
            if (_syncGroup!=null)
                return _syncGroup._syncBy(this);
            else
            {
                
                if (!inBounds)
                {
                    _muteCallbacks=true;
                    clip();
                    _muteCallbacks=false;
                }
                _triggerEvents();
                
            }
        }
        return inBounds;
    }
    bool clip()
    {
        if (gdn<lowerBound)
        {
            setByGDN(lowerBound);
            return true;
        }
        if (gdn>=upperBound)
        {
            setByGDN(upperBound-1);
            return true;
        }
        return false;
    }
    bool checkBounds(int gdn)
    {
        return (gdn >= lowerBound && gdn < upperBound);
    }
    void _triggerEvents()
    {
        onChangeCallbacks.forEach((callback) {callback(this);});
    }
    static DateTime gdn2DateTimeUtc(int gdn, double hour)//hour in utc
    {
        int millisecondsSinceEpoch =  (gdn - ADate.EPOCH_DAY) * 3600 * 24 * 1000;
        millisecondsSinceEpoch += (hour * 3600 * 1000).toInt();
        DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
    }
    static int getNext(int dayInWeek, int gdn) // return the upcoming diw (or today if it's that diw)
    {
        int diff = (dayInWeek - gdn % 7 + 7) % 7;
        return (gdn + diff);
    }

   static int getPrevious(int dayInWeek, int gdn) {
        return getNext(dayInWeek, gdn - 6);
    }
  DayOfWeek get dayOfWeek //starts from one
  {
    return DayOfWeek.values[gdn % 7] ;
  }
}

abstract class ADMYDate extends ADate
{
    int get year;
    int get month;
    int get dayInMonth;
    int get dayInYear;
    int get yearLength;
    int get monthLength;
    int get previousMonthLength;
    int get firstDayOfYearGDN;
    int get firstDayOfMonthGDN;
}
