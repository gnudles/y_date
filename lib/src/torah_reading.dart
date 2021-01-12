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

import 'abstract_date.dart';
import 'hebrew_date.dart';
import 'dart:math';

enum Sidra {
  __NONE,
  BERESHIT,
  NOACH,
  LECH_LECHA,
  VAYERA,
  CHAYEI_SARAH,
  TOLDOT,
  VAYETZE,
  VAYISHLACH,
  VAYESHEV,
  MIKETZ,
  VAYIGASH,
  VAYECHI,
  SHEMOT,
  VAERA,
  BO,
  BESHALACH,
  YITRO,
  MISHPATIM,
  TERUMAH,
  TETZAVEH,
  KI_TISA,
  VAYAKHEL,
  PEKUDEI,
  VAYIKRA,
  TZAV,
  SHEMINI,
  TAZRIA,
  METZORA,
  ACHREI_MOT,
  KEDOSHIM,
  EMOR,
  BEHAR,
  BECHUKOTAI,
  BAMIDBAR,
  NASO,
  BEHAALOTCHA,
  SHELACH_LECHA,
  KORACH,
  CHUKAT,
  BALAK,
  PINCHAS,
  MATOT,
  MASEI,
  DEVARIM,
  VAETCHANAN,
  EKEV,
  REEH,
  SHOFTIM,
  KI_TETZE,
  KI_TAVO,
  NITZAVIM,
  VAYELECH,
  HAAZINU,
  VEZOT_HABERACHA,
  __1_55,
  __2_56,
  __3_57,
  __4_58,
  __5_59,
  __6_60,
  __7_61,
  __8_62,
  __9_63,
  __10_64,
  __11_65,
  __12_66,
  __13_67,
  __14_68,
  __15_69,
  __16_70,
  __17_71,
  __18_72,
  __19_73,
  __20_74,
  __21_75,
  VAYAKHEL__PEKUDEI,
  __23_77,
  __24_78,
  __25_79,
  __26_80,
  TAZRIA__METZORA,
  __28_82,
  ACHREI_MOT__KEDOSHIM,
  __30_84,
  __31_85,
  BEHAR__BECHUKOTAI,
  __33_87,
  __34_88,
  __35_89,
  __36_90,
  __37_91,
  __38_92,
  CHUKAT__BALAK,
  __40_94,
  __41_95,
  MATOT__MASEI,
  __43_97,
  __44_98,
  __45_99,
  __46_100,
  __47_101,
  __48_102,
  __49_103,
  __50_104,
  NITZAVIM__VAYELECH,
  __52_106,
  __53_107,
  __54_108,
}
enum TorahReadingType {
  TLAT_GAVREY_PARASHA,
  SHIVA_OLIM_PARASHA,
  MAFTIR_PARASHA,
  MAFTIR_MACHAR_CHODESH,
  MAFTIR_ROSH_CHODESH,
  MAFTIR_CHANUKKAH,
  MAFTIR_SHABBAT_PARAH,
  VAYCHAL_MOSHE_TAANIT,
  HAFTARAH,
  MEGILAT_ESTHER,
  MEGILAT_EICHA,
  MEGILAT_RUTH,
  MEGILAT_KOHELET
}
/*
BERESHIT,BERESHIT,[(1,1),(2,3)],[(2,4),(2,19)],[(2,20),(3,21)],[(3,22),(4,18)],[(4,19),(4,22)],[(4,23),(5,24)],[(4,23),(5,24)],[(5,25),(6,8)],
NOACH,BERESHIT,
LECH_LECHA,BERESHIT,
VAYERA,BERESHIT,
CHAYEI_SARAH,BERESHIT,
TOLDOT,BERESHIT,
VAYETZE,BERESHIT,
VAYISHLACH,BERESHIT,
VAYESHEV,BERESHIT,
MIKETZ,BERESHIT,
VAYIGASH,BERESHIT,
VAYECHI,BERESHIT,
SHEMOT,SHEMOT,
VAERA,SHEMOT,
BO,SHEMOT,
BESHALACH,SHEMOT,
YITRO,SHEMOT,
MISHPATIM,SHEMOT,
TERUMAH,SHEMOT,
TETZAVEH,SHEMOT,
KI_TISA,SHEMOT,
VAYAKHEL,SHEMOT,
PEKUDEI,SHEMOT,
VAYIKRA,VAYIKRA,
TZAV,VAYIKRA,
SHEMINI,VAYIKRA,
TAZRIA,VAYIKRA,
METZORA,VAYIKRA,
ACHREI_MOT,VAYIKRA,
KEDOSHIM,VAYIKRA,
EMOR,VAYIKRA,
BEHAR,VAYIKRA,
BECHUKOTAI,VAYIKRA,
BAMIDBAR,BAMIDBAR,
NASO,BAMIDBAR,
BEHAALOTCHA,BAMIDBAR,
SHELACH_LECHA,BAMIDBAR,
KORACH,BAMIDBAR,
CHUKAT,BAMIDBAR,
BALAK,BAMIDBAR,
PINCHAS,BAMIDBAR,
MATOT,BAMIDBAR,
MASEI,BAMIDBAR,
DEVARIM,DEVARIM,
VAETCHANAN,DEVARIM,
EKEV,DEVARIM,
REEH,DEVARIM,
SHOFTIM,DEVARIM,
KI_TETZE,DEVARIM,
KI_TAVO,DEVARIM,
NITZAVIM,DEVARIM,
VAYELECH,DEVARIM,
HAAZINU,DEVARIM,
VEZOT_HABERACHA,DEVARIM,
*/

class SingleTorahReading {
  SingleTorahReading(this.type, {this.sidra = Sidra.__NONE, this.text});
  TorahReadingType type;
  Sidra sidra;
  BibleText text;
}

/*
        
        
Bereishit - Genesis
Shemot - Exodus
Vayikra - Leviticus
Bamidbar - Numbers
Devarim - Deuteronomy
Nevi'im - Prophets
Yehoshua - Joshua
Shoftim - Judges
Shmuel I - I Samuel
Shmuel II - II Samuel
Melachim I - I Kings
Melachim II - II Kings
Yeshayahu - Isaiah
Yirmiyahu - Jeremiah
Yechezkel - Ezekiel
Hoshea - Hosea
Yoel - Joel
Amos
Ovadiah - Obadiah
Yonah - Jonah
Michah - Micah
Nachum - Nahum
Chavakuk - Habakkuk
Tzefaniah - Zephaniah
Chaggai - Haggai
Zechariah
Malachi
Ketuvim - Scriptures
Tehillim - Psalms
Mishlei - Proverbs
Iyov - Job
Shir Hashirim - Song of Songs
Rut - Ruth
Eichah - Lamentations
Kohelet - Ecclesiastes
Esther
Daniel
Ezra
Nechemiah - Nehemiah
Divrei Hayamim I - I Chronicles
Divrei Hayamim II - II Chronicles
        */
enum BibleBook {
  Bereshit,
  Shemot,
  Vayikra,
  Bamidbar,
  Devarim,
  Yehosuah,
  Shoftim,
  Shmuel_I,
  Shmuel_II,
  Melachim_I,
  Melachim_II,
  Yeshaayah,
  Yirmiyah,
  Yechezkel,
  Hushea,
  Yoel,
  Amos,
  Ovadiah,
  Yonah,
  Michah,
  Nachum,
  Chavakuk,
  Tzefaniah,
  Chagay,
  Zechariah,
  Malachi,
  Tehilim,
  Mishley,
  Iyob,
  ShirHashirim,
  Ruth,
  Eichah,
  Kohelet,
  Esther,
  Daniel,
  Ezra,
  Nechemiah,
  DivreyHayamim_I,
  DivreyHayamim_II,
}

class BibleIndex {
  static int create(BibleBook book, int chapter, int verse) {
    return book.index | (chapter & 0x3ff) << 6 | (verse) << 16;
  }

  static BibleBook getBook(int bible_index) {
    return BibleBook.values[bible_index & 0x3f];
  }

