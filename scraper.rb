# -*- coding: utf-8 -*-

require 'json'
require 'mechanize'
require 'turbotlib'

SOURCE_URL = 'https://www.cba.am/en/SitePages/fscfobanks.aspx'

agent = Mechanize.new
page = agent.get(SOURCE_URL)

page.search('.banks_list_cont .banks_list_desc').each do |bank|
  parts = bank.to_html.split('<br>')

  data = {
    company_name: bank.search('a').first.text.strip,
    organization_head: parts[0].split('</b>').last,
    address: parts[1].split('</b>').last,
    branch: parts[2].split('</b>').last,
    source_url: SOURCE_URL,
    sample_date: Time.now
  }

  puts JSON.dump(data)
end
