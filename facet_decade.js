#!/usr/bin/env node
'use strict';

var facetDecade = function(string) {
  /*  process string and return array of decades  */
  var year = new Date().getFullYear();
  var re = /(\d+)/g;
  var matches = string.match(re);
  if (matches) {
    matches = matches.filter(function(n) {
      return n >= 1000 && n <= year;
    });
  }
  if (!matches || matches.length === 0) { return ['unknown'] };
  var max = Math.max.apply(null, matches);
  var min = Math.min.apply(null, matches);
  min = Math.floor(min / 10) * 10;
  var decades = [];
  for (var x = min; x <= max; x = x + 10) {
    decades.push(x + 's');
  }
  return decades;
}

if (require.main === module) {
  if (process.argv.length <= 2) {
    console.log('usage: facet_decade.js: "date string" ["date string" ...]');
  }
  for (var i = 2; i < process.argv.length; i++){
    process.stdout.write(JSON.stringify(facetDecade(process.argv[i]))+'\n');
  }
}

module.exports = facetDecade;

/*
Copyright © 2016, Regents of the University of California
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