  static int getChapter(int bible_index) {
    return (bible_index >> 6) & 0x3ff;
  }

  static int getVerse(int bible_index) {
    return (bible_index >> 16);
  }
  //TODO: add formating of verses.
}

class BibleParagraph {
  int m_start_index;
  int m_end_index;

  BibleParagraph(int start, int end) {
    m_start_index = start;
    m_end_index = end;
  }
}

class BibleText {
  String m_name;
  List<BibleParagraph> m_paragraphs;
  BibleText(String name) {
    m_name = name;
    m_paragraphs = List();
  }
  BibleText.withParagraph(String name, BibleParagraph p) {
    m_name = name;
    m_paragraphs = List();
    m_paragraphs.add(p);
  }
  BibleText.from(BibleText obj) {
    m_name = obj.m_name;
    m_paragraphs = [...obj.m_paragraphs];
  }
  BibleText append(BibleParagraph p) {
    m_paragraphs.add(p);
    return this;
  }

  BibleText prepend(BibleParagraph p) {
    m_paragraphs.insert(0, p);
    return this;
  }
}

enum HaftaraMinhag { SFARADIM, ASHKENAZ, ITALKI, TEIMANI, CHABAD, FRANKFURT }
enum NamedShabbat {
  REGULAR,
  SHABBAT_SHKALIM,
  SHABBAT_ZAKHOR,
  SHABBAT_PARA,
  SHABBAT_HACHODESH,
  SHABBAT_HAGADOL,
  SHABBAT_SHIRA,
  SHABBAT_NACHAMU,
  SHABBAT_TSHUVA
}

class TorahReading {
  //based on shulhan aruch ORACH HAIM SIMAN 428 SEIF 4
  static List<int> double_reading = [
    Sidra.VAYAKHEL.index /*22*/,
    Sidra.TAZRIA.index /*27*/,
    Sidra.ACHREI_MOT.index /*29*/,
    Sidra.BEHAR.index /*32*/,
    Sidra.CHUKAT.index /*39*/,
    Sidra.MATOT.index /*42*/,
    Sidra.NITZAVIM.index /*51*/
  ];
  /* outside israel!:
    *  joining   year type      1   2   3   4   5   6   7
    * 22 - Vayakhel Pekudei     V   V   V   V   V   X   V
    * 27 - Tazria Metzora       V   V   V   V   V   V   V
    * 29 - Achrei-Mot Kedoshim  V   V   V   V   V   V   V
    * 32 - Behar Bechukotai     V   V   V   V   V   V   V
    **39 - Chukat Balak         X   X   V   X   V   X   X
    * 42 - Matot Mas'ei         V   V   V   V   V   V   V
    * 51 - Nitzavim Vayelech    V   X   V   X   V   X   V
    * Compatible with Israel    +   +   -   -   -   +   -
    *  joining   year type      8   9   10  11  12  13  14
    * 22 - Vayakhel Pekudei     X   X   X   X   X   X   X
    * 27 - Tazria Metzora       X   X   X   X   X   X   X
    * 29 - Achrei-Mot Kedoshim  X   X   X   X   X   X   X
    * 32 - Behar Bechukotai     X   X   X   X   X   X   X
    **39 - Chukat Balak         V   X   X   X   X   X   V
    * 42 - Matot Mas'ei         V   X   V   V   V   X   V
    * 51 - Nitzavim Vayelech    V   X   V   X   X   V   V
    * Compatible with Israel    -   +   +   -   -   +   -
    * In Israel:
    *  joining   year type      3   4   5   7   8   11  12  14
    * 22 - Vayakhel Pekudei     V   V   V   V   X   X   X   X
    * 27 - Tazria Metzora       V   V   V   V   X   X   X   X
    * 29 - Achrei-Mot Kedoshim  V   V   V   V   X   X   X   X
    * 32 - Behar Bechukotai     V   X   V   V   X   X   X   X
    **39 - Chukat Balak         X   X   X   X   X   X   X   X
    * 42 - Matot Mas'ei         V   V   V   V   V   X   X   V
    * 51 - Nitzavim Vayelech    V   X   V   V   V   X   X   V
    * you can obtain the joining in israel by copying the joining outside IL and removing Chukat Balak joining,
    * except year type 4,11,12 where you should remove Behar Bechukotai in year type 4 and Matot Mas'ei in year types 11,12
    */
  static const List<List<int>> SIDRA_JOIN = [
    //lsb to msb : 22, 27, 29, 32, 39, 42, 51
    [
      //Diaspora
      0x6f //1, 1, 1, 1, 0, 1, 1
      , //1
      0x2f //1, 1, 1, 1, 0, 1, 0
      , //2
      0x7f //1, 1, 1, 1, 1, 1, 1
      , //3
      0x2f //1, 1, 1, 1, 0, 1, 0
      , //4
      0x7f //1, 1, 1, 1, 1, 1, 1
      , //5
      0x2e //0, 1, 1, 1, 0, 1, 0
      , //6
      0x6f //1, 1, 1, 1, 0, 1, 1
      , //7
      0x70 //0, 0, 0, 0, 1, 1, 1
      , //8
      0x00 //0, 0, 0, 0, 0, 0, 0
      , //9
      0x60 //0, 0, 0, 0, 0, 1, 1
      , //10
      0x20 //0, 0, 0, 0, 0, 1, 0
      , //11
      0x20 //0, 0, 0, 0, 0, 1, 0
      , //12
      0x40 //0, 0, 0, 0, 0, 0, 1
      , //13
      0x70 //0, 0, 0, 0, 1, 1, 1
      //14
    ],
    [
      0x6f //1, 1, 1, 1, 0, 1, 1
      , //1
      0x2f //1, 1, 1, 1, 0, 1, 0
      , //2
      0x6f //1, 1, 1, 1, 0, 1, 1
      , //3
      0x27 //1, 1, 1, 0, 0, 1, 0
      , //4
      0x6f //1, 1, 1, 1, 0, 1, 1
      , //5
      0x2e //0, 1, 1, 1, 0, 1, 0
      , //6
      0x6f //1, 1, 1, 1, 0, 1, 1
      , //7
      0x60 //0, 0, 0, 0, 0, 1, 1
      , //8
      0x00 //0, 0, 0, 0, 0, 0, 0
      , //9
      0x60 //0, 0, 0, 0, 0, 1, 1
      , //10
      0x00 //0, 0, 0, 0, 0, 0, 0
      , //11
      0x00 //0, 0, 0, 0, 0, 0, 0
      , //12
      0x40 //0, 0, 0, 0, 0, 0, 1
      , //13
      0x60 //0, 0, 0, 0, 0, 1, 1
      //14
    ]
  ];
  static const int NUM_SIDRA_54 = 54;

  static final List<String> sidraToken =
      Sidra.values.getRange(0, 55).map((e) => "sidra_" + e.toString());
  /*
            = {
                "",
                "sidra_Bereshit",
                "sidra_Noach",
                "sidra_Lech_Lecha",
                "sidra_Vayera",
                "sidra_Chayei_Sarah",
                "sidra_Toldot",
                "sidra_Vayetze",
                "sidra_Vayishlach",
                "sidra_Vayeshev",
                "sidra_Miketz",
                "sidra_Vayigash",
                "sidra_Vayechi",
                "sidra_Shemot",
                "sidra_Vaera",
                "sidra_Bo",
                "sidra_Beshalach",
                "sidra_Yitro",
                "sidra_Mishpatim",
                "sidra_Terumah",
                "sidra_Tetzaveh",
                "sidra_Ki_Tisa",
                "sidra_Vayakhel",
                "sidra_Pekudei",
                "sidra_Vayikra",
                "sidra_Tzav",
                "sidra_Shemini",
                "sidra_Tazria",
                "sidra_Metzora",
                "sidra_Achrei_Mot",
                "sidra_Kedoshim",
                "sidra_Emor",
                "sidra_Behar",
                "sidra_Bechukotai",
                "sidra_Bamidbar",
                "sidra_Naso",
                "sidra_Behaalotcha",
                "sidra_Shelach_Lecha",
                "sidra_Korach",
                "sidra_Chukat",
                "sidra_Balak",
                "sidra_Pinchas",
                "sidra_Matot",
                "sidra_Masei",
                "sidra_Devarim",
                "sidra_Vaetchanan",
                "sidra_Ekev",
                "sidra_Reeh",
                "sidra_Shoftim",
                "sidra_Ki_Tetze",
                "sidra_Ki_Tavo",
                "sidra_Nitzavim",
                "sidra_Vayelech",
                "sidra_Haazinu",
                "sidra_Vezot_Haberacha"
            };*/

