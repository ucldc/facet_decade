#!/usr/bin/env groovy

if (!args) {
  println 'usage: facet_decade.groovy: "date string" ["date string" ...]'
  System.exit(0)
}

// modify CLASSPATH to include the current directory
def loader = this.class.classLoader.rootLoader
URL url = new File(System.getProperty("user.dir")).toURI().toURL();
loader.addURL(url)

// the java class we are wrapping
import org.cdlib.dsc.util.FacetDecade

FacetDecade dec = new FacetDecade()

args.each{ string ->
  // get back XML
  def xml = dec.facetDecade(string)
  // parse it
  def decades_xml = new XmlParser().parseText( xml )
  // collect all the decades out of it
  def decades_array = decades_xml.decade.collect{ it.value()[0] }
  // convert it to JSON
  def json = new groovy.json.JsonBuilder( decades_array )
  // print the results
  println json
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
