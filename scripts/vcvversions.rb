#!/usr/bin/env ruby

require 'net/http'
require 'uri'

require 'json'

def check_github_version( owner, repo, current_version )

  uri = URI.parse("https://api.github.com/repos/#{owner}/#{repo}/tags")
  response = Net::HTTP.get_response(uri)

  body = JSON.parse(response.body)

  highest = body.map{ |elem|
    elem["name"]
  }.sort.reverse.first.to_s


  if (current_version == highest)
    same = " "
  else
    same = "!"
  end

  puts "[%s] %-40s %-10s %-10s" % [ "#{same}", "#{owner}/#{repo}", "#{highest}", "#{current_version}" ]

end


check_github_version "VCVRack",          "Rack",                   "v0.5.1"
check_github_version "VCVRack",          "Fundamental",            "v0.5.1"
check_github_version "VCVRack",          "Befaco",                 "v0.5.0"
check_github_version "VCVRack",          "Eseries",                "v0.5.0"
check_github_version "VCVRack",          "AudibleInstruments",     "v0.5.0"
check_github_version "dekstop",          "vcvrackplugins_dekstop", "v0.5.0"
check_github_version "jhoar",            "AmalgamatedHarmonics",   "v0.5.7"
check_github_version "AScustomWorks",    "AS",                     "0.5.1"
check_github_version "bogaudio",         "BogaudioModules",        "v0.5.1"
check_github_version "mhetrick",         "hetrickcv",              "0.5.4"
check_github_version "naus3a",           "NauModular",             "0.5.2"
check_github_version "Miserlou",         "RJModules",              "0.5.0"
check_github_version "stellare-modular", "vcv-link",               "0.5.1"
check_github_version "The-XOR",          "VCV-Sequencers",         "0.5.2"