  static NamedShabbat FourParshiotEnum(HebrewDate h) {
    HebrewDate tweaked = new HebrewDate.from(h);

    if (h.dayOfWeek == DayOfWeek.Saturday) {
      tweaked.seekBy(6);
      if (tweaked.monthID ==
          HebrewMonth.NISAN) //maybe shabbat hachodesh or shabbat hagadol
      {
        if (tweaked.dayInMonth <= 7) {
          return NamedShabbat.SHABBAT_HACHODESH;
        }
      }
      if (tweaked.monthID == HebrewMonth.ADAR ||
          tweaked.monthID == HebrewMonth.ADAR_II) //adar or adar II
      {
        if (tweaked.dayInMonth <= 7) {
          return NamedShabbat.SHABBAT_SHKALIM;
        }
        if (h.dayInMonth < 14 && h.dayInMonth > 7) {
          return NamedShabbat.SHABBAT_ZAKHOR;
        }
        if (h.dayInMonth > 16) {
          return NamedShabbat.SHABBAT_PARA;
        }
      }
    }
    return NamedShabbat.REGULAR;
  }

  static NamedShabbat SpecialShabbatEnum(HebrewDate h) {
    NamedShabbat four_shabbats = FourParshiotEnum(h);
    if (four_shabbats != NamedShabbat.REGULAR) {
      return four_shabbats;
    }
    final int FromBereshitToBeshalach =
        Sidra.BESHALACH.index - Sidra.BERESHIT.index; // 15
    if (getShabbatBereshit(h.yearLength, h.firstDayOfYearGDN) +
            FromBereshitToBeshalach * 7 ==
        h.gdn) {
      return NamedShabbat.SHABBAT_SHIRA;
    }
    if (h.dayOfWeek == DayOfWeek.Saturday) {
      if (h.dayInMonth < 15 &&
          h.dayInMonth > 7 &&
          h.monthID == HebrewMonth.NISAN) {
        return NamedShabbat.SHABBAT_HAGADOL;
      }
      int shabbat_nachamu = h.firstDayOfYearGDN;
      shabbat_nachamu += HebrewDateToolkit.dayInYearByMonthId(
          h.yearLength, HebrewMonth.AV, 10);
      shabbat_nachamu = ADate.getNext(ADate.SATURDAY, shabbat_nachamu);

      if (h.gdn == shabbat_nachamu) {
        return NamedShabbat.SHABBAT_NACHAMU;
      }
      int shabbat_tshuva = h.firstDayOfYearGDN;
      shabbat_tshuva += HebrewDateToolkit.dayInYearByMonthId(
          h.yearLength, HebrewMonth.TISHREI, 9);
      shabbat_tshuva = ADate.getPrevious(ADate.SATURDAY, shabbat_tshuva);
      if (h.gdn == shabbat_tshuva) {
        return NamedShabbat.SHABBAT_TSHUVA;
      }
    }
    return NamedShabbat.REGULAR;
  }

/*
    static const int HOL_DAY = 0;
    static const int HOL_DAY_MONDAY_THURSDAY = 1;
    static const int SHABBAT_DAY = (1 << 1);
    static const int ROSH_CHODESH = (1 << 2);
    static const int REGALIM = (1 << 3);
    static const int REGALIM_DIASPORA = (1 << 4);
    static const int CHANUKKAH = (1 << 5);
    static const int PURIM = (1 << 6);
    static const int SHOSHAN_PURIM = (1 << 7);
    static const int TAANIT = (1 << 8);
    static const int EREV_ROSH_CHODESH = (1 << 9);
    static const int NINE_AV = (1 << 10);
    static const int KIPPUR = (1 << 11);
    static const int ROSH_HASHANA = (1 << 12);
    static const int SHABBAT_OF_HOL = (1 << 13);
    static const int SHABBAT_OF_HOL_DIASPORA = (1 << 14);
    
    static int getDayType(HebrewDate h)
    {
        
        bool rosh_chodesh = h.isRoshChodesh;
        bool erev_rosh_chodesh = (h.dayInMonth == 29) || (h.dayInMonth == 30);
        bool chanukkah = (h.dayOfChanukkah!= ChanukkahDay.NONE);
        bool purim = h.isPurimPerazim;
        bool shoshan_purim = h.isShushanPurim;
        bool sheni_hamishi = (h.dayOfWeek == DayOfWeek.Monday || h.dayOfWeek == DayOfWeek.Thursday);
        bool shabbat = (h.dayOfWeek == DayOfWeek.Saturday);
        bool four_taaniot = (h.isTzomGedaliah || h.isTzomTenthTevet
                || h.isTaanitEsther || h.isTzomSeventeenTammuz);
        bool regalim = h.isRegel(false);
        bool regalim_diasp = h.isRegel(true);
        bool nine_av = h.isNineAv;
        bool kippur = h.isKippurDay;
        bool rosh_hashana = h.isRoshHaShana;

        int type = 0;
        type += regalim ? REGALIM : 0;
        type += rosh_hashana ? ROSH_HASHANA : 0;
        type += kippur ? KIPPUR : 0;
        type += rosh_chodesh ? ROSH_CHODESH : 0;
        type += four_taaniot ? TAANIT : 0;
        type += shabbat ? SHABBAT_DAY : 0;
        type += chanukkah ? CHANUKKAH : 0;
        type += nine_av ? NINE_AV : 0;       
        type += (type == 0 && sheni_hamishi) ? HOL_DAY_MONDAY_THURSDAY : 0;
        
        type += erev_rosh_chodesh ? EREV_ROSH_CHODESH : 0;
        type += purim ? PURIM : 0;
        type += shoshan_purim ? SHOSHAN_PURIM : 0;
        type += regalim_diasp ? REGALIM_DIASPORA : 0;
        return type;
    }
*/
  static bool GetMegilatEsther(HebrewDate h, bool MukafHoma) {
    DayOfWeek diw = h.dayOfWeek;
    return ((h.isPurimPerazim &&
            MukafHoma &&
            diw == DayOfWeek.Friday) //purim meshulash
        ||
        (h.isPurimPerazim && (!MukafHoma)) ||
        (h.isShushanPurim && MukafHoma && diw != DayOfWeek.Saturday));
  }

