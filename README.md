# FacetDecade

Super simple decade facet from date strings.

Take a string, interpret the values within it as dates, and generate a list of decades that span those dates.

 1. regex on `(\d+)` or `(?<!\d)(\d{4})(?!\d)` into array or loop
 2. parse into integers if possible
 3. ignore things `<=1000` and `>=` **current year**
 4. find the min and max of what is left
 5. flatten the min the the lowest decade `(integer * 10 / 10)` or `Math.floor`
 6. count off the decades from min to max
 7. add an `s` to the end of ever integer and convert to string
 8. return an array of decades

## Available in multiple languages

Scripts return json

To run the groovy version, `javac org/cdlib/dsc/util/FacetDecade.java` fisrt.

```
./facet_decade.groovy 
usage: facet_decade.groovy: "date string" ["date string" ...]

./facet_decade.js 
usage: facet_decade.js: "date string" ["date string" ...]

./facet_decade.py 
usage: facet_decade.py [-h] string [string ...]
facet_decade.py: error: too few arguments

./facet_decade.rb 
usage: facet_decade.rb: "date string" ["date string" ...]
```

## use with XTF / from saxon

Put `org/cdlib/dsc/util/FacetDecade.java` into XTF's `WEB-INF/src` and run `ant`.

Then, in the XSLT...

```xslt
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="2.0"
  xmlns:decade="java:org.cdlib.dsc.util.FacetDecade"
>
  <xsl:apply-templates
    select="saxon:parse(decade:facetDecade($date))/decades/decade"
    mode="decade"
  /> 

  <xsl:template match="decade" mode="decade">
    <facet-decade xtf:meta="true" xtf:tokenize="no">
      <xsl:value-of select="."/>
    </facet-decade>
  </xsl:template>

```
