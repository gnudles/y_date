import 'package:test/test.dart';

import 'package:y_date/y_date.dart';

void main() {
  test('zodiac to element', () {
    /// Zodiac signs related to Fire: Aries, Leo, Sagittarius.

    /// Zodiac signs related to Earth: Taurus, Virgo, Capricorn.

    /// Zodiac signs related to Wind: Gemini, Libra, Aquarius.

    /// Zodiac signs related to Water: Cancer, Scorpio, Pisces.
    expect(elementOfZodiacSign(ZodiacSign.Aries), Element.Fire);
    expect(elementOfZodiacSign(ZodiacSign.Leo), Element.Fire);
    expect(elementOfZodiacSign(ZodiacSign.Sagittarius), Element.Fire);
    expect(elementOfZodiacSign(ZodiacSign.Taurus), Element.Earth);
    expect(elementOfZodiacSign(ZodiacSign.Virgo), Element.Earth);
    expect(elementOfZodiacSign(ZodiacSign.Capricorn), Element.Earth);
    expect(elementOfZodiacSign(ZodiacSign.Gemini), Element.Wind);
    expect(elementOfZodiacSign(ZodiacSign.Libra), Element.Wind);
    expect(elementOfZodiacSign(ZodiacSign.Aquarius), Element.Wind);
    expect(elementOfZodiacSign(ZodiacSign.Cancer), Element.Water);
    expect(elementOfZodiacSign(ZodiacSign.Scorpio), Element.Water);
    expect(elementOfZodiacSign(ZodiacSign.Pisces), Element.Water);
  });
  test('datetest', () {
    GregorianDate g = GregorianDate.fromYearMonthDay(2021, 1, 11);
    HebrewDate h = HebrewDate.fromGDN(g.gdn);
    expect(g.dayInMonth, 11);
    expect(h.dayInMonth, 27);
    expect(h.monthID, HebrewMonth.TEVET);
    expect(h.year, 5781);
    expect(TorahReading.GetSidraEnum(h, false), Sidra.VAERA);
    expect(TorahReading.GetSidraEnum(h, true), Sidra.VAERA);
    h.seekBy(-7);
    expect(TorahReading.GetSidraEnum(h, false), Sidra.SHEMOT);
    expect(TorahReading.GetSidraEnum(h, true), Sidra.SHEMOT);
    h.seekBy(-20);
    expect(h.monthID, HebrewMonth.KISLEV);
    expect(h.dayOfChanukkah, ChanukkahDay.DAY_V);
  });
}