  static List<SingleTorahReading> GetShaharitTorahReading(
      HebrewDate h, bool diaspora, bool MukafHoma) {
        bool FourTaaniot = h.isTzomGedaliah || h.isTzomTenthTevet
                    || h.isTaanitEsther || h.isTzomSeventeenTammuz;
        bool isLocalPurim = (h.isPurimPerazim && !MukafHoma)
                    || (h.isShushanPurim && MukafHoma);
        bool NineAv = h.isNineAv;
        Sidra parasha = Sidra.__NONE;
        if (!h.isKippurDay && !h.isRoshHaShana && h.isRegel(diaspora))
        {
            bool no_weekly_reading_hol = NineAv
                    || FourTaaniot
                    || isLocalPurim
                    || h.isRoshChodesh
                    || (h.dayOfChanukkah != ChanukkahDay.NONE);
                    
            if (h.isShabbat ||
                    (h.isSheniChamishi && !no_weekly_reading_hol))
            {
                parasha = GetSidraEnum(h, diaspora);
            }
        }
        
        List<SingleTorahReading>  readList;
        if (parasha !=  Sidra.__NONE)
        {
            
            if (h.isSheniChamishi && parasha.index > NUM_SIDRA_54)
            {
              parasha = Sidra.values[parasha.index- NUM_SIDRA_54];//on monday and thursday we only read the first of two connected.
            }
            if (h.isShabbat)
            {
              readList.add(SingleTorahReading(TorahReadingType.SHIVA_OLIM_PARASHA, sidra: parasha,text:null));
            }
            else if (h.isSheniChamishi)
            {
              readList.add(SingleTorahReading(TorahReadingType.TLAT_GAVREY_PARASHA, sidra: parasha));
            }
            
        }
        /*
        if (isLocalPurim)
        {
            if (h.isShabbat()) //not shabbat
            {
                lstr += ", ";                
            }
            lstr += "ויבא עמלק";
        }
        if (FourTaaniot)
        {
            lstr = "ויחל משה";
        }
        if (h.roshChodesh())
        {
            lstr = "קריאה לר\"ח";
        }
        if (NineAv)
        {
            lstr ="מגילת איכה";
        }
        if (h.dayOfChanukkah() > 0)
        {
            if (h.isShabbat()) 
            {
                lstr += ", ";
            }
            if (h.roshChodesh())
            {
                lstr +="קריאה לר\"ח וחנוכה";
            }
            else
            {
                lstr +="קריאה לחנוכה";
            }
        }
        return lstr;*/
        return readList;
    }
      
//TODO: reimplement this
  /*static String GetTorahReading(JewishDate h, bool diaspora, bool MukafHoma, YDateLanguage le)
    {
   
        bool FourTaaniot = h.isTzomGedaliah() || h.isTzomTenthTevet()
                    || h.isTaanitEsther() || h.isTzomSeventeenTammuz();
        bool isLocalPurim = (h.isPurimPerazim() && !MukafHoma)
                    || (h.isShushanPurim() && MukafHoma);
        bool NineAv = h.isNineAv();
        int parasha_num = 0;
        if (!h.isKippurDay() && !h.isRoshHaShana() && h.isRegel(diaspora))
        {
            bool no_weekly_reading_hol = NineAv
                    || FourTaaniot
                    || isLocalPurim
                    || h.roshChodesh()
                    || (h.dayOfChanukkah() > 0);
                    
            if (h.isShabbat() ||
                    (h.isSheniChamishi() && !no_weekly_reading_hol))
            {
                parasha_num = GetSidraEnum(h, diaspora).ordinal();
            }
        }
        
        String lstr = "";
        if (parasha_num > 0)
        {
            int sidra = parasha_num;
            if (h.isSheniChamishi() && sidra > NUM_SIDRA_54)
            {
                sidra -= NUM_SIDRA_54;//on monday and thursday we only read the first of two connected.
            }
            lstr += SidraEnumToString(sidra, le);
        }
        if (isLocalPurim)
        {
            if (h.isShabbat()) //not shabbat
            {
                lstr += ", ";                
            }
            lstr += "ויבא עמלק";
        }
        if (FourTaaniot)
        {
            lstr = "ויחל משה";
        }
        if (h.roshChodesh())
        {
            lstr = "קריאה לר\"ח";
        }
        if (NineAv)
        {
            lstr ="מגילת איכה";
        }
        if (h.dayOfChanukkah() > 0)
        {
            if (h.isShabbat()) 
            {
                lstr += ", ";
            }
            if (h.roshChodesh())
            {
                lstr +="קריאה לר\"ח וחנוכה";
            }
            else
            {
                lstr +="קריאה לחנוכה";
            }
        }
        return lstr;
    }*/
  /**
 * This method gives you the upcoming parasha. it is useful to know what parasha we should start studying.
 * @param h the hebrew date object
 * @param diaspora are we in the diaspora?
 * @return the string of the parasha.
 */
  static Sidra GetSidraEnum(HebrewDate h, bool diaspora) {
    int diy = h.dayInYear;
    int ydiw = h.firstDayOfYearGDN % 7;
    int pnum = 0;
    if (h.isSimchatTorah(diaspora)) {
      pnum = Sidra.VEZOT_HABERACHA.index; //Vezot Haberacha
    } else {
      Int8List sidra_array =
          _calculateSidraArray(h.yearLength, h.firstDayOfYearGDN, diaspora);
      if (h.isShabbat) // we are in shabbat
      {
        pnum = sidra_array[diy ~/ 7];
      }
      if (pnum == 0) {
        if (h.isSuccotShminiAtzeret(diaspora)) {
          pnum = Sidra.VEZOT_HABERACHA.index; //Vezot Haberacha
        } else {
          int sat = ADate.getNext(ADate.SATURDAY, diy + ydiw) -
              ydiw; // get the day in year of next saturday.
          while (pnum == 0 && (sat ~/ 7) < sidra_array.length) {
            pnum = sidra_array[sat ~/ 7];
            //if the next saturday is in succot, it means we are already in Vezot Haberacha.
            if (pnum == 0 && (sat ~/ 7) == 2) //sat>=14 && sat <=20
            {
              pnum = Sidra.VEZOT_HABERACHA.index; //Vezot Haberacha
            }
            sat += 7;
          }
        }
      }
    }
    return Sidra.values[pnum];
  }

/**
 * This method gives you the upcoming parasha. it is useful to know what parasha we should start studying.
 * @param h the hebrew date object
 * @param diaspora are we in the diaspora?
 * @return the string of the parasha.
 */
  /*   static String GetSidra(JewishDate h, bool diaspora, YDateLanguage le)
    {
        int pnum = GetSidraEnum(h, diaspora).ordinal();
        return SidraEnumToString(pnum, le);
    }
    static String SidraEnumToString(int Sidra, YDateLanguage language)
    {
        
        String lstr = "";
        if (Sidra > NUM_SIDRA_54) {
            Sidra = Sidra - NUM_SIDRA_54;

            String fp = language.getToken("format_parasha2");
            fp = fp.replaceAll("_sd1_", language.getToken(sidraToken[Sidra]));
            fp = fp.replaceAll("_sd2_", language.getToken(sidraToken[Sidra + 1]));
            lstr += fp;
        }
        else
        {
            if (Sidra > 0)
            {
                String fp = language.getToken("format_parasha");
                fp = fp.replaceAll("_sd_", language.getToken(sidraToken[Sidra]));
                lstr += fp;
            }
        }
        return lstr;
    }*/
  static final List<List<Int8List>> sidra_reading =
      List.generate(2, (i) => List(HebrewDateToolkit.N_YEAR_TYPES));
  //static final byte[][][] sidra_reading = new byte[2][][];//[diaspora][year_type][shabbat]
  //reverse access:
  static final List<List<Int8List>> sidra_to_shabbat = List.generate(
      2,
      (i) =>
          List.generate(HebrewDateToolkit.N_YEAR_TYPES, (i) => Int8List(54)));
  //static final byte[][][] sidra_to_shabbat = new byte[2][JewishDate.N_YEAR_TYPES][54];//[diaspora][year_type][sidra]

  static int _getNextJoinPointer(int joining, int jp) {
    for (; jp < double_reading.length; ++jp) {
      if ((joining & (1 << jp)) != 0) {
        break;
      }
    }
    return jp;
  }

