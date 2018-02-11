#!/usr/bin/env ruby

require 'net/http'
require 'uri'

require 'json'

def check_github_version( owner, repo, current_version )

  uri = URI.parse("https://api.github.com/repos/#{owner}/#{repo}/tags")
  response = Net::HTTP.get_response(uri)

  body = JSON.parse(response.body)

  highest = body.map{ |elem|
    version = elem["name"]
    result = /([[[:digit:]]+\.+]+)/.match(version)[0]
    result
  }.sort.reverse.first.to_s


  if (current_version == highest)
    same = " "
  else
    same = "!"
  end

  puts "[%s] %-40s %-10s %-10s" % [ "#{same}", "#{owner}/#{repo}", "#{highest}", "#{current_version}" ]

end


check_github_version "VCVRack",          "Rack",                   "0.5.1"
check_github_version "VCVRack",          "Fundamental",            "0.5.1"
check_github_version "VCVRack",          "Befaco",                 "0.5.0"
check_github_version "VCVRack",          "Eseries",                "0.5.0"
check_github_version "VCVRack",          "AudibleInstruments",     "0.5.0"
check_github_version "dekstop",          "vcvrackplugins_dekstop", "0.5.0"
check_github_version "jhoar",            "AmalgamatedHarmonics",   "0.5.7"
check_github_version "AScustomWorks",    "AS",                     "0.5.1"
check_github_version "bogaudio",         "BogaudioModules",        "0.5.1"
check_github_version "mhetrick",         "hetrickcv",              "0.5.4"
check_github_version "naus3a",           "NauModular",             "0.5.2"
check_github_version "Miserlou",         "RJModules",              "0.5.0"
check_github_version "stellare-modular", "vcv-link",               "0.5.1"
