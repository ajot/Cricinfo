require 'nokogiri'
require 'open-uri'

teams = {
  :ind => {:url => "http://www.espncricinfo.com/ci/content/squad/471232.html", :team_name => "India 1992 World Cup Squad"},
  :pak => {:url => "http://www.espncricinfo.com/ci/content/squad/471234.html",:team_name => "Pakistan 1992 World Cup Squad"},
  :csk => {:url => "http://www.espncricinfo.com/indian-premier-league-2014/content/squad/735917.html",:team_name => "Chennai Super Kings"},
  :dd =>  {:url => "http://www.espncricinfo.com/indian-premier-league-2014/content/squad/735923.html",:team_name => "Delhi Daredevils"},
  :kxip =>  {:url => "http://www.espncricinfo.com/indian-premier-league-2014/content/squad/735927.html",:team_name => "Kings XI Punjab"},
  :kr =>  {:url => "http://www.espncricinfo.com/indian-premier-league-2014/content/squad/735933.html",:team_name => "Kolkata Knight Riders"},
  :mi =>  {:url => "http://www.espncricinfo.com/indian-premier-league-2014/content/squad/735935.html",:team_name => "Mumbai Indians"},
  :rr =>  {:url => "http://www.espncricinfo.com/indian-premier-league-2014/content/squad/735937.html",:team_name => "Rajasthan Royals"},
  :rcb => {:url => "http://www.espncricinfo.com/indian-premier-league-2014/content/squad/735977.html",:team_name => "Royal Challengers Bangalore"},
  :srh =>  {:url => "http://www.espncricinfo.com/indian-premier-league-2014/content/squad/735985.html",:team_name => "Sunrise Hyderabad"}   
  }

file = File.new("teams", "w")

teams.each do |team|  
  file.puts "=========================================="
  file.puts team[0].to_s.upcase + ": " + team[1][:team_name]
  file.puts "=========================================="
  
  curr_team = team[0].to_s
  curr_url = team[1][:url]
    
# Scraping begin  
  team_data = Nokogiri::HTML(open(curr_url))
  players = team_data.css('.ciPhotoContainer table')

#Printing player names  
  file.puts " "
  puts "Getting players from " + team[1][:team_name]
  
  players.each do |player|    
    player_name = player.at_css('.ciHOFplayer').text     #print name of the player
    file.puts player_name
  end

  file.puts " "
end

file.close