  static int _getJoin(int jp) {
    if (jp >= double_reading.length) {
      return 55; //return invalid parasha. valid number is only in the range 1..54
    }
    return double_reading[jp];
  }

/**
 * This method calculate all the parashot of a given year.
 * There are 14 possible year types, and for each one of the 14 we have different settings for diaspora.
 * The year can start in *FOUR* out of seven possible day in week (not in sunday, wednesday,friday).
 * The year length might be one of those *SIX* following: 353,354,355,383,384,385.
 * But, some of the combinations are not possible so we actually don't have 24(6*4) combination, but only 14 year types.
 * See ld_year_type for more information.
 * the calculations of this method are cached for each of the 14 year types.
 * @param year_length
 * @param year_first_day
 * @param diaspora
 * @return 
 */
  static Int8List _calculateSidraArray(
      int year_length, int year_first_day, bool diaspora) {
    int year_diw = year_first_day %
        7; // can be only 1(+1=MON) 2(+1=TUE) 4(+1=THU) 6(+1=SAT)

    int ldt = HebrewDateToolkit.yearLengthDayType(
        year_length,
        year_diw +
            1); //the year type out of 14 possible types ( the method gives us range of 1..14)
    if (sidra_reading[diaspora ? 0 : 1][ldt - 1] != null) {
      return sidra_reading[diaspora ? 0 : 1][ldt - 1];
    }
    int joining = SIDRA_JOIN[diaspora ? 0 : 1][ldt - 1];

    int s = 0;

    int diy = ADate.getNext(ADate.SATURDAY, year_diw) - year_diw;
    int shabbats =
        (year_length - (diy) + 6) ~/ 7; //number of shabbats in the given year.
    shabbats++; // one for the next year. Even though Rosh Hashana may be in Saturday, and therefore no Torah Reading, we still put there the upcoming parasha.
    Int8List reading = Int8List(shabbats);
    sidra_reading[diaspora ? 0 : 1][ldt - 1] = reading;
    //the following if is like if (year_diw  == ADate.MONDAY || year_diw  == ADate.TUESDAY)
    if (year_diw <= 2) //if the year started in monday or tuesday - pat bag
    {
      reading[s] = Sidra.VAYELECH.index; //Vayelech
      ++s;
      reading[s] = Sidra.HAAZINU.index; //Ha'azinu
      ++s;
      reading[s] = 0; //none
      ++s;
      diy += 21; //jump to after sukkuth.
    } else {
      if (year_diw == ADate.SATURDAY) {
        reading[s] = 0; //none
        ++s;
        diy += 7;
      }
      reading[s] = Sidra.HAAZINU.index; //Ha'azinu
      ++s;
      reading[s] = 0; //none
      ++s;
      reading[s] = 0; //none
      ++s;
      diy += 21; //jump to after sukkuth.
    }
    int pesah_day = HebrewDateToolkit.dayInYearByMonthId(
        year_length, HebrewMonth.NISAN, 15); // day in year of pessach night.
    int pesah_length = diaspora ? 8 : 7; //how much days in pessach?
    int azeret_day = 50 + pesah_day; //SHAVOUT day in year.
    int azeret_length = diaspora ? 2 : 1;
    int tr = 1;
    //now s points to shabat bereshit
    int jp = 0;
    jp = _getNextJoinPointer(joining, jp);
    int next_join = _getJoin(jp);
    while (s < shabbats) {
      if ((diy >= pesah_day && diy < pesah_day + pesah_length) ||
          (diy >= azeret_day && diy < azeret_day + azeret_length)) {
        reading[s] = 0; //none
        ++s;
        diy += 7;
      } else {
        if (tr == next_join) {
          reading[s] = (tr + NUM_SIDRA_54);
          ++s;
          diy += 7;
          tr += 2;
          jp = _getNextJoinPointer(joining, jp + 1);
          next_join = _getJoin(jp);
        } else {
          reading[s] = tr;
          ++tr;
          ++s;
          diy += 7;
        }
      }
    }
    return reading;
  }

  static Int8List _generateSidraToShabbatArray(
      int year_length, int year_first_day, bool diaspora) {
    int year_diw = year_first_day % 7; // can be only 1 2 4 6 (+1 = 2 3 5 7)
    int ldt = HebrewDateToolkit.yearLengthDayType(year_length, year_diw + 1);
    Int8List reading =
        _calculateSidraArray(year_length, year_first_day, diaspora);
    Int8List rev_access = sidra_to_shabbat[diaspora ? 0 : 1][ldt - 1];
    if (rev_access[0] != 0) return rev_access;
    rev_access[Sidra.VEZOT_HABERACHA.index - 1] = -1; //Vezot Habracha.
    int r = 0;
    for (int i = 0;
        i <
            reading.length -
                1;) //we substract one from length, because last one belongs to next year.
    {
      if (reading[i] > NUM_SIDRA_54) //joined
      {
        rev_access[reading[i] - NUM_SIDRA_54 - 1] = i;
        rev_access[reading[i] - NUM_SIDRA_54 + 1 - 1] = i;
      } else if (reading[i] > 0) {
        rev_access[reading[i] - 1] = i;
      }
    }
    return rev_access;
  }

  /**
     * get the GDN of Shabbat Bereshit of a certain year.
     * @param year_length
     * @param year_first_day
     * @return 
     */
  static int getShabbatBereshit(int year_length, int year_first_day) {
    int bereshit_saturday = year_first_day;
    bereshit_saturday += HebrewDateToolkit.dayInYearByMonthId(
        year_length, HebrewMonth.TISHREI, 23);
    bereshit_saturday = ADate.getNext(ADate.SATURDAY, bereshit_saturday);
    return bereshit_saturday;
  }

  /**
     * return the Vayelech shabbat that is at the end of this year or at the beginning of the next year.
     * @param year_length
     * @param year_first_day
     * @return 
     */
  static int getLastShabbatVayelech(int year_length, int year_first_day) {
    return getFirstShabbatVayelech(year_first_day + year_length);
  }

  static int getFirstShabbatVayelech(int year_first_day) {
    int year_diw = (year_first_day) % 7;
    if ((year_diw >> 2) ==
        0) //if the year starts in monday or tuesday (it cannot be on sunday) - pat bag
    {
      return ADate.getNext(ADate.SATURDAY, year_first_day);
    }
    return ADate.getPrevious(ADate.SATURDAY, year_first_day - 1);
  }

  /**
     * UNTESTED. should give you day in "beginning count" (GDN) for specific Sidra.
     * Vaelech might be twice in year or just once or zero. if there are two Shabbats Vayelech,
     * it gives the one in the end of the year.
     * there are two methods to get the desired Vayelech shabbat.
     * @param sidra 1..54
     * @param year_length
     * @param year_first_day
     * @param diaspora
     * @return -1 if not found. (might happen with "Vayelech")
     */
  static int getParashaDayInYear(
      Sidra sidra, int year_length, int year_first_day, bool diaspora) {
    if (sidra == Sidra.__NONE || sidra.index > Sidra.VEZOT_HABERACHA.index)
      return -1;
    if (sidra ==
        Sidra.VEZOT_HABERACHA) // we read VeZot HaBeracha on Simchat Torah.
    {
      // Simchat torah is in Tishrey 22 in Israel or 23 in Galuyot.
      // but while day in month starts from 1, our "day in year" count starts from 0. so 23,22 become 22,21 respectively.
      return year_first_day + (diaspora ? 22 : 21);
    }
    int sat_num = _generateSidraToShabbatArray(
        year_length, year_first_day, diaspora)[sidra.index - 1];
    if (sat_num < 0) return -1;
    return ADate.getNext(ADate.SATURDAY, year_first_day) + sat_num * 7;
  }

