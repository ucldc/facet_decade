#!/usr/bin/env ruby

require 'json'

def facet_decade(string='')
  # process string and return array of decades 
  year = Time.new.year
  matches = string.scan(/(?<!\d)(\d{4})(?!\d)/)
  matches = matches.map { |x| x.at(0).to_i }
  matches = matches.select { |x| x >= 1000 }
  matches = matches.select { |x| x <= year }
  if matches.empty?
    return []
  end
  start = matches.min.to_i / 10 * 10
  endt = matches.max.to_i
  return (start..endt).step(10).to_a.map { |x| x.to_s + 's' }
end

if __FILE__ == $PROGRAM_NAME #equivalent: if __FILE__ == $0
  if ARGV.empty?
    puts 'usage: facet_decade.rb: "date string" ["date string" ...]'
    exit
  end

  ARGV.each do|a|
    puts facet_decade(a).to_json
  end
end


=begin
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

=end
