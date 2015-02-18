# FacetDecade

Super simple decade facet from date strings.

Take a string, interpret the values within it as dates, and generate a list of decades that span those dates.

 1. regex on `(?<!\d)(\d{4})(?!\d)` or `(\d+)`, collect into array
 2. parse into integers if possible
 3. ignore things `<=1000` and `>=` **current year**
 4. find the min and max of what is left
 5. round down to the decade boundry `(integer * 10 / 10)` or `Math.floor`
 6. count off the decades from min to max
 7. add an `s` to the end of ever integer and convert to string
 8. return an array of decades

## Available in multiple languages

See [tests.sh](https://github.com/ucldc/facet_decade/blob/master/test.sh)

The files run as scripts or as modules (except for groovy, which
is just a wrapper to the java class.)

To run the groovy version, `javac org/cdlib/dsc/util/FacetDecade.java`
first.

Running as a script, each command line argument is run against the
function `facet_decade` and the results are returned one JSON record
per line.

Running as a module, `facet_decade` takes a single string as a
paramater; and then return an array of facet values (or an array
reference, in the case of perl).
The java class returns a string of XML `<decades><decade>...</decade>...</decades>`,
used as a saxon 8 extension function.

Perl requires [JSON.pm](http://search.cpan.org/perldoc?JSON),
when run as a script, otherwise only standard libraries are used.

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