  static final BibleText Haftara_place_holder = new BibleText("");
  static final BibleText megilat_esther = new BibleText("מגילת אסתר").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Esther, 1, 1),
          BibleIndex.create(BibleBook.Esther, 10, 3)));
  static final BibleText megilat_ruth = new BibleText("מגילת רות").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Ruth, 1, 1),
          BibleIndex.create(BibleBook.Ruth, 4, 22)));
  static final BibleText ko_amar_yeshaayah_42_5__43_10 =
      new BibleText("כה אמר האל").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yeshaayah, 42, 5),
          BibleIndex.create(BibleBook.Yeshaayah, 43, 10)));
  static final BibleText ko_amar_yeshaayah_42_5__42_21 =
      new BibleText("כה אמר האל").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yeshaayah, 42, 5),
          BibleIndex.create(BibleBook.Yeshaayah, 42, 21)));
  static final BibleText hen_avdi_yeshaayah_42_1__42_21 =
      new BibleText("הן עבדי").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yeshaayah, 42, 1),
          BibleIndex.create(BibleBook.Yeshaayah, 42, 21)));
  static final BibleText hen_avdi_yeshaayah_42_1__42_16 =
      new BibleText("הן עבדי").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yeshaayah, 42, 1),
          BibleIndex.create(BibleBook.Yeshaayah, 42, 16)));

  static final BibleText roni_akara_yeshaayah_54_1__55_5 =
      new BibleText("רני עקרה").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yeshaayah, 54, 1),
          BibleIndex.create(BibleBook.Yeshaayah, 55, 5)));
  static final BibleText roni_akara_yeshaayah_54_1__54_10 =
      new BibleText("רני עקרה").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yeshaayah, 54, 1),
          BibleIndex.create(BibleBook.Yeshaayah, 54, 10)));
  static final BibleText roni_akara_yeshaayah_54_1__55_3 =
      new BibleText("רני עקרה").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yeshaayah, 54, 1),
          BibleIndex.create(BibleBook.Yeshaayah, 55, 3)));
  static final BibleText lama_tomar_yaakov_yeshaayah_40_27__41_16 =
      new BibleText("למה תאמר יעקב").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yeshaayah, 40, 27),
          BibleIndex.create(BibleBook.Yeshaayah, 41, 16)));
  static final BibleText vel_mi_tedamyuni_yeshaayah_40_25__41_17 =
      new BibleText("ואל מי תדמיוני").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yeshaayah, 40, 25),
          BibleIndex.create(BibleBook.Yeshaayah, 41, 17)));
  static final BibleText veisha_akhat_melachim_ii_4_1__4_37 =
      new BibleText("ואשה אחת").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Melachim_II, 4, 1),
          BibleIndex.create(BibleBook.Melachim_II, 4, 37)));
  static final BibleText veisha_akhat_melachim_ii_4_1__4_23 =
      new BibleText("ואשה אחת").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Melachim_II, 4, 1),
          BibleIndex.create(BibleBook.Melachim_II, 4, 23)));

  static final BibleText vehamelech_david_melachim_i_1_1__1_31 =
      new BibleText("והמלך דוד").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Melachim_I, 1, 1),
          BibleIndex.create(BibleBook.Melachim_I, 1, 31)));
  static final BibleText vehamelech_david_melachim_i_1_1__1_34 =
      new BibleText("והמלך דוד").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Melachim_I, 1, 1),
          BibleIndex.create(BibleBook.Melachim_I, 1, 34)));

  static final BibleText masa_devar_malachi_1_1__2_7 =
      new BibleText("משא דבר ה'").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Malachi, 1, 1),
          BibleIndex.create(BibleBook.Malachi, 2, 7)));
  static final BibleText masa_devar_malachi_1_1__3_4 =
      new BibleText("משא דבר ה'").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Malachi, 1, 1),
          BibleIndex.create(BibleBook.Malachi, 3, 4)));

  static final BibleText veami_teluim_hushea_11_7__12_12 =
      new BibleText("ועמי תלואים").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Hushea, 11, 7),
          BibleIndex.create(BibleBook.Hushea, 12, 12)));
  static final BibleText veami_teluim_hushea_11_7__12_14 =
      new BibleText("ועמי תלואים").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Hushea, 11, 7),
          BibleIndex.create(BibleBook.Hushea, 12, 14)));
  static final BibleText vaivrach_yaakov_hushea_12_13__14_10 =
      new BibleText("ויברח יעקב").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Hushea, 12, 13),
          BibleIndex.create(BibleBook.Hushea, 14, 10)));
  static final BibleText vaivrach_yaakov_hushea_12_13__14_10_yoel =
      new BibleText("ויברח יעקב")
          .append(new BibleParagraph(
              BibleIndex.create(BibleBook.Hushea, 12, 13),
              BibleIndex.create(BibleBook.Hushea, 14, 10)))
          .append(new BibleParagraph(
              BibleIndex.create(BibleBook.Yoel, 2, 26),
              BibleIndex.create(BibleBook.Yoel, 2, 27)));

  static final BibleText khazon_ovadiah_1_1__1_21 = new BibleText("חזון עבדיה")
      .append(new BibleParagraph(
          BibleIndex.create(BibleBook.Ovadiah, 1, 1),
          BibleIndex.create(BibleBook.Ovadiah, 1, 21)));

  static final BibleText ko_amar_amos_2_6__3_8 = new BibleText("כה אמר ה'")
      .append(new BibleParagraph(
          BibleIndex.create(BibleBook.Amos, 2, 6),
          BibleIndex.create(BibleBook.Amos, 3, 8)));

  static final BibleText vaikatz_shlomo_melachim_i_3_15__4_1 =
      new BibleText("ויקץ שלמה").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Melachim_I, 3, 15),
          BibleIndex.create(BibleBook.Melachim_I, 4, 1)));

  static final BibleText vayehi_devar_yechezkel_37_15__37_28 =
      new BibleText("ויהי דבר ה'").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yechezkel, 37, 15),
          BibleIndex.create(BibleBook.Yechezkel, 37, 28)));

  static final BibleText vaykrevo_yemei_melachim_i_2_1__2_12 =
      new BibleText("ויקרבו ימי דוד").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Melachim_I, 2, 1),
          BibleIndex.create(BibleBook.Melachim_I, 2, 12)));
  static final BibleText habaim_yashresh_yeshaayah_27_6__28_13 =
      new BibleText("הבאים ישרש")
          .append(new BibleParagraph(
              BibleIndex.create(BibleBook.Yeshaayah, 27, 6),
              BibleIndex.create(BibleBook.Yeshaayah, 28, 13)))
          .append(new BibleParagraph(
              BibleIndex.create(BibleBook.Yeshaayah, 29, 22),
              BibleIndex.create(BibleBook.Yeshaayah, 29, 23)));
  static final BibleText divrey_yirmiyahu_yirmiyah_1_1__1_19 =
      new BibleText("דברי ירמיהו").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yirmiyah, 1, 1),
          BibleIndex.create(BibleBook.Yirmiyah, 1, 19)));
  static final BibleText divrey_yirmiyahu_yirmiyah_1_1__2_3 =
      new BibleText("דברי ירמיהו").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yirmiyah, 1, 1),
          BibleIndex.create(BibleBook.Yirmiyah, 2, 3)));

  static final BibleText ben_adam_hoda_yechezkel_16_1__16_14 =
      new BibleText("בן אדם הודע").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yechezkel, 16, 1),
          BibleIndex.create(BibleBook.Yechezkel, 16, 14)));
  static final BibleText bekabezi_yechezkel_28_25__29_21 =
      new BibleText("בקבצי").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yechezkel, 28, 25),
          BibleIndex.create(BibleBook.Yechezkel, 29, 21)));
  static final BibleText velo_iyeh_od_yechezkel_28_24__29_21 =
      new BibleText("ולא יהיה עוד").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yechezkel, 28, 24),
          BibleIndex.create(BibleBook.Yechezkel, 29, 21)));
  static final BibleText hadavar_asher_diber_yirmiyah_46_13__46_28 =
      new BibleText("הדבר אשר דבר").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yirmiyah, 46, 13),
          BibleIndex.create(BibleBook.Yirmiyah, 46, 28)));
  static final BibleText iazvu_yachdav_yeshaayah_18_7__19_25 =
      new BibleText("יעזבו יחדו").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yeshaayah, 18, 7),
          BibleIndex.create(BibleBook.Yeshaayah, 19, 25)));
  static final BibleText masa_mizraim_yeshaayah_19_1__19_25 =
      new BibleText("משא מצרים").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yeshaayah, 19, 1),
          BibleIndex.create(BibleBook.Yeshaayah, 19, 25)));
  static final BibleText udevora_isha_nevia_shoftim_4_4__5_31 =
      new BibleText("ודבורה אשה נביאה").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Shoftim, 4, 4),
          BibleIndex.create(BibleBook.Shoftim, 5, 31)));
  static final BibleText udevora_isha_nevia_shoftim_4_4__5_3 =
      new BibleText("ודבורה אשה נביאה").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Shoftim, 4, 4),
          BibleIndex.create(BibleBook.Shoftim, 5, 3)));
  static final BibleText vatashar_devora_shoftim_5_1__5_31 =
      new BibleText("ותשר דבורה").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Shoftim, 5, 1),
          BibleIndex.create(BibleBook.Shoftim, 5, 31)));
  static final BibleText vayachna_shoftim_4_23__5_31 =
      new BibleText("ויכנע אלקים").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Shoftim, 4, 23),
          BibleIndex.create(BibleBook.Shoftim, 5, 31)));
  static final BibleText bishnat_mot_yeshaayah_6_1__7_6___9_5__9_6 =
      new BibleText("בשנת מות המלך")
          .append(new BibleParagraph(
              BibleIndex.create(BibleBook.Yeshaayah, 6, 1),
              BibleIndex.create(BibleBook.Yeshaayah, 7, 6)))
          .append(new BibleParagraph(
              BibleIndex.create(BibleBook.Yeshaayah, 9, 5),
              BibleIndex.create(BibleBook.Yeshaayah, 9, 6)));
  static final BibleText bishnat_mot_yeshaayah_6_1__6_13___9_5__9_6 =
      new BibleText("בשנת מות המלך")
          .append(new BibleParagraph(
              BibleIndex.create(BibleBook.Yeshaayah, 6, 1),
              BibleIndex.create(BibleBook.Yeshaayah, 6, 13)))
          .append(new BibleParagraph(
              BibleIndex.create(BibleBook.Yeshaayah, 9, 5),
              BibleIndex.create(BibleBook.Yeshaayah, 9, 6)));
  static final BibleText bishnat_mot_yeshaayah_6_1__6_13 =
      new BibleText("בשנת מות המלך").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yeshaayah, 6, 1),
          BibleIndex.create(BibleBook.Yeshaayah, 6, 13)));
  static final BibleText ki_yom_nakam_yirmiyah_34_8__34_22___33_25__33_26 =
      new BibleText("כי יום נקם")
          .append(new BibleParagraph(
              BibleIndex.create(BibleBook.Yirmiyah, 34, 8),
              BibleIndex.create(BibleBook.Yirmiyah, 34, 22)))
          .append(new BibleParagraph(
              BibleIndex.create(BibleBook.Yirmiyah, 33, 25),
              BibleIndex.create(BibleBook.Yirmiyah, 33, 26)));
  static final BibleText ki_yom_nakam_yirmiyah_34_8__35_11 =
      new BibleText("כי יום נקם").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yirmiyah, 34, 8),
          BibleIndex.create(BibleBook.Yirmiyah, 35, 11)));
  static final BibleText ki_yom_nakam_yirmiyah_34_8__35_19 =
      new BibleText("כי יום נקם").append(new BibleParagraph(
          BibleIndex.create(BibleBook.Yirmiyah, 34, 8),
          BibleIndex.create(BibleBook.Yirmiyah, 35, 19)));
  static final List<List<BibleText>> haftarot = [
    [
      //Bereshit
      ko_amar_yeshaayah_42_5__42_21, //sefardim
      ko_amar_yeshaayah_42_5__43_10, //ashkenaz
      hen_avdi_yeshaayah_42_1__42_21, //italian
      hen_avdi_yeshaayah_42_1__42_16, //teimani
      ko_amar_yeshaayah_42_5__42_21, //chabad
      ko_amar_yeshaayah_42_5__42_21, //frankfurt
    ],
    [
      //Noah
      roni_akara_yeshaayah_54_1__54_10, //sefardim
      roni_akara_yeshaayah_54_1__55_5, //ashkenaz
      roni_akara_yeshaayah_54_1__55_5, //italian
      roni_akara_yeshaayah_54_1__55_3, //teimani
      roni_akara_yeshaayah_54_1__54_10, //chabad
      roni_akara_yeshaayah_54_1__55_5, //frankfurt
    ],
    [
      //Lech Lecha
      lama_tomar_yaakov_yeshaayah_40_27__41_16, //sefardim
      lama_tomar_yaakov_yeshaayah_40_27__41_16, //ashkenaz
      vel_mi_tedamyuni_yeshaayah_40_25__41_17, //italian
      vel_mi_tedamyuni_yeshaayah_40_25__41_17, //teimani
      lama_tomar_yaakov_yeshaayah_40_27__41_16, //chabad
      lama_tomar_yaakov_yeshaayah_40_27__41_16, //frankfurt
    ],
    [
      //Vayera
      veisha_akhat_melachim_ii_4_1__4_23, //sefardim
      veisha_akhat_melachim_ii_4_1__4_37, //ashkenaz
      veisha_akhat_melachim_ii_4_1__4_37, //italian
      veisha_akhat_melachim_ii_4_1__4_37, //teimani
      veisha_akhat_melachim_ii_4_1__4_37, //chabad
      veisha_akhat_melachim_ii_4_1__4_23, //frankfurt
    ],
    [
      //Chayei_Sarah
      vehamelech_david_melachim_i_1_1__1_31, //sefardim
      vehamelech_david_melachim_i_1_1__1_31, //ashkenaz
      vehamelech_david_melachim_i_1_1__1_34, //italian
      vehamelech_david_melachim_i_1_1__1_31, //teimani
      vehamelech_david_melachim_i_1_1__1_31, //chabad
      vehamelech_david_melachim_i_1_1__1_31, //frankfurt
    ],
    [
      //Toldot
      masa_devar_malachi_1_1__2_7, //sefardim
      masa_devar_malachi_1_1__2_7, //ashkenaz
      masa_devar_malachi_1_1__2_7, //italian
      masa_devar_malachi_1_1__3_4, //teimani
      masa_devar_malachi_1_1__2_7, //chabad
      masa_devar_malachi_1_1__2_7, //frankfurt
    ],
    [
      //Vayetze
      veami_teluim_hushea_11_7__12_12, //sefardim
      vaivrach_yaakov_hushea_12_13__14_10_yoel, //ashkenaz
      veami_teluim_hushea_11_7__12_14, //italian
      veami_teluim_hushea_11_7__12_14, //teimani
      vaivrach_yaakov_hushea_12_13__14_10_yoel, //chabad
      vaivrach_yaakov_hushea_12_13__14_10 //frankfurt
    ],
    [
      //Vayishlach
      khazon_ovadiah_1_1__1_21, //sefardim
      khazon_ovadiah_1_1__1_21, //ashkenaz
      khazon_ovadiah_1_1__1_21, //italian
      khazon_ovadiah_1_1__1_21, //teimani
      khazon_ovadiah_1_1__1_21, //chabad
      khazon_ovadiah_1_1__1_21, //frankfurt
    ],
    [
      //Vayeshev
      ko_amar_amos_2_6__3_8, //sefardim
      ko_amar_amos_2_6__3_8, //ashkenaz
      ko_amar_amos_2_6__3_8, //italian
      ko_amar_amos_2_6__3_8, //teimani
      ko_amar_amos_2_6__3_8, //chabad
      ko_amar_amos_2_6__3_8, //frankfurt
    ],
    [
      //Miketz
      vaikatz_shlomo_melachim_i_3_15__4_1, //sefardim
      vaikatz_shlomo_melachim_i_3_15__4_1, //ashkenaz
      vaikatz_shlomo_melachim_i_3_15__4_1, //italian
      vaikatz_shlomo_melachim_i_3_15__4_1, //teimani
      vaikatz_shlomo_melachim_i_3_15__4_1, //chabad
      vaikatz_shlomo_melachim_i_3_15__4_1, //frankfurt
    ],
    [
      //Vayigash
      vayehi_devar_yechezkel_37_15__37_28, //sefardim
      vayehi_devar_yechezkel_37_15__37_28, //ashkenaz
      vayehi_devar_yechezkel_37_15__37_28, //italian
      vayehi_devar_yechezkel_37_15__37_28, //teimani
      vayehi_devar_yechezkel_37_15__37_28, //chabad
      vayehi_devar_yechezkel_37_15__37_28, //frankfurt
    ],
    [
      //Vayechi
      vaykrevo_yemei_melachim_i_2_1__2_12, //sefardim
      vaykrevo_yemei_melachim_i_2_1__2_12, //ashkenaz
      vaykrevo_yemei_melachim_i_2_1__2_12, //italian
      vaykrevo_yemei_melachim_i_2_1__2_12, //teimani
      vaykrevo_yemei_melachim_i_2_1__2_12, //chabad
      vaykrevo_yemei_melachim_i_2_1__2_12, //frankfurt
    ],
    [
      //Shemot
      divrey_yirmiyahu_yirmiyah_1_1__2_3, //sefardim
      habaim_yashresh_yeshaayah_27_6__28_13, //ashkenaz
      divrey_yirmiyahu_yirmiyah_1_1__1_19, //italian
      ben_adam_hoda_yechezkel_16_1__16_14, //teimani
      habaim_yashresh_yeshaayah_27_6__28_13, //chabad
      habaim_yashresh_yeshaayah_27_6__28_13, //frankfurt
    ],
    [
      //Vaera
      bekabezi_yechezkel_28_25__29_21, //sefardim
      bekabezi_yechezkel_28_25__29_21, //ashkenaz
      bekabezi_yechezkel_28_25__29_21, //italian
      velo_iyeh_od_yechezkel_28_24__29_21, //teimani
      bekabezi_yechezkel_28_25__29_21, //chabad
      bekabezi_yechezkel_28_25__29_21, //frankfurt
    ],
    [
      //Bo
      hadavar_asher_diber_yirmiyah_46_13__46_28, //sefardim
      hadavar_asher_diber_yirmiyah_46_13__46_28, //ashkenaz
      iazvu_yachdav_yeshaayah_18_7__19_25, //italian
      masa_mizraim_yeshaayah_19_1__19_25, //teimani
      hadavar_asher_diber_yirmiyah_46_13__46_28, //chabad
      hadavar_asher_diber_yirmiyah_46_13__46_28 //frankfurt
    ],
    [
      //Beshalach
      vatashar_devora_shoftim_5_1__5_31, //sefardim
      udevora_isha_nevia_shoftim_4_4__5_31, //ashkenaz
      udevora_isha_nevia_shoftim_4_4__5_3, //italian
      vayachna_shoftim_4_23__5_31, //teimani
      udevora_isha_nevia_shoftim_4_4__5_31, //chabad
      udevora_isha_nevia_shoftim_4_4__5_31 //frankfurt
    ],
    [
      //Yitro
      bishnat_mot_yeshaayah_6_1__6_13, //sefardim
      bishnat_mot_yeshaayah_6_1__7_6___9_5__9_6, //ashkenaz
      bishnat_mot_yeshaayah_6_1__7_6___9_5__9_6, //italian
      bishnat_mot_yeshaayah_6_1__6_13___9_5__9_6, //teimani
      bishnat_mot_yeshaayah_6_1__6_13, //chabad
      bishnat_mot_yeshaayah_6_1__7_6___9_5__9_6 //frankfurt
    ],
    [
      //Mishpatim
      ki_yom_nakam_yirmiyah_34_8__34_22___33_25__33_26, //sefardim
      ki_yom_nakam_yirmiyah_34_8__34_22___33_25__33_26, //ashkenaz
      ki_yom_nakam_yirmiyah_34_8__35_11, //italian
      ki_yom_nakam_yirmiyah_34_8__35_19, //teimani
      ki_yom_nakam_yirmiyah_34_8__34_22___33_25__33_26, //chabad
      ki_yom_nakam_yirmiyah_34_8__34_22___33_25__33_26 //frankfurt
    ],
  ];

  List<List<BibleText>> haftarot2 = [
    [
      //Terumah
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Tetzaveh
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Ki_Tisa
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Vayakhel
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Pekudei
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Vayikra
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Tzav
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Shemini
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Tazria
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Metzora
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Achrei_Mot
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Kedoshim
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Emor
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Behar
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Bechukotai
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Bamidbar
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Naso
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Behaalotcha
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Shelach_Lecha
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Korach
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Chukat
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Balak
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Pinchas
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Matot
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Masei
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Devarim
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Vaetchanan
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Ekev
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Reeh
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Shoftim
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Ki_Tetze
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Ki_Tavo
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Nitzavim
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Vayelech
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Haazinu
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ],
    [
      //Vezot_Haberacha
      //sefardim
      //ashkenaz
      //italian
      //teimani
      //chabad
      //frankfurt
    ]
  ];

  static final List<BibleText> gimel_depuranuta_sheva_denechamata = [
    //gimel depuranuta
    new BibleText("דברי ירמיהו").append(new BibleParagraph(
        BibleIndex.create(BibleBook.Yirmiyah, 1, 1),
        BibleIndex.create(BibleBook.Yirmiyah, 2, 3))),
    new BibleText("שמעו דבר ה").append(new BibleParagraph(
        BibleIndex.create(BibleBook.Yirmiyah, 2, 4),
        BibleIndex.create(BibleBook.Yirmiyah, 2, 28))),
    new BibleText("חזון ישעיהו").append(new BibleParagraph(
        BibleIndex.create(BibleBook.Yeshaayah, 1, 1),
        BibleIndex.create(BibleBook.Yeshaayah, 1, 27))),
    //sheva denechamata
    new BibleText("נחמו").append(new BibleParagraph(
        BibleIndex.create(BibleBook.Yeshaayah, 40, 1),
        BibleIndex.create(BibleBook.Yeshaayah, 40, 26))),
    new BibleText("ותאמר ציון").append(new BibleParagraph(
        BibleIndex.create(BibleBook.Yeshaayah, 49, 14),
        BibleIndex.create(BibleBook.Yeshaayah, 51, 3))),
    new BibleText("עניה סוערה").append(new BibleParagraph(
        BibleIndex.create(BibleBook.Yeshaayah, 54, 11),
        BibleIndex.create(BibleBook.Yeshaayah, 55, 5))),
    new BibleText("אנכי").append(new BibleParagraph(
        BibleIndex.create(BibleBook.Yeshaayah, 51, 12),
        BibleIndex.create(BibleBook.Yeshaayah, 52, 12))),
    new BibleText("רני עקרה").append(new BibleParagraph(
        BibleIndex.create(BibleBook.Yeshaayah, 54, 1),
        BibleIndex.create(BibleBook.Yeshaayah, 54, 10))),
    new BibleText("קומי אורי").append(new BibleParagraph(
        BibleIndex.create(BibleBook.Yeshaayah, 60, 1),
        BibleIndex.create(BibleBook.Yeshaayah, 60, 22))),
    new BibleText("שוש אשיש").append(new BibleParagraph(
        BibleIndex.create(BibleBook.Yeshaayah, 61, 10),
        BibleIndex.create(BibleBook.Yeshaayah, 63, 9))),
  ];
  static final List<BibleText> gimel_depuranuta_chabad = [
    gimel_depuranuta_sheva_denechamata[0],
    new BibleText.from(gimel_depuranuta_sheva_denechamata[1]),
    gimel_depuranuta_sheva_denechamata[2]
  ];

  BibleText getHaftaraShabbat(
      HebrewDate h, bool diaspora, HaftaraMinhag minhag) {
    if (h.dayOfChanukkah != ChanukkahDay.NONE &&
        h.dayOfWeek == DayOfWeek.Saturday) //channukkah && shabbat
    {
      if (h.isRoshChodesh) // rosh chodesh also...
      {}
    }
    throw new UnsupportedError("Not supported yet.");
  }

  BibleText getHaftaraShaharit(
      HebrewDate h, bool diaspora, HaftaraMinhag minhag) {
    throw new UnsupportedError("Not supported yet.");
  }

  BibleText getHaftaraMincha(HebrewDate h, HaftaraMinhag minhag) {
    throw new UnsupportedError("Not supported yet.");
  }
}
