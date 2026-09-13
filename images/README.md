# תמונות

כל יעד טוען `images/<id>.jpg`, ואם הקובץ לא קיים נטען `images/<id>.svg` כ-placeholder.
**כדי להחליף placeholder בתמונה אמיתית — פשוט שמרו כאן קובץ `.jpg` בשם הנכון. אין צורך לגעת בקוד.**

## הדרך המהירה

```sh
sh images/fetch-photos.sh
```

מוריד את ארבע התמונות החסרות מ-Wikimedia Commons (רישיון חופשי), מקטין ל-1200px,
ויוצר `images/CREDITS.md` עם הקרדיטים. אחר כך: `git add images && git commit && git push`

## חסרות תמונות

| קובץ | מקום |
|---|---|
| `frangokastello.jpg`   | מבצר וחוף פרנגוקסטלו |
| `argyroupoli.jpg`      | מעיינות ארגירופולי |
| `knossos.jpg`          | ארמון קנוסוס |
| `heraklion-museum.jpg` | המוזיאון הארכיאולוגי בהרקליון |

כדאי להחליף גם את `rethymno.jpg` — הקרופ הנוכחי מראה מנופים וקיר, והוא בולט
עכשיו כי המודאל מציג את התמונה בגדול.

## אם רוצים תמונה אחרת

הסקריפט מושך לפי שם קובץ ב-Commons. אפשר לפתוח את הקטגוריה, לבחור תמונה
ולהחליף את השם ברשימה שבתוך `fetch-photos.sh`:

- [Knossos](https://commons.wikimedia.org/wiki/Category:Knossos)
- [Frangokastello](https://commons.wikimedia.org/wiki/Category:Frangokastello_(castle))
- [Argyroupoli](https://commons.wikimedia.org/wiki/Category:Argyroupoli_(Crete))
- [Archaeological Museum of Heraklion](https://commons.wikimedia.org/wiki/Category:Archaeological_Museum_of_Heraklion)

## למה לא לשמור תמונות מחיפוש בגוגל

גוגל תמונות הוא אינדקס, לא מקור — התמונות שם שייכות לצלמים ולסוכנויות סטוק.
האתר הזה ציבורי, וסוכנויות שולחות מכתבי דרישה על שימוש כזה. ב-Commons יש את
אותם מקומות ברישיון חופשי, אז אין סיבה להסתכן.

מפרט מומלץ: רוחב ~1200px, JPEG באיכות ~80, עד ~250KB לקובץ.
