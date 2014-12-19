# -*- coding: utf-8 -*-

require 'json'
require 'mechanize'
require 'turbotlib'

urls = {
  'Bank' => 'https://www.cba.am/en/SitePages/fscfobanks.aspx',
  'Credit Organization' => 'https://www.cba.am/en/SitePages/fscfocreditorganizations.aspx',
  'Insurance Organization' => 'https://www.cba.am/en/SitePages/fscfoinsuranceorganizations.aspx',
  'Insurance Broker' => 'https://www.cba.am/en/SitePages/fscfoinsurancebrokers.aspx',
  'Lombard' => 'https://www.cba.am/en/SitePages/fscfolombards.aspx',
}

urls.each do |category, url|
  agent = Mechanize.new
  page = agent.get(url)
  page.search('.banks_list_cont .banks_list_desc').each do |bank|
    data = {
      company_name: bank.search('a.bank_name').text.strip,
      organization_head: bank.to_s.match(/<b>Organization Head:<\/b>([^<]*)/m) ? $1.strip : nil,
      address: bank.to_s.match(/<b>Address:<\/b>([^<]*)/) ? $1.strip : nil,
      branch: bank.to_s.match(/<b>Branch:<\/b>([^<]*)/) ? $1.strip : nil,
      contact: bank.to_s.match(/<b>Contact:<\/b>([^<]*)/) ? $1.strip : nil,
      category: category,
      source_url: url,
      sample_date: Time.now
    }

    puts JSON.dump(data)
  end
end
