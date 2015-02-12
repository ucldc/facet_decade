#!/usr/bin/env python
# -*- coding: utf-8 -*-
""" facet decade in python """

import sys
import argparse
import re
from datetime import date
import itertools
import json


def main(argv=None):
    parser = argparse.ArgumentParser()
    parser.add_argument('string', nargs="+")

    if argv is None:
        argv = parser.parse_args()

    for string in argv.string:
        print json.dumps((facet_decade(string)))


def facet_decade(string):
    """ process string and return array of decades """
    # get all the 4 digit strings
    # negative lookahead and negative lookbehind are non-grouping
    pattern = re.compile(r'(?<!\d)(\d{4})(?!\d)')
    matches = [int(match) for match in re.findall(pattern, string)]
    # filter out > 1000
    matches = filter(lambda a: a > 1000, matches)
    # filter out the future
    matches = filter(lambda a: a < date.today().year, matches)
    # x / 10 * 10 rounds down to the decade
    start = (min(matches) / 10) * 10
    end = max(matches)
    return map('{0}s'.format, range(start, end, 10))
    

# main() idiom for importing into REPL for debugging
if __name__ == "__main__":
    sys.exit(main())


"""
Copyright © 2015, Regents of the University of California
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
- Redistributions of source code must retain the above copyright notice,
  this list of conditions and the following disclaimer.
- Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.
- Neither the name of the University of California nor the names of its
  contributors may be used to endorse or promote products derived from this
  software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.
"""
