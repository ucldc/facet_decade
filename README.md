# FacetDecade

Super simple decade facet from date strings.

## build

```
javac org/cdlib/dsc/util/FacetDecade.java
```

## run
(needs `groovy` command on path)

```
./facet_decade.groovy
usage: facet_decade.groovy: "date string" ["date string" ...]

./facet_decade.groovy "1920 1950"
["1920s","1930s","1940s","1950s"]
```

## use with XTF / from saxon

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
