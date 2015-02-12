/* ------------------------------------
 *
 * Project:	OAC 4.0
 *
 * Task:	To provide a static method that can take a string, interpret
 *		the values within it as dates, and generate a list of decades
 *		that span those dates.
 *
 * Name:	FacetDecade
 *
 * Command line parameters:  (when invoked from the command line, so that
 *		the "static void main" method is invoked)
 *		any number of parameters, each is passed to the static
 *		facet decade method one at a time.
 *		
 * Author:	Michael A. Russell
 *
 * ------------------------------------
 */

package org.cdlib.dsc.util;

import java.util.Calendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class FacetDecade {

    public static void main(String[ ] arg) {
	int i;
	String results;

	for (i = 0; i < arg.length; i++) {
	    results = facetDecade(arg[i]);
	    System.out.println("input = \"" + arg[i] + "\", output = \"" +
		results + "\"");
	    }
	}

    /* The static method which is the heart.  */
    public static String facetDecade(String input) {
	/* At this point, all we're seeking is a sequence of exactly 4
	 * decimal digits.  Find all of them in the string, and keep
	 * track of the minimum and maximum values.
	 *
	 * The string we seek must not have a digit preceding it, and must
	 * not have a digit following it.  (The lookbehind and lookahead
	 * assertions, while within parentheses, are not "capturing".)
	 */
	Pattern p = Pattern.compile("(?<!\\d)(\\d{4})(?!\\d)");
	Matcher m = p.matcher(input);

	/* Get the current date and time.  */
	Calendar now = Calendar.getInstance( );

	/* Set a reasonable minimum and maximum, given that our strings
	 * are exactly 4 decimal digits.
	 */
	int min, max;
	min = 10000;
	max = -1;

	/* Process the matches.  */
	while (m.find( )) {
	    /* Retrieve the string matched by the pattern within the
	     * second set of parens.  (It is first group, group 1,
	     * because the lookbehind and lookahead assertions, while
	     * within parentheses, are not "capturing".)
	     */
	    String syear = m.group(1);

	    int iyear = Integer.parseInt(syear);

	    /* If it's "0000", ignore it.  */
	    /* if (iyear == 0) continue; */

	    /* If the year is less than 1000, ignore it.  */
	    if (iyear < 1000) continue;

	    /* If the year is greater than the current year, 
             * ignore it.
	     */
	    if (iyear > now.get(Calendar.YEAR)) continue;

	    if (iyear < min) min = iyear;
	    if (iyear > max) max = iyear;
	    }

	/* If we didn't find any years, don't return anything.  */
	if (max < 0) return("<decades></decades>");

	/* Set the minimum to a decade boundary.  */
	min = (min / 10) * 10;

	/* Start off the output string we'll want.  */
	String facets = "<decades>";

	/* Build the set of decades.  */
	for (; min <= max; min += 10)
		facets += "<decade>" + min + "s</decade>";
	
	/* Put on the closing.  */
	facets += "</decades>";

	return(facets);
	}
    }

/*
Copyright © 2015, Regents of the University of California
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions
are met:

 * Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

 * Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in
   the documentation and/or other materials provided with the
   distribution.

 * Neither the name of the University of California nor the names
   of its contributors may be used to endorse or promote products
   derived from this software without specific prior written
   permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
*/
