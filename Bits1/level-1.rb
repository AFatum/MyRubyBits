#---    1. Unless
games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
if !games.empty?
  puts "Games in your vast collection: #{games.count}"
end

# **********************- my answer
games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
unless games.empty?
  puts "Games in your vast collection: #{games.count}"
end

#---    2. Inline Statements
games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
unless games.empty?
  puts "Games in your vast collection: #{games.count}"
end

# **********************- my answer
games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
    puts "Games in your vast collection: #{games.count}" unless games.empty?

#---    3. Implied nil
search = "Contra"
games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
search_index = games.find_index(search)
if search_index != nil
  puts "Game #{search} Found: #{games[search_index]} at index #{search_index}."
else
  puts "Game #{search} not found."
end

# **********************- my answer
search = "Contra"
games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
search_index = games.find_index(search)
if search_index
  puts "Game #{search} Found: #{games[search_index]} at index #{search_index}."
else
  puts "Game #{search} not found."
end

#---    4. Short-Circuit And
search = "Super Mario Bros."
games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
matched_games = games.grep(Regexp.new(search))

# Found an exact match
if matched_games.length > 0
  if matched_games.include?(search)
    puts "Game #{search} found."
  end
end

# **********************- my answer
search = "Super Mario Bros."
games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
matched_games = games.grep(Regexp.new(search))

# Found an exact match
if matched_games.length > 0 && matched_games.include?(search)
    puts "Game #{search} found."
end

#---    5. Conditional Assignment
search = "" unless search
games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
matched_games = games.grep(Regexp.new(search))
puts "Found the following games..."
matched_games.each do |game|
  puts "- #{game}"
end

# **********************- my answer
search ||= ""
games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
matched_games = games.grep(Regexp.new(search))
puts "Found the following games..."
matched_games.each do |game|
  puts "- #{game}"
end

#---    6. Conditional Return I
search = "Contra"
games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
search_index = games.find_index(search)
if search_index
  search_result = "Game #{search} found: #{games[search_index]} at index #{search_index}."
else
  search_result = "Game #{search} not found."
end
puts search_result

# **********************- my answer
search = "Contra"
games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
search_index = games.find_index(search)
search_result = if search_index
  "Game #{search} found: #{games[search_index]} at index #{search_index}."
else
  "Game #{search} not found."
end
puts search_result

#---    6. Conditional Return II
def search(games, search_term)
  search_index = games.find_index(search_term)
  search_result = if search_index
    "Game #{search_term} found: #{games[search_index]} at index #{search_index}."
  else
    "Game #{search_term} not found."
  end
  return search_result
end

games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
puts search(games, "Contra")

# **********************- my answer
def search(games, search_term)
  search_index = games.find_index(search_term)
  if search_index
    "Game #{search_term} found: #{games[search_index]} at index #{search_index}."
  else
    "Game #{search_term} not found."
  end
end

games = ["Super Mario Bros.", "Contra", "Metroid", "Mega Man 2"]
puts search(games, "Contra")

#---    7. Short-Circuit Evaluation
def search_index(games, search_term)
  search_index = games.find_index(search_term)

  if search_index
    search_index
  else
    "Not Found"
  end
end

# **********************- my answer
def search_index(games, search_term)
  search_index = games.find_index(search_term) || "Not Found"
end