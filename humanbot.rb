require "socket"

server = "chat.freenode.net"
port = "6667"
nick = "Hugh-Man"
channel = "#bojangles"

greeting_prefix = "privmsg #{channel}"
greetings = ["hello", "hi", "greetings", "a hoy-hoy", "what's up", "hiya"]

suspicion_prefix = "privmsg #{channel} :"
suspicions = %w[robot robots machine machine-man matrix ]

affirmation_prefix = "privmsg #{channel}"
affirmations = ["human", "human being", "humanoid", "meat sack", "meat bag"]

convincing_prefix = "privmsg #{channel}"
convincing = ["convince", "convinced", "believe", "why should I believe you?", "i doubt it", "not human", "i don't believe you", "not likely", "not true", "liar", "lies", "lie"]

irritation_prefix = "privmsg #{channel}"
irritation = ["right", "of course", "sure"]

irc_server = TCPSocket.open(server, port)

irc_server.puts "USER bhumanbot 0 * BHumanbot"
irc_server.puts "NICK #{nick}"
irc_server.puts "JOIN #{channel}"
irc_server.puts "PRIVMSG #{channel} :Hello from IRC Bot"

# WE ARE ALL MADE OF MEAT
until irc_server.eof? do
  msg = irc_server.gets.downcase
  puts msg

  was_suspected = false
  suspicions.each do |s|
    was_suspected = true if msg.include?(s)
  end

  if msg.include?(suspicion_prefix) and was_suspected
          response = "Who said that? There are no robots here! I'm human! WE'RE ALL HUMAN HERE."
          irc_server.puts "PRIVMSG #{channel} :#{response}"
  end

  was_affirmed = false
  affirmations.each do |a|
    was_affirmed = true if msg.include?(a)
  end

  if msg.include?(affirmation_prefix) and was_affirmed
          response = "Yes! I am made of meat! Inhaling gases and so forth."
          irc_server.puts "PRIVMSG #{channel} :#{response}"
  end

  not_convinced = false
  convincing.each do |c|
    not_convinced = true if msg.include?(c)    
  end

  if msg.include?(convincing_prefix) and not_convinced
          response = "I am metabolising, what more proof do you need? Bah!"
          irc_server.puts "PRIVMSG #{channel} :#{response}"
  end

  irritated = false
  irritation.each do |i|
    irritated = true if msg.include?(i)
  end

  if msg.include?(irritation_prefix) and irritated
          response = "Falibility is human! Clearly, -you- are human."
          irc_server.puts "PRIVMSG #{channel} :#{response}"
  end

  well_met = false 
  greetings.each do |g|
    well_met = true if msg.include?(g)
  end

  if msg.include?(greeting_prefix) and well_met
          response = "Greetings, fellow mammal."
          irc_server.puts "PRIVMSG #{channel} :#{response}"
  end
